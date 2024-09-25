{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.modules.gaming;
in {
  options = {
    modules.gaming = {
      enable = lib.mkEnableOption "Enable the gaming module";
    };
  };

  config = lib.mkIf cfg.enable {
    programs = {
      steam = {
        enable = true;
        gamescopeSession.enable = true;
      };

      gamemode.enable = true;
      coolercontrol = {
        enable = true;
        nvidiaSupport = true;
      };
    };

    hardware.keyboard.qmk.enable = true;
    environment.systemPackages = with pkgs; [
      via
    ];
    services.udev.packages = [pkgs.via];
  };
}
