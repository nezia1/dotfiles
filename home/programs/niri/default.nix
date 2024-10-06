{
  inputs,
  config,
  pkgs,
  ...
}: let
  schemeData = inputs.basix.schemeData.base16.${config.theme.scheme};
in {
  imports = [./binds.nix];
  programs.niri = {
    settings = {
      environment."NIXOS_OZONE_WL" = "1";
      prefer-no-csd = true;

      window-rules = [
        {
          matches = [
            {app-id = "foot";}
          ];
          default-column-width = {proportion = 0.5;};
        }
      ];

      layout = {
        border.active = pkgs.lib.rgba schemeData.palette.base0E;
      };
    };
  };
}
