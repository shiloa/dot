---
name: handover
description: End-of-session handover. Survey what actually happened this session, keep only the load-bearing 5% for the next session, optionally update durable memory/notes, and print a short structured handover note. Use when the user prompts `/handover` or asks to wrap up, sign off, hand off, or close out a working session.
---

# Handover Skill

Run this at the end of a working session. Goal: filter aggressively. Most of a session is forgettable execution. Preserve only the small slice that future-me needs to resume cold. The final note must be readable in under 30 seconds.

## Operating principle

You are a filter, not a logger. Default to leaving things out. A fact earns a place in the handover only if dropping it would cost the next session real time or cause a wrong assumption. When unsure whether something is load-bearing, leave it out.

Load-bearing (keep): decisions and their rationale, constraints discovered, half-finished work and its exact state, footguns hit, surprising state, things that contradict the obvious assumption.

Noise (drop): routine edits, passing tests, successful builds, file navigation, tool output, anything fully captured by a commit message, anything the next session would rediscover in seconds.

## Procedure

### 1. Survey what actually happened

Run these read-only checks first. Do not narrate each one; gather, then think.

- `git status --short` and `git --no-pager diff --stat` — uncommitted changes.
- `git --no-pager log --oneline --since="<session start>"` — commits this session. If the session start is unknown, fall back to `--since="12 hours ago"` or the last 10 commits, whichever is tighter, and state the window you used.
- `git --no-pager diff` (and `git --no-pager diff --staged`) — inspect uncommitted work enough to describe it, not to review it.
- Current branch and whether it's ahead/behind its upstream.
- Session todos: query the session SQL `todos` table (or the active plan.md) for `done` vs `in_progress`/`blocked`/`pending`. Treat anything not `done` as potentially in-flight.

If this is not a git repo, say so and base the survey on todos, plan.md, changed files, and the conversation.

### 2. Identify what's load-bearing

From the survey plus the session conversation, extract only what matters for the next session. For each candidate ask: would the next session waste time or make a wrong call without this? If no, drop it. Collapse related items. Prefer one sharp sentence over three vague ones.

### 3. Update durable memory or notes (only the durable parts)

Detect a local memory/notes file in the repo first. Check, in order, the repo root and obvious doc locations for files such as: `HANDOVER.md`, `HANDOVER_NOTES.md`, `NOTES.md`, `MEMORY.md`, `AGENTS.md`, `.notes/`, `docs/NOTES.md`, or a path the user has pointed you to before in this session.

- If a local memory/notes file exists: update only the entries future-me will need (durable decisions, constraints, open threads). Do not append a daily activity log. Edit in place, keep it terse, and remove anything the update makes stale. Show the diff of what you changed.
- If none exists: ask the user whether to (a) create a local notes file in this repo, (b) write the durable items to global Copilot persistent memory via the memory tool, or (c) skip persistence for this session. Do not create files or write global memory without that choice.

When writing to global Copilot memory, store only durable, reusable facts (constraints, decisions, conventions). Never store routine session activity.

Persist nothing that is pure execution noise, regardless of target.

### 4. Handle uncommitted changes

If there are uncommitted changes that look worth committing, ask before committing. Propose a concise commit message (and whether to stage all or a subset). Never commit, push, or discard without explicit approval. If the user declines, leave the working tree untouched and note the uncommitted state under "Still in flight."

### 5. Print the handover note

End with this exact structure. Keep the whole thing scannable in under 30 seconds. Use tight bullets. Omit a section's bullets only if genuinely empty (keep the heading, write "Nothing"). Lead each bullet with the fact, not preamble.

```
## Handover — <repo/branch> — <date>

### Shipped this session
- <commits, deploys, decisions, reports, merged PRs — what's now done and durable>

### Still in flight
- <half-finished work, with enough context for a cold reader: what, where, next step, why it stopped>

### Watch-outs
- <gotchas, surprising state, broken assumptions, footguns hit>

### Open questions for you
- <decisions or inputs you need from me before the next session>
```

## Style

Follow the user's global writing rules: lead with the answer, cut filler, no hyperbole, no corporate speak, no em-dashes. The note is for one reader (future-me) who is in a hurry. If a bullet doesn't change what the next session does, delete it.
