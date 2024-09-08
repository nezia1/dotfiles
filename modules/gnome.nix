{ config, lib, pkgs, username, ... }:
let 
  cfg = config.modules.gnome;
  stylixEnabled = config.modules.stylix.enable or false;
in 
  {
  options = {
    modules.gnome = {
      enable = lib.mkEnableOption "Enable Gnome";
    };
  };
  config = lib.mkIf cfg.enable {
    services.xserver = {
      enable = true;
      displayManager.gdm.enable = true;
      desktopManager.gnome = {
        enable = true;
        extraGSettingsOverridePackages = [ pkgs.mutter ];
        extraGSettingsOverrides = ''
   [org.gnome.mutter]
   experimental-features=['scale-monitor-framebuffer']
        '';
      };
    };

    environment.gnome.excludePackages =
      (with pkgs; [ gnome-console gnome-photos gnome-music gnome-tour iagno hitori atomix gnome-contacts gnome-initial-setup gedit cheese tali epiphany geary yelp ]);

    environment.systemPackages = with pkgs; [ 
      gnome-tweaks 
      gnome-power-manager
    ];
    stylix = lib.mkIf stylixEnabled {
      targets = {
        plymouth.enable = false;
        gtk.enable = false;
        gnome.enable = false;
      };
      fonts = {
        sansSerif = {
          package = pkgs.inter;
          name = "Intel Variable";
        };
        serif = config.stylix.fonts.sansSerif;
      };
    };
    home-manager.users.${username} = {
      stylix = lib.mkIf stylixEnabled {
        targets.gtk.enable = false;
      };
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
            visibleName = "${username}";
            font = "IntoneMono NF 14";
          };
        };
      };
    };
  };
}

