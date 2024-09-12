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
        package = pkgs.adwaita-icon-theme;
        name = "Adwaita";
        size = 24;
      };
      fonts = {
        serif = lib.mkDefault {
          package = pkgs.noto-fonts;
          name = "Noto Serif";
        };
        sansSerif = lib.mkDefault {
          package = pkgs.noto-fonts;
          name = "Noto Sans";
        };
        monospace = lib.mkDefault {
          package = pkgs.nerdfonts.override { fonts = [ "IntelOneMono" ]; };
          name = "IntoneMono Nerd Font";
        };
        emoji = {
          package = pkgs.noto-fonts-color-emoji;
          name = "Noto Color Emoji";
        };
        sizes = lib.mkDefault {
          terminal = 14;
          desktop = 14;
          applications = 10;
        };
      };
      targets = {
        gtk.enable = false;
        gnome.enable = false;
      };
      image = lib.mkDefault ../wallpapers/nix-wallpaper-nineish-catppuccin-frappe-alt.svg;
    };
  };
}
