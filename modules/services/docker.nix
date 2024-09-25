{
  config,
  lib,
  username,
  ...
}: let
  cfg = config.modules.docker;
in {
  options.modules.docker.enable = lib.mkEnableOption "docker module";
  config = lib.mkIf cfg.enable {
    virtualisation.docker = {
      enable = true;
      rootless = {
        enable = true;
        setSocketVariable = true;
      };
    };
    users.users.${username}.extraGroups = ["docker"];
  };
}
