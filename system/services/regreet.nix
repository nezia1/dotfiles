{
  lib,
  pkgs,
  config,
  ...
}: let
  inherit (lib) mkForce;
in {
  environment.systemPackages = [
    config.style.gtk.theme.package
    config.style.gtk.iconTheme.package
    config.style.cursorTheme.package
  ];

  programs.regreet = {
    enable = true;
    package = pkgs.greetd.regreet;
    cageArgs = [
      "-s"
      "-d"
    ];
    settings = {
      GTK = {
        cursor_theme_name = mkForce config.style.cursorTheme.name;
        icon_theme_name = mkForce config.style.gtk.iconTheme.name;
        theme_name = mkForce config.style.gtk.theme.name;
      };
    };
  };
  security.pam.services.greetd = {
    enableGnomeKeyring = true;
    fprintAuth = false;
  };
}
