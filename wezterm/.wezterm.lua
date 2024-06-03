local wezterm = require 'wezterm'

return {
  -- font
  font_size = 11,
  font = wezterm.font('JetBrainsMono Nerd Font Mono', { weight = 'Regular', italic = false, style = 'Normal' }),
  -- styling
  color_scheme = 'Catppuccin Mocha (Gogh)',
  window_decorations = 'NONE',
  cell_width = 1,
  -- tabs
  -- don't gray out inactive pane
  inactive_pane_hsb = { saturation = 1.0, brightness = 1.0 },
  tab_bar_at_bottom = true,
  use_fancy_tab_bar = false,
  hide_tab_bar_if_only_one_tab = true,
  switch_to_last_active_tab_when_closing_tab = true,
  -- other
  set_environment_variables = { COLORTERM = 'truecolor'},
  -- quick select
  disable_default_quick_select_patterns = true,
  quick_select_patterns = { '[0-9a-z]{64}' }, -- match sha256 hash
  -- key bindings
  leader = { key='a', mods='CTRL' },
  keys = {
    { key = ' ', mods = 'LEADER', action = wezterm.action.QuickSelect },
    { key = 'c', mods = 'LEADER', action = wezterm.action.SpawnTab 'CurrentPaneDomain' },
    { key = '/', mods = 'LEADER', action = wezterm.action.SplitHorizontal({ domain = 'CurrentPaneDomain' }) },
    { key = '-', mods = 'LEADER', action = wezterm.action.SplitVertical({ domain = 'CurrentPaneDomain' }) },
    { key = "x", mods = "LEADER", action = wezterm.action.CloseCurrentPane({ confirm=true }) },
    { key = 'p', mods = 'LEADER', action = wezterm.action.ActivateTabRelative(-1) },
    { key = 'n', mods = 'LEADER', action = wezterm.action.ActivateTabRelative(1) },
    { key = 'h', mods = 'LEADER', action = wezterm.action{ ActivatePaneDirection='Left'} },
    { key = 'l', mods = 'LEADER', action = wezterm.action{ ActivatePaneDirection='Right'} },
    { key = 'j', mods = 'LEADER', action = wezterm.action{ ActivatePaneDirection='Down'} },
    { key = 'k', mods = 'LEADER', action = wezterm.action{ ActivatePaneDirection='Up'} },
    { key = '1', mods = 'LEADER', action = wezterm.action{ ActivateTab = 0 } },
    { key = '2', mods = 'LEADER', action = wezterm.action{ ActivateTab = 1 } },
    { key = '3', mods = 'LEADER', action = wezterm.action{ ActivateTab = 2 } },
    { key = '4', mods = 'LEADER', action = wezterm.action{ ActivateTab = 3 } },
    { key = '5', mods = 'LEADER', action = wezterm.action{ ActivateTab = 4 } },
    { key = '6', mods = 'LEADER', action = wezterm.action{ ActivateTab = 5 } },
    { key = '7', mods = 'LEADER', action = wezterm.action{ ActivateTab = 6 } },
    { key = '8', mods = 'LEADER', action = wezterm.action{ ActivateTab = 7 } },
    { key = '9', mods = 'LEADER', action = wezterm.action{ ActivateTab = -1 } },
    { key = 'z', mods = 'LEADER', action = 'TogglePaneZoomState' },
    { key = '?', mods = 'LEADER|SHIFT', action = wezterm.action.Search { CaseInSensitiveString = '' } },
  }
}
