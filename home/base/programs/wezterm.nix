{ ... }:

{
  programs.wezterm = {
    enable = true;
    extraConfig = ''
      local wezterm = require 'wezterm'

      return {
        front_end = "WebGpu",
        enable_tab_bar = false,
        enable_wayland = false,
        harfbuzz_features = { "ss01", "ss03" },
      }
    '';
  };
}
