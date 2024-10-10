{
  inputs,
  lib,
  pkgs,
  osConfig,
  ...
}: let
  colors = inputs.basix.schemeData.base16.${osConfig.style.scheme}.palette;
in {
  imports = [./binds.nix];

  programs.niri = {
    settings = {
      input.keyboard.xkb = {
        layout = "us";
        options = "compose:ralt";
      };

      prefer-no-csd = true;
      hotkey-overlay.skip-at-startup = true;

      layout = {
        focus-ring = {
          enable = true;
          active.color = "#${colors.base0E}";
        };
        always-center-single-column = true;
      };

      window-rules = [
        {
          draw-border-with-background = false;
          geometry-corner-radius = let
            r = 8.0;
          in {
            top-left = r;
            top-right = r;
            bottom-left = r;
            bottom-right = r;
          };
          clip-to-geometry = true;
        }
        {
          matches = [
            {app-id = "foot";}
          ];
          default-column-width = {proportion = 0.5;};
        }
      ];

      environment = {
        "NIXOS_OZONE_WL" = "1";
        "DISPLAY" = ":0";
        "_JAVA_AWT_WM_NONREPARENTING" = "1"; # https://wiki.archlinux.org/title/Sway#Java_applications
      };
    };
  };

  # copied from https://github.com/linyinfeng/dotfiles/blob/c00fe3b1562ad947672863a43e455bc2f01a56b6/home-manager/profiles/niri/default.nix#L594-L611
  systemd.user.services.xwayland-satellite = {
    Unit = {
      PartOf = ["graphical-session.target"];
      After = ["graphical-session.target"];
      Requisite = ["graphical-session.target"];
    };
    Install = {
      WantedBy = ["niri.service"];
    };
    Service = {
      Type = "simple";
      ExecStart = "${lib.getExe pkgs.xwayland-satellite} :0";
      NotifyAccess = "all";
      StandardOutput = "journal";
      Restart = "on-failure";
    };
  };
}
