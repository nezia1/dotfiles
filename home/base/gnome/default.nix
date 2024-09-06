{ pkgs, ... }:
{
  dconf = {
    enable = true;
    settings = {
      "org/gnome/shell" = {
        disable-user-extensions = false; # enables user extensions
        enabled-extensions = [
          pkgs.gnomeExtensions.appindicator.extensionUuid
        ];
      };
      "org/gnome/desktop/input-sources" = {
        xkb-options = [ "compose:ralt" ];
      };
    };
  };
  home.packages = with pkgs.gnomeExtensions; [
    appindicator
  ];
  gtk = {
    enable = true;
    catppuccin = {
      enable = true;
      flavor = "frappe";
      gnomeShellTheme = true;
    };
  };
}

