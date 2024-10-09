{
  inputs,
  pkgs,
  config,
  nixosConfig,
  ...
}: let
  isDark = inputs.basix.schemeData.base16.${nixosConfig.style.scheme}.variant == "dark";
in {
  home.pointerCursor = {
    inherit (nixosConfig.style.cursorTheme) name package size;
    gtk.enable = true;
    x11.enable = true;
  };

  gtk = {
    enable = true;

    font = {
      name = "Inter";
      package = pkgs.inter;
      size = 11;
    };

    gtk3.extraConfig = {
      gtk-decoration-layout = ":menu";
      gtk-application-prefer-dark-theme = isDark;
    };

    gtk4.extraConfig = {
      gtk-decoration-layout = ":menu";
    };

    gtk2.configLocation = "${config.xdg.configHome}/gtk-2.0/gtkrc";

    iconTheme = {
      inherit (nixosConfig.style.gtk.iconTheme) name package;
    };

    theme = {
      inherit (nixosConfig.style.gtk.theme) name package;
    };
  };
  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme =
        if isDark
        then "prefer-dark"
        else "default";
    };
  };
}
