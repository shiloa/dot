local wezterm = require 'wezterm'
local act = wezterm.action

return {
    -- BiDi (the whole reason we're here)
    bidi_enabled = true,
    bidi_direction = 'AutoLeftToRight',

    -- Font with Hebrew fallback (Regular weight + crisp FreeType rendering)
    font = wezterm.font_with_fallback({
      { family = 'UbuntuMono Nerd Font', weight = 'Regular' },
      { family = 'JetBrains Mono',       weight = 'Medium'  },
      { family = 'Heebo',                weight = 'Medium'  },
      { family = 'Menlo',                weight = 'Regular' },
    }),
    font_size = 22,
    bold_brightens_ansi_colors = true,

    -- Crisp rendering: light hinting + subpixel anti-aliasing
    freetype_load_target = 'Light',
    freetype_render_target = 'HorizontalLcd',
    font_antialias = 'Subpixel',
    font_hinting = 'Full',

    -- Appearance: iTerm2-style — pure black bg, white fg, classic ANSI palette
    colors = {
      foreground = '#ffffff',
      background = '#000000',
      cursor_bg  = '#ffffff',
      cursor_fg  = '#000000',
      cursor_border = '#ffffff',
      selection_bg = '#3a3a3a',
      selection_fg = '#ffffff',

      ansi = {
        '#000000', -- black
        '#c91b00', -- red
        '#00c200', -- green
        '#c7c400', -- yellow
        '#0225c7', -- blue
        '#c930c7', -- magenta
        '#00c5c7', -- cyan
        '#c7c7c7', -- white
      },
      brights = {
        '#676767', -- bright black
        '#ff6d67', -- bright red
        '#5ff967', -- bright green
        '#fefb67', -- bright yellow
        '#6871ff', -- bright blue
        '#ff76ff', -- bright magenta
        '#5ffdff', -- bright cyan
        '#feffff', -- bright white
      },

      tab_bar = {
        background = '#000000',
        active_tab = {
          bg_color = '#000000',
          fg_color = '#ffffff',
          intensity = 'Bold',
        },
        inactive_tab = {
          bg_color = '#000000',
          fg_color = '#808080',
        },
        inactive_tab_hover = {
          bg_color = '#1c1c1c',
          fg_color = '#ffffff',
        },
        new_tab = {
          bg_color = '#000000',
          fg_color = '#808080',
        },
        new_tab_hover = {
          bg_color = '#1c1c1c',
          fg_color = '#ffffff',
        },
      },
    },

    use_fancy_tab_bar = false,
    tab_bar_at_bottom = true,
    hide_tab_bar_if_only_one_tab = false,
    window_decorations = 'RESIZE',
    window_padding = { left = 4, right = 4, top = 4, bottom = 0 },
    window_background_opacity = 1.0,
    macos_window_background_blur = 0,

    -- tmux-style prefix: Ctrl-b
    leader = { key = 'b', mods = 'CTRL', timeout_milliseconds = 2000 },

    keys = {
        -- Pane splits (tmux: % vsplit, " hsplit)
        { key = '%',          mods = 'LEADER', action = act.SplitHorizontal { domain = 'CurrentPaneDomain' } },
        { key = '"',          mods = 'LEADER', action = act.SplitVertical { domain = 'CurrentPaneDomain' } },

        -- Pane nav (vim h/j/k/l)
        { key = 'h',          mods = 'LEADER', action = act.ActivatePaneDirection 'Left' },
        { key = 'j',          mods = 'LEADER', action = act.ActivatePaneDirection 'Down' },
        { key = 'k',          mods = 'LEADER', action = act.ActivatePaneDirection 'Up' },
        { key = 'l',          mods = 'LEADER', action = act.ActivatePaneDirection 'Right' },

        -- Pane nav (arrow keys, matches tmux default)
        { key = 'LeftArrow',  mods = 'LEADER', action = act.ActivatePaneDirection 'Left' },
        { key = 'DownArrow',  mods = 'LEADER', action = act.ActivatePaneDirection 'Down' },
        { key = 'UpArrow',    mods = 'LEADER', action = act.ActivatePaneDirection 'Up' },
        { key = 'RightArrow', mods = 'LEADER', action = act.ActivatePaneDirection 'Right' },

        -- Pane resize (capital HJKL)
        { key = 'H',          mods = 'LEADER', action = act.AdjustPaneSize { 'Left', 5 } },
        { key = 'J',          mods = 'LEADER', action = act.AdjustPaneSize { 'Down', 5 } },
        { key = 'K',          mods = 'LEADER', action = act.AdjustPaneSize { 'Up', 5 } },
        { key = 'L',          mods = 'LEADER', action = act.AdjustPaneSize { 'Right', 5 } },

        -- Tabs ≈ tmux windows
        { key = 'c',          mods = 'LEADER', action = act.SpawnTab 'CurrentPaneDomain' },
        { key = 'n',          mods = 'LEADER', action = act.ActivateTabRelative(1) },
        { key = 'p',          mods = 'LEADER', action = act.ActivateTabRelative(-1) },
        { key = '1',          mods = 'LEADER', action = act.ActivateTab(0) },
        { key = '2',          mods = 'LEADER', action = act.ActivateTab(1) },
        { key = '3',          mods = 'LEADER', action = act.ActivateTab(2) },
        { key = '4',          mods = 'LEADER', action = act.ActivateTab(3) },
        { key = '5',          mods = 'LEADER', action = act.ActivateTab(4) },
        { key = '6',          mods = 'LEADER', action = act.ActivateTab(5) },
        { key = '7',          mods = 'LEADER', action = act.ActivateTab(6) },
        { key = '8',          mods = 'LEADER', action = act.ActivateTab(7) },
        { key = '9',          mods = 'LEADER', action = act.ActivateTab(8) },

        -- Zoom pane (tmux: prefix z)
        { key = 'z',          mods = 'LEADER', action = act.TogglePaneZoomState },

        -- Copy mode (tmux: prefix [)
        { key = '[',          mods = 'LEADER', action = act.ActivateCopyMode },

        -- Paste (tmux: prefix ])
        { key = ']',          mods = 'LEADER', action = act.PasteFrom 'Clipboard' },

        -- Kill pane (tmux: prefix x)
        { key = 'x',          mods = 'LEADER', action = act.CloseCurrentPane { confirm = true } },

        -- Workspaces ≈ tmux sessions (detach/switch)
        { key = 'd',          mods = 'LEADER', action = act.DetachDomain 'CurrentPaneDomain' },
        { key = 's',          mods = 'LEADER', action = act.ShowLauncherArgs { flags = 'WORKSPACES' } },

        -- Rename tab (tmux: prefix ,)
        {
            key = ',',
            mods = 'LEADER',
            action = act.PromptInputLine {
                description = 'Tab title:',
                action = wezterm.action_callback(function(window, _, line)
                    if line then window:active_tab():set_title(line) end
                end),
            },
        },

        -- Reload config (tmux: prefix r)
        { key = 'r', mods = 'LEADER',      action = act.ReloadConfiguration },

        -- Pass-through: literal Ctrl-b to the inner program
        { key = 'b', mods = 'LEADER|CTRL', action = act.SendKey { key = 'b', mods = 'CTRL' } },
    },
}
