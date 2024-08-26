{ ... }:

{
  programs.wezterm = {
    enable = true;
    extraConfig = ''
      local wezterm = require 'wezterm'

      return {
        font = wezterm.font 'MonaspiceNe Nerd Font',
        front_end = "WebGpu",
        enable_tab_bar = false,
        enable_wayland = false
      }
    '';
  };
}
