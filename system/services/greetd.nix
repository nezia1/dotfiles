{
  lib,
  pkgs,
  config,
  ...
}: {
  services.greetd = {
    enable = true;
    settings = rec {
      initial_session = {
        command = ''
          ${lib.getExe pkgs.greetd.tuigreet}
            --time
            --asterisks
            --user-menu
            --cmd ${lib.getExe config.programs.niri.package} --session
        '';
        user = "greeter";
      };
      default_session = initial_session;
    };
  };
  security.pam.services = {
    login.enableGnomeKeyring = true;
    greetd.enableGnomeKeyring = true;
    greetd.fprintAuth = false;
  };
}
