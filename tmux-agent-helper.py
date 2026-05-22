#!/usr/bin/env python3
import os
import sys
import json
import re
import subprocess
import time

STATE_FILE = os.path.expanduser("~/.tmux-agent-sessions.json")

def run_cmd(cmd):
    try:
        res = subprocess.run(cmd, shell=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE, text=True)
        return res.stdout.strip()
    except Exception as e:
        return ""

def get_tmux_panes():
    # Format: session_name \t window_index \t window_name \t pane_index \t pane_id \t pane_tty \t pane_current_path \t pane_title
    fmt = '#{session_name}\t#{window_index}\t#{window_name}\t#{pane_index}\t#{pane_id}\t#{pane_tty}\t#{pane_current_path}\t#{pane_title}'
    out = run_cmd(f"tmux list-panes -a -F '{fmt}'")
    panes = []
    for line in out.splitlines():
        if not line:
            continue
        parts = line.split('\t')
        if len(parts) >= 8:
            panes.append({
                "session_name": parts[0],
                "window_index": parts[1],
                "window_name": parts[2],
                "pane_index": parts[3],
                "pane_id": parts[4],
                "tty": parts[5],
                "cwd": parts[6],
                "pane_title": parts[7]
            })
    return panes

def get_pane_title(pane_id):
    out = run_cmd(f"tmux show-options -p -t '{pane_id}' @pane_title")
    # Output matches: @pane_title "value" or @pane_title value
    match = re.match(r'@pane_title\s+"(.*)"', out)
    if match:
        return match.group(1)
    match = re.match(r'@pane_title\s+(.*)', out)
    if match:
        return match.group(1)
    return None

def get_pane_process(tty):
    tty_short = tty.replace("/dev/", "")
    out = run_cmd(f"ps -o pid,ppid,command -t {tty_short}")
    processes = []
    lines = out.splitlines()
    if len(lines) <= 1:
        return None
    
    for line in lines[1:]:
        line = line.strip()
        if not line:
            continue
        parts = line.split(None, 2)
        if len(parts) >= 3:
            pid, ppid, cmd = parts[0], parts[1], parts[2]
            processes.append({"pid": int(pid), "ppid": int(ppid), "command": cmd})
            
    ignored_patterns = re.compile(
        r'^(-?(fish|zsh|bash|sh|tmux|ps)|ps|lsof|python3? -m pytest|npm run|npm start|node .next)', 
        re.IGNORECASE
    )
    
    active_procs = []
    for p in processes:
        cmd_base = os.path.basename(p["command"].split()[0])
        if not ignored_patterns.match(cmd_base):
            active_procs.append(p)
            
    if active_procs:
        return active_procs[-1]
    return None

def get_full_command(pid):
    out = run_cmd(f"ps -ww -p {pid} -o command")
    lines = out.splitlines()
    if len(lines) > 1:
        return lines[1].strip()
    return ""

def get_resume_info(pid, command_str):
    cmd_lower = command_str.lower()
    
    # 1. AIDER
    if 'aider' in cmd_lower:
        return {
            "agent_type": "aider",
            "resume_command": "aider"
        }
        
    # 2. COPILOT
    if 'copilot' in cmd_lower:
        match = re.search(r'--resume=([^\s]+)', command_str)
        if match:
            return {
                "agent_type": "copilot",
                "session_id": match.group(1),
                "resume_command": f"copilot --resume={match.group(1)}"
            }
        lsof_out = run_cmd(f"lsof -Fn -p {pid}")
        if lsof_out:
            for line in lsof_out.splitlines():
                if line.startswith('n') and '.copilot/session-state' in line:
                    session_match = re.search(r'session-([a-f0-9\-]+)', line)
                    if session_match:
                        sid = session_match.group(1)
                        return {
                            "agent_type": "copilot",
                            "session_id": sid,
                            "resume_command": f"copilot --resume={sid}"
                        }
        return {
            "agent_type": "copilot",
            "resume_command": "copilot --continue"
        }
        
    # 3. ANTIGRAVITY / AGY / GEMINI
    if any(x in cmd_lower for x in ['agy', 'antigravity', 'gemini']):
        match = re.search(r'--conversation\s+([^\s]+)', command_str)
        if match:
            return {
                "agent_type": "agy",
                "session_id": match.group(1),
                "resume_command": f"agy --conversation {match.group(1)}"
            }
        lsof_out = run_cmd(f"lsof -Fn -p {pid}")
        if lsof_out:
            for line in lsof_out.splitlines():
                if line.startswith('n') and '.gemini/antigravity' in line:
                    uuid_match = re.search(r'brain/([a-f0-9\-]+)', line)
                    if uuid_match:
                        sid = uuid_match.group(1)
                        return {
                            "agent_type": "agy",
                            "session_id": sid,
                            "resume_command": f"agy --conversation {sid}"
                        }
        return {
            "agent_type": "agy",
            "resume_command": "agy -c"
        }
        
    # 4. AGENCY
    if 'agency' in cmd_lower:
        return {
            "agent_type": "agency",
            "resume_command": "agency"
        }

    # Generic check for other agent tools (e.g. codex)
    for pattern in ['codex']:
        if pattern in cmd_lower:
            return {
                "agent_type": pattern,
                "resume_command": command_str
            }
            
    return None

