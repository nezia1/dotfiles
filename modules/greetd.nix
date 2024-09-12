{ config, lib, pkgs, username, ... }:
let 
  cfg = config.modules.greetd;

  tuigreet = "${pkgs.greetd.tuigreet}/bin/tuigreet";

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
      settings = {
        default_session = {
          command = "${tuigreet} --time --time-format '%a, %d %b %Y • %T' --asterisks --remember --cmd Hyprland";
          user = username;
        };
      };
    };
    security.pam.services.hyprlock = {};
  };
}
