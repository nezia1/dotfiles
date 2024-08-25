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
      "org/gnome/desktop/interface" = {
        color-scheme = "prefer-dark";
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
      visibleName = "Catppuccin Frappe";
      default = true;
      font = "MonaspiceNe Nerd Font 14";
      customCommand = "tmux new-session -A -s main";
      colors = {
        palette = [ "#51576d" "#e78284" "#a6d189" "#e5c890" "#8caaee" "#f4b8e4" "#81c8be" "#b5bfe2" "#626880" "#e78284" "#a6d189" "#e5c890" "#8caaee" "#f4b8e4" "#81c8be" "#a5adce" ];
        backgroundColor = "#303446";
        foregroundColor = "#c6d0f5";
        cursor = {
          background = "#f2d5cf";
          foreground = "#303446";
        };
        highlight = {
          background = "#f2d5cf";
          foreground = "#626880";
        };
      };
    };
  };
}

