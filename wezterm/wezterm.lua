local wezterm = require("wezterm")
local keybinds = require("lua.user.keybindings")

-- Import not working will try to fix later
-- local color_schemes = require("lua.user.colorscheme")

local shell_path = "C:/Program Files/WindowsApps/Microsoft.PowerShell_7.2.1.0_x64__8wekyb3d8bbwe/pwsh.exe"

function basename(s)
  return string.gsub(s, "(.*[/\\])(.*)","%2")
end

wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
  local name = "pwsh"
  local pane = tab.active_pane

  if tab.is_active then
    name = basename(pane.foreground_process_name) .. " " .. pane.pane_id
  end

  return{
    {Text=" " .. name .. " "},
  }
end)

local config = {

  hide_tab_bar_if_only_one_tab = true,

  default_cursor_style = "SteadyBlock",

  -- font face
  font = wezterm.font("mononoki NF"),
  
  -- Color Scheme
  -- color_scheme = "Tokyo Night",

  window_background_opacity = 0.9, 

  inactive_pane_hsb = {
    saturation = 0.9,
    brightness = 0.8,
  },

  colors = {
    tab_bar = {

      background = "#12173B",
      active_tab = {
        bg_color = "#24283B",
        fg_color = "#A9B1D6",

        intensity = "Normal",
        underline = "None",

        italic = true,
      },

      inactive_tab = {
        bg_color = "#606B9E",
        fg_color = "#C7D1FC",

        intensity = "Half"

      },
    },

    foreground = "#A9B1D6",
    background = "#24283B",

    cursor_bg = "#191C29",
    cursor_fg = "#8187A3",
    cursor_border = "#191C29",

    selection_fg = "white",
    selection_bg = "#D9FCFB",

    split = "#000",

    ansi =    {"#32344A", "#F7768E", "#9ECE6A", "#E0AF68", "#7AA2F7", "#AD8EE6", "#449DAB", "#9699A8"},
    brights = {"#444B6A", "#FF7A93", "#B9F27C", "#FF9E64", "#7DA6FF", "#BB9AF7", "#0DB9D7", "#ACB0D0"},
  },

  -- Some Hyperlink mumbo jumbo, yanked from wezterm docs
  hyperlink_rules = {
    -- Linkify things that look like URLs
    -- This is actually the default if you don't specify any hyperlink_rules
    {
      regex = "\\b\\w+://(?:[\\w.-]+)\\.[a-z]{2,15}\\S*\\b",
      format = "$0",
    },

    -- linkify email addresses
    {
      regex = "\\b\\w+@[\\w-]+(\\.[\\w-]+)+\\b",
      format = "mailto:$0",
    },

    -- file:// URI
    {
      regex = "\\bfile://\\S*\\b",
      format = "$0",
    },

    -- Make task numbers clickable
    --[[
    {
      regex = "\\b[tT](\\d+)\\b"
      format = "https://example.com/tasks/?t=$1"
    }
    ]]
  },

  -- Key Bindings
  leader = keybinds.leader,
  keys = keybinds.keys,
  -- Shell Setup
  
  -- set_environment_variables = {
  --   COMSPEC = "C:/Program Files/WindowsApps/Microsoft.PowerShell_7.2.1.0_x64__8wekyb3d8bbwe/pwsh.exe",
  --},

  default_prog = { shell_path, 
                   "-nologo" },


}

return config
