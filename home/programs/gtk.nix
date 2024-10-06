{
  pkgs,
  config,
  nixosConfig,
  ...
}: {
  home.pointerCursor = {
    inherit (nixosConfig.style.cursorTheme) name package size;
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
      inherit (nixosConfig.style.gtk.iconTheme) name package;
    };

    theme = {
      inherit (nixosConfig.style.gtk.theme) name package;
    };
  };
}
