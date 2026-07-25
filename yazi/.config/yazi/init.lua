-- Border around the panes (plugin installed via `ya pkg`)
require("full-border"):setup()

-- Git status signs in the linemode (plugin installed via `ya pkg`)
require("git"):setup()

-- Show owner (user:group) of the hovered file, on the right side of the status bar
Status:children_add(function()
  local h = cx.active.current.hovered
  if h == nil or ya.target_family() ~= "unix" then
    return ""
  end

  return ui.Line {
    ui.Span(ya.user_name(h.cha.uid) or tostring(h.cha.uid)):fg("magenta"),
    ui.Span(":"),
    ui.Span(ya.group_name(h.cha.gid) or tostring(h.cha.gid)):fg("magenta"),
    ui.Span(" "),
  }
end, 500, Status.RIGHT)

-- Show symlink target next to the filename, on the left side of the status bar
Status:children_add(function()
  local h = cx.active.current.hovered
  if h == nil or h.link_to == nil then
    return ""
  end
  return ui.Span(" -> " .. tostring(h.link_to)):italic():fg("darkgray")
end, 3300, Status.LEFT)
