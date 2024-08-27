{ pkgs, lib, ... }:

{
  stylix.enable = true;
  stylix.polarity = "dark";
  stylix.image = lib.mkDefault ../wallpapers/nix-wallpaper-nineish-catppuccin-frappe-alt.svg;
  stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-frappe.yaml";
  stylix.autoEnable = true;

  stylix.cursor = {
    name = "Adwaita";
    package = pkgs.adwaita-icon-theme;
    size = 24;
  };
  stylix.fonts = {
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
      applications = 11;
      desktop = 10;
    };
  };
}
