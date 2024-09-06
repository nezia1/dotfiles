{ config, inputs, pkgs, lib, ... }:
let 
  cfg = config.modules.hyprland;
in 
  {
  options = {
    modules.hyprland = {
      enable = lib.mkEnableOption "Enable the hyprland module";
    };
  };
  config = lib.mkIf cfg.enable {
    nix.settings = {
      substituters = ["https://hyprland.cachix.org"];
      trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
    };

      programs.hyprland = {
        enable = true;
        package = inputs.hyprland.packages.${pkgs.system}.hyprland;
        portalPackage = inputs.hyprland.packages.${pkgs.system}.xdg-desktop-portal-hyprland;
      };
  };
}