def do_save():
    print("Scanning tmux panes for active agent sessions, window names, and pane titles...")
    panes = get_tmux_panes()
    pane_states = []
    
    for pane in panes:
        custom_pane_title = get_pane_title(pane["pane_id"])
        
        proc = get_pane_process(pane["tty"])
        info = None
        if proc:
            pid = proc["pid"]
            full_cmd = get_full_command(pid)
            if not full_cmd:
                full_cmd = proc["command"]
            info = get_resume_info(pid, full_cmd)
            
        # Save state for ALL panes
        session_entry = {
            "session_name": pane["session_name"],
            "window_index": pane["window_index"],
            "window_name": pane["window_name"],
            "pane_index": pane["pane_index"],
            "pane_id": pane["pane_id"],
            "cwd": pane["cwd"],
            "pane_title": pane["pane_title"],
            "custom_pane_title": custom_pane_title,
            "agent_type": info["agent_type"] if info else None,
            "session_id": info.get("session_id") if info else None,
            "resume_command": info["resume_command"] if info else None
        }
        pane_states.append(session_entry)
        
        log_parts = []
        log_parts.append(f"window: '{pane['window_name']}'")
        if pane["pane_title"]:
            log_parts.append(f"title: '{pane['pane_title']}'")
        if custom_pane_title:
            log_parts.append(f"custom_title: '{custom_pane_title}'")
        if info:
            log_parts.append(f"agent: {info['agent_type']} ('{info['resume_command']}')")
            
        print(f"Saved state for pane {pane['session_name']}:{pane['window_name']}.{pane['pane_index']} -> {', '.join(log_parts)}")
                
    with open(STATE_FILE, 'w') as f:
        json.dump(pane_states, f, indent=2)
    print(f"Saved {len(pane_states)} pane states to {STATE_FILE}")

def do_restore():
    if not os.path.exists(STATE_FILE):
        print(f"No saved state file found at {STATE_FILE}. Skipping.")
        return
        
    with open(STATE_FILE, 'r') as f:
        sessions = json.load(f)
        
    if not sessions:
        print("No pane states to restore.")
        return
        
    print(f"Restoring {len(sessions)} pane states in 2 seconds...")
    time.sleep(2)  # Wait for tmux and shells to fully initialize
    
    for s in sessions:
        # Build tmux target pane path
        target = f"{s['session_name']}:{s['window_index']}.{s['pane_index']}"
        
        # Verify if pane exists
        pane_exists = run_cmd(f"tmux has-session -t {s['session_name']} 2>/dev/null && tmux list-panes -t {s['session_name']}:{s['window_index']} -F '#{{pane_index}}' 2>/dev/null")
        if not pane_exists or s['pane_index'] not in pane_exists.splitlines():
            # Fallback to match by window name instead of window index
            target = f"{s['session_name']}:{s['window_name']}.{s['pane_index']}"
            pane_exists = run_cmd(f"tmux has-session -t {s['session_name']} 2>/dev/null && tmux list-panes -t {s['session_name']}:{s['window_name']} -F '#{{pane_index}}' 2>/dev/null")
            if not pane_exists or s['pane_index'] not in pane_exists.splitlines():
                print(f"Pane {target} not found. Skipping.")
                continue
                
        # 1. Restore Window Name
        if s.get("window_name"):
            window_target = f"{s['session_name']}:{s['window_index']}"
            print(f"Restoring window name for {window_target} -> '{s['window_name']}'")
            window_name_escaped = s["window_name"].replace("'", "'\\''")
            run_cmd(f"tmux rename-window -t '{window_target}' '{window_name_escaped}'")

        # 2. Restore Standard Pane Title
        if s.get("pane_title"):
            print(f"Restoring standard title to {target} -> '{s['pane_title']}'")
            title_escaped = s["pane_title"].replace("'", "'\\''")
            run_cmd(f"tmux select-pane -t '{target}' -T '{title_escaped}'")

        # 3. Restore Custom Pane Title
        if s.get("custom_pane_title"):
            print(f"Restoring custom @pane_title to {target} -> '{s['custom_pane_title']}'")
            custom_title_escaped = s["custom_pane_title"].replace("'", "'\\''")
            run_cmd(f"tmux set-option -p -t '{target}' @pane_title '{custom_title_escaped}'")
            
        # 4. Restore Agent CLI Session
        if s.get("agent_type") and s.get("resume_command"):
            # Optional check: make sure the pane is not already running a command
            tty_out = run_cmd(f"tmux display-message -t '{target}' -p '#{{pane_tty}}' 2>/dev/null")
            if tty_out:
                active_proc = get_pane_process(tty_out)
                if active_proc:
                    print(f"Pane {target} is busy running process {active_proc['command']}. Skipping command injection.")
                    continue
                    
            resume_cmd = s["resume_command"]
            print(f"Restoring agent {s['agent_type']} in pane {target} -> {resume_cmd}")
            # C-u clears standard shells line, then we run the command
            run_cmd(f"tmux send-keys -t '{target}' C-u '{resume_cmd}' C-m")

def main():
    if len(sys.argv) < 2:
        print("Usage: tmux-agent-helper.py [save|restore]")
        sys.exit(1)
        
    action = sys.argv[1]
    if action == "save":
        do_save()
    elif action == "restore":
        do_restore()
    else:
        print(f"Unknown action: {action}")
        sys.exit(1)

if __name__ == "__main__":
    main()
