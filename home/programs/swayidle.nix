{
  lib,
  config,
  ...
}: {
  services.swayidle = {
    enable = true;
    events = [
      {
        event = "lock";
        command = "${lib.getExe config.programs.swaylock.package}";
      }
      {
        event = "before-sleep";
        command = "${lib.getExe config.programs.swaylock.package}";
      }
    ];
  };
  systemd.user.services.swayidle.Unit.After = lib.mkForce ["graphical-session.target"];
}
