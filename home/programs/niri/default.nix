{
  inputs,
  nixosConfig,
  ...
}: let
  colors = inputs.basix.schemeData.base16.${nixosConfig.style.scheme}.palette;
in {
  imports = [./binds.nix];
  programs.niri = {
    settings = {
      environment = {
        "NIXOS_OZONE_WL" = "1";
        "DISPLAY" = ":0";
        "_JAVA_AWT_WM_NONREPARENTING" = "1"; # https://wiki.archlinux.org/title/Sway#Java_applications
      };

      prefer-no-csd = true;

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

      input.keyboard.xkb = {
        layout = "us";
        options = "compose:ralt";
      };

      layout = {
        focus-ring = {
          enable = true;
          active.color = "#${colors.base0E}";
        };

        center-focused-column = "always";
        always-center-single-column = true;
      };
      spawn-at-startup = [{command = ["xwayland-satellite"];}];
    };
  };
}
