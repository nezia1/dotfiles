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

  programs.gnome-terminal = {
    enable = true;
    showMenubar = false;
    profile."2e695b31-b387-4c21-84db-6203b9d8cf52" = {
      visibleName = "nezia";
      default = true;
      audibleBell = false;
      boldIsBright = true;
      font = "MonaspiceNe Nerd Font 14";
    };
  };
}

