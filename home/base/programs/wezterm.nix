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
        font = wezterm.font_with_fallback {
          { family = "MonaspiceNe Nerd Font",
            harfbuzz_features = {
              'calt',
              'liga',
              'ss01', -- ligatures related to the equals glyph like != and ===.
              'ss02', -- ligatures related to the greater than or less than operators.
              'ss03', -- ligatures related to arrows like -> and =>.
              'ss04', -- ligatures related to markup, like </ and />.
              'ss05', -- ligatures related to the F# programming language, like |>.
              'ss06', -- ligatures related to repeated uses of # such as ## or ###.
              'ss07', -- ligatures related to the asterisk like ***.
              'ss08', -- ligatures related to combinations like .= or .-.
              'ss09', -- ligatures related to combinations of the greater/less than and equals signs, like <=>,>>, and =<<.
            }
          }
        }
      }
    '';
  };
}
