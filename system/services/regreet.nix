{
  inputs,
  lib,
  pkgs,
  config,
  ...
}: let
  inherit (lib) mkDefault mkForce;
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
      background = {
        path = mkDefault config.style.wallpaper;
        fit = "Cover";
      };
      GTK = let
        isDark = inputs.basix.schemeData.base16.${config.style.scheme}.variant == "dark";
      in {
        application_prefer_dark_theme = isDark;
        cursor_theme_name = mkForce config.style.cursorTheme.name;
        icon_theme_name = mkForce config.style.gtk.iconTheme.name;
        theme_name = mkForce config.style.gtk.theme.name;
        font_name = mkForce "Inter 18";
      };
    };
  };
  security.pam.services.greetd = {
    enableGnomeKeyring = true;
    fprintAuth = false;
  };
}
