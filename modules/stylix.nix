{ config, lib, pkgs, ... }:
let 
  cfg = config.modules.stylix;
in 
  {
  options = {
    modules.stylix = {
      enable = lib.mkEnableOption "Enable the stylix module";
    };
  };
  config = lib.mkIf cfg.enable {
    stylix = {
      enable = true;
      polarity = "dark";
      base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-frappe.yaml";
      cursor = {
        name = "catppuccin-frappe-lavender-cursors";
        package = pkgs.catppuccin-cursors.frappeLavender;
      };
      fonts = {
        serif = {
          package = pkgs.noto-fonts;
          name = "Noto Serif";
        };
        sansSerif = {
          package = pkgs.noto-fonts;
          name = "Noto Sans";
        };
        monospace = {
          package = pkgs.nerdfonts.override { fonts = [ "Monaspace" ]; };
          name = "MonaspiceNe Nerd Font Mono";
        };
        emoji = {
          package = pkgs.noto-fonts-color-emoji;
          name = "Noto Color Emoji";
        };
        sizes = {
          terminal = 14;
          applications = 12;
          desktop = 12;
        };
      };
      image = lib.mkDefault ../wallpapers/nix-wallpaper-nineish-catppuccin-frappe-alt.svg;
    };
  };
}
