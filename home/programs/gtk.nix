{
  pkgs,
  config,
  ...
}: {
  home.pointerCursor = {
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Classic";
    size = 24;
    gtk.enable = true;
    x11.enable = true;
  };

  gtk = let
    commonGtkConfig = {
      gtk-decoration-layout = ":menu";
    };
  in {
    enable = true;

    font = {
      name = "Inter";
      package = pkgs.inter;
      size = 11;
    };

    gtk3.extraConfig = commonGtkConfig;
    gtk4.extraConfig = commonGtkConfig;

    gtk2.configLocation = "${config.xdg.configHome}/gtk-2.0/gtkrc";

    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };

    theme = let
      accent = "lavender";
      variant = "frappe";
      size = "standard";
    in {
      name = "catppuccin-${variant}-${accent}-${size}";
      package = pkgs.catppuccin-gtk.override {
        # https://github.com/NixOS/nixpkgs/blob/nixos-23.05/pkgs/data/themes/catppuccin-gtk/default.nix
        accents = [accent];
        inherit variant size;
      };
    };
  };
}
