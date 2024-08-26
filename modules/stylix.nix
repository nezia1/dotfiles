{ pkgs, ... }:

{
  stylix.enable = true;
  stylix.image = ../lucy.jpg;
  stylix.polarity = "dark";
  stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-frappe.yaml";

  stylix.fonts = {
    monospace = {
      package = pkgs.nerdfonts.override { fonts = [ "Monaspace" ]; };
      name = "MonaspiceNe Nerd Font";
    };
  };
}
