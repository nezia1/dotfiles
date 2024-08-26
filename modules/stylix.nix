{ pkgs, ... }:

{
  stylix.enable = true;
  stylix.image = ../lucy.jpg;
  stylix.polarity = "dark";
  stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-frappe.yaml";
  stylix.autoEnable = true;

  stylix.cursor = {
    name = "Adwaita";
    package = pkgs.adwaita-icon-theme;
    size = 24;
  };
  stylix.fonts = {
    monospace = {
      package = pkgs.nerdfonts.override { fonts = [ "Monaspace" ]; };
      name = "MonaspiceNe Nerd Font Mono";
    };
    sizes = {
      terminal = 14;
      applications = 11;
      desktop = 10;
    };
  };
}
