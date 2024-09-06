{ pkgs, ... }:
{
  stylix.targets.gtk.enable = false;
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
    profile = {
      "4621184a-b921-42cf-80a0-7784516606f2" = {
        default = true;
        audibleBell = false;
        allowBold = true;
        visibleName = "nezia";
        font = "IntoneMono NF 14";
      };
    };
  };
}

