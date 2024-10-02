{
  config,
  lib,
  pkgs,
  ...
}: let
  appLauncher = lib.getExe pkgs.fuzzel;
  terminal = lib.getExe pkgs.foot;
in {
  # TODO: put this into the theme module to avoid repeating in greeter config
  home.pointerCursor = {
    gtk.enable = true;
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Classic";
  };

  programs.niri = {
    settings = {
      environment."NIXOS_OZONE_WL" = "1";
      prefer-no-csd = true;
      binds = {
        "Mod+D".action.spawn = appLauncher;
        "Mod+Return".action.spawn = terminal;
        "Mod+Shift+E".action.quit.skip-confirmation = true;
        "Mod+Shift+Slash".action = config.lib.niri.actions.show-hotkey-overlay;
        "Mod+Q".action = config.lib.niri.actions.close-window;
        "Mod+F".action = config.lib.niri.actions.maximize-column;
      };
      window-rules = [
        {
          matches = [
            {app-id = "foot";}
          ];
          default-column-width = {proportion = 0.5;};
        }
      ];
    };
  };
}
