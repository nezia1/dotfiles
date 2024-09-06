{ inputs, config, lib, pkgs, ... }:
let 
  cfg = config.modules.greetd;

  inherit (inputs.hyprland.packages.${pkgs.system}) hyprland;
  greeter = lib.getExe config.programs.regreet.package;
  Hyprland = lib.getExe' hyprland "Hyprland";
  hyprctl = lib.getExe' hyprland "hyprctl";
  hyprlandConfig = pkgs.writeText "greetd-hyprland-config" ''
    misc {
        force_default_wallpaper=0
        focus_on_activate=1
    }

    animations {
        enabled=0
        first_launch_animation=0
    }

    exec-once=${greeter}; ${hyprctl} dispatch exit
    exec-once=${hyprctl} dispatch focuswindow ${greeter}
  '';
in 
  {
  options = {
    modules.greetd = {
      enable = lib.mkEnableOption "Enable the greetd module";
    };
  };
  config = lib.mkIf cfg.enable {
    programs.regreet.enable = true;
    services.greetd = {
      enable = true;
      settings = rec {
        initial_session = {
          command = "${Hyprland} --config ${hyprlandConfig}";
          user = "nezia";
        };
        default_session = initial_session;
      };
    };
  };
}
