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
    profile."7dfaed12-b68d-4459-8cb9-ecd3d49f3634" = {
      default = true;
      customCommand = "tmux new-session -A -s main";
    };
  };
}

