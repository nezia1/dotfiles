{
  config,
  lib,
  pkgs,
  ...
}: let
  appLauncher = lib.getExe pkgs.fuzzel;
  terminal = lib.getExe pkgs.foot;
  # schemeData = inputs.basix.schemeData.base16.${config.theme.scheme};
in {
  programs.niri = {
    settings = {
      environment."NIXOS_OZONE_WL" = "1";
      prefer-no-csd = true;

      window-rules = [
        {
          matches = [
            {app-id = "foot";}
          ];
          default-column-width = {proportion = 0.5;};
        }
      ];
      binds = {
        "Mod+D".action.spawn = appLauncher;
        "Mod+Return".action.spawn = terminal;
        "Mod+Shift+E".action.quit.skip-confirmation = true;
        "Mod+Shift+Slash".action = config.lib.niri.actions.show-hotkey-overlay;
        "Mod+Q".action = config.lib.niri.actions.close-window;
        "Mod+F".action = config.lib.niri.actions.maximize-column;
        "Mod+Shift+F".action = config.lib.niri.actions.fullscreen-window;
        "Mod+C".action = config.lib.niri.actions.center-column;

        # Focus
        "Mod+Left".action = config.lib.niri.actions.focus-column-left;
        "Mod+Down".action = config.lib.niri.actions.focus-window-down;
        "Mod+Up".action = config.lib.niri.actions.focus-window-up;
        "Mod+Right".action = config.lib.niri.actions.focus-column-right;
        "Mod+H".action = config.lib.niri.actions.focus-column-left;
        "Mod+J".action = config.lib.niri.actions.focus-window-down;
        "Mod+K".action = config.lib.niri.actions.focus-window-up;
        "Mod+L".action = config.lib.niri.actions.focus-column-right;
        "Mod+Home".action = config.lib.niri.actions.focus-column-first;
        "Mod+End".action = config.lib.niri.actions.focus-column-last;

        # Move
        "Mod+Ctrl+Left".action = config.lib.niri.actions.move-column-left;
        "Mod+Ctrl+Down".action = config.lib.niri.actions.move-window-down;
        "Mod+Ctrl+Up".action = config.lib.niri.actions.move-window-up;
        "Mod+Ctrl+Right".action = config.lib.niri.actions.move-column-right;
        "Mod+Ctrl+H".action = config.lib.niri.actions.move-column-left;
        "Mod+Ctrl+J".action = config.lib.niri.actions.move-window-down;
        "Mod+Ctrl+K".action = config.lib.niri.actions.move-window-up;
        "Mod+Ctrl+L".action = config.lib.niri.actions.move-column-right;
        "Mod+Ctrl+Home".action = config.lib.niri.actions.move-column-to-first;
        "Mod+Ctrl+End".action = config.lib.niri.actions.move-column-to-last;

        # Monitor focus
        "Mod+Shift+Left".action = config.lib.niri.actions.focus-monitor-left;
        "Mod+Shift+Down".action = config.lib.niri.actions.focus-monitor-down;
        "Mod+Shift+Up".action = config.lib.niri.actions.focus-monitor-up;
        "Mod+Shift+Right".action = config.lib.niri.actions.focus-monitor-right;
        "Mod+Shift+H".action = config.lib.niri.actions.focus-monitor-left;
        "Mod+Shift+J".action = config.lib.niri.actions.focus-monitor-down;
        "Mod+Shift+K".action = config.lib.niri.actions.focus-monitor-up;
        "Mod+Shift+L".action = config.lib.niri.actions.focus-monitor-right;

        # Move to monitor
        "Mod+Shift+Ctrl+Left".action = config.lib.niri.actions.move-column-to-monitor-left;
        "Mod+Shift+Ctrl+Down".action = config.lib.niri.actions.move-column-to-monitor-down;
        "Mod+Shift+Ctrl+Up".action = config.lib.niri.actions.move-column-to-monitor-up;
        "Mod+Shift+Ctrl+Right".action = config.lib.niri.actions.move-column-to-monitor-right;
        "Mod+Shift+Ctrl+H".action = config.lib.niri.actions.move-column-to-monitor-left;
        "Mod+Shift+Ctrl+J".action = config.lib.niri.actions.move-column-to-monitor-down;
        "Mod+Shift+Ctrl+K".action = config.lib.niri.actions.move-column-to-monitor-up;
        "Mod+Shift+Ctrl+L".action = config.lib.niri.actions.move-column-to-monitor-right;

        # Workspace navigation
        "Mod+Page_Down".action = config.lib.niri.actions.focus-workspace-down;
        "Mod+Page_Up".action = config.lib.niri.actions.focus-workspace-up;
        "Mod+U".action = config.lib.niri.actions.focus-workspace-down;
        "Mod+I".action = config.lib.niri.actions.focus-workspace-up;
        "Mod+Ctrl+Page_Down".action = config.lib.niri.actions.move-column-to-workspace-down;
        "Mod+Ctrl+Page_Up".action = config.lib.niri.actions.move-column-to-workspace-up;
        "Mod+Ctrl+U".action = config.lib.niri.actions.move-column-to-workspace-down;
        "Mod+Ctrl+I".action = config.lib.niri.actions.move-column-to-workspace-up;
        "Mod+Shift+Page_Down".action = config.lib.niri.actions.move-workspace-down;
        "Mod+Shift+Page_Up".action = config.lib.niri.actions.move-workspace-up;
        "Mod+Shift+U".action = config.lib.niri.actions.move-workspace-down;

        # Workspace focus
        "Mod+1".action.focus-workspace = 1;
        "Mod+2".action.focus-workspace = 2;
        "Mod+3".action.focus-workspace = 3;
        "Mod+4".action.focus-workspace = 4;
        "Mod+5".action.focus-workspace = 5;
        "Mod+6".action.focus-workspace = 6;
        "Mod+7".action.focus-workspace = 7;
        "Mod+8".action.focus-workspace = 8;
        "Mod+9".action.focus-workspace = 9;

        # Move to workspace
        "Mod+Ctrl+1".action.move-column-to-workspace = 1;
        "Mod+Ctrl+2".action.move-column-to-workspace = 2;
        "Mod+Ctrl+3".action.move-column-to-workspace = 3;
        "Mod+Ctrl+4".action.move-column-to-workspace = 4;
        "Mod+Ctrl+5".action.move-column-to-workspace = 5;
        "Mod+Ctrl+6".action.move-column-to-workspace = 6;
        "Mod+Ctrl+7".action.move-column-to-workspace = 7;
        "Mod+Ctrl+8".action.move-column-to-workspace = 8;
        "Mod+Ctrl+9".action.move-column-to-workspace = 9;
        "Mod+Shift+I".action = config.lib.niri.actions.move-workspace-up;

        # Window management
        "Mod+Comma".action = config.lib.niri.actions.consume-window-into-column;
        "Mod+Period".action = config.lib.niri.actions.expel-window-from-column;
        "Mod+BracketLeft".action = config.lib.niri.actions.consume-or-expel-window-left;
        "Mod+BracketRight".action = config.lib.niri.actions.consume-or-expel-window-right;

        # Column management
        "Mod+R".action = config.lib.niri.actions.switch-preset-column-width;
        "Mod+Shift+R".action = config.lib.niri.actions.switch-preset-window-height;
        "Mod+Ctrl+R".action = config.lib.niri.actions.reset-window-height;
        "Mod+Minus".action = config.lib.niri.actions.set-column-width "-10%";
        "Mod+Equal".action = config.lib.niri.actions.set-column-width "+10%";
        "Mod+Shift+Minus".action = config.lib.niri.actions.set-window-height "-10%";
        "Mod+Shift+Equal".action = config.lib.niri.actions.set-window-height "+10%";

        # Screenshots
        "Print".action = config.lib.niri.actions.screenshot;
        "Ctrl+Print".action = config.lib.niri.actions.screenshot-screen;
        "Alt+Print".action = config.lib.niri.actions.screenshot-window;

        # System
        "Mod+Shift+P".action = config.lib.niri.actions.power-off-monitors;

        # Media keys
        "XF86AudioRaiseVolume" = {
          action.spawn = ["wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "0.1+"];
          allow-when-locked = true;
        };
        "XF86AudioLowerVolume" = {
          action.spawn = ["wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "0.1-"];
          allow-when-locked = true;
        };
        "XF86AudioMute" = {
          action.spawn = ["wpctl" "set-mute" "@DEFAULT_AUDIO_SINK@" "toggle"];
          allow-when-locked = true;
        };
        "XF86AudioMicMute" = {
          action.spawn = ["wpctl" "set-mute" "@DEFAULT_AUDIO_SOURCE@" "toggle"];
          allow-when-locked = true;
        };
        "XF86MonBrightnessUp" = {
          action.spawn = ["brillo" "-q" "-u 300000" "-A 5"];
          allow-when-locked = true;
        };
        "XF86MonBrightnessDown" = {
          action.spawn = ["brillo" "-q" "-u 300000" "-U 5"];
          allow-when-locked = true;
        };
      };
    };
  };
}
