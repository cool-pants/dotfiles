local wezterm = require 'wezterm'

keybinds = {
  -- Set Leader [The chad leader key, allows better key combinations]
  leader = {key="`", mods="CTRL", timeout_milliseconds=1000},
  
  keys = {

    -- Some leader key magic only uncomment if you set leader to character key[in this case it is CTRL+a]
    -- { key="`", mods="LEADER", action=wezterm.action{SendString=" "} },

    -- Window Split bindings
    { key="DownArrow", mods="ALT|SHIFT", 
        action=wezterm.action{SplitVertical={domain="CurrentPaneDomain"}} },
    { key="RightArrow", mods="ALT|SHIFT", 
        action=wezterm.action{SplitHorizontal={domain="CurrentPaneDomain"}} },
    { key="w", mods="CTRL|SHIFT",
        action = wezterm.action{CloseCurrentPane={confirm=true}}},

    -- Split Nav
    { key="LeftArrow",  mods="ALT", action=wezterm.action{ActivatePaneDirection="Left"} },
    { key="UpArrow",    mods="ALT", action=wezterm.action{ActivatePaneDirection="Up"} },
    { key="DownArrow",  mods="ALT", action=wezterm.action{ActivatePaneDirection="Down"} },
    { key="RightArrow", mods="ALT", action=wezterm.action{ActivatePaneDirection="Right"} },

    -- Tab Bindings
    { key="t", mods="LEADER", action=wezterm.action{SpawnTab="CurrentPaneDomain"} },
    { key="T", mods="LEADER", action=wezterm.action{SpawnTab="DefaultDomain"} },
    { key="w", mods="LEADER", action=wezterm.action{CloseCurrentTab={confirm=true}} },

    -- Tab movements
    { key="LeftArrow", mods="CTRL", action=wezterm.action{ActivateTabRelative=-1} },
    { key="RightArrow", mods="CTRL", action=wezterm.action{ActivateTabRelative=1} },

    -- Disable default bindings
    { key="\"", mods="CTRL|SHIFT|ALT", action="DisableDefaultAssignment" },
    { key="%", mods="CTRL|SHIFT|ALT", action="DisableDefaultAssignment" },
    
    { key="LeftArrow",  mods="CTRL|SHIFT", action="DisableDefaultAssignment" },
    { key="UpArrow",    mods="CTRL|SHIFT", action="DisableDefaultAssignment" },
    { key="DownArrow",  mods="CTRL|SHIFT", action="DisableDefaultAssignment" };
    { key="RightArrow", mods="CTRL|SHIFT", action="DisableDefaultAssignment" },
  },
}

return keybinds
