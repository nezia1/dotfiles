{ inputs, pkgs, ... }:
{
  imports = [./hyprlock.nix];
  wayland.windowManager.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.system}.hyprland;
    settings = {
      "$mod" = "SUPER";
      "$terminal" = "kitty"; "$menu" = "fuzzel";
      "monitor" = "eDP-1, 2256x1504@60, 0x0, 1.6";
      input.touchpad.natural_scroll = true;
      gestures.workspace_swipe = true;
      xwayland.force_zero_scaling = true;
      bind =
        [
          "$mod, Return, exec, $terminal"
          "$mod, R, exec, $menu"
          "$mod, F, exec, firefox"
          "$mod, Q, killactive"
          "$mod, M, exit"
          "$mod, H, movefocus, l"
          "$mod, L, movefocus, r"
          "$mod, K, movefocus, u"
          "$mod, J, movefocus, d"
          ", Print, exec, grimblast copy area"
        ]
        ++ (
          # workspaces
          # binds $mod + [shift +] {1..9} to [move to] workspace {1..9}
          builtins.concatLists (builtins.genList (i:
            let ws = i + 1;
            in [
              "$mod, code:1${toString i}, workspace, ${toString ws}"
              "$mod SHIFT, code:1${toString i}, movetoworkspace, ${toString ws}"
            ]
          )
            9)
        );
    };
  };

  services.hyprpaper = {
    enable = true;
    package = inputs.hyprpaper.packages.${pkgs.stdenv.hostPlatform.system}.hyprpaper;
    settings = {
      wallpaper = [
        ",${../../../wallpapers/nix-wallpaper-nineish-catppuccin-frappe-alt.svg}"
      ];
    };
  };

  programs.fuzzel.enable = true;

  home.packages = with inputs.hyprland-contrib.packages.${pkgs.system}; [
    grimblast
  ];
}
