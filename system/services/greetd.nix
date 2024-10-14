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
        command = "${lib.getExe pkgs.greetd.tuigreet} \
          --time \
          --asterisks \
          --user-menu \
          --cmd ${lib.getExe config.programs.niri.package} --session";
        user = "greeter";
      };
      default_session = initial_session;
    };
  };

  security.pam.services.greetd.text = lib.mkIf config.services.fprintd.enable ''
    account required pam_unix.so

    # disable fprintd on greetd
    auth sufficient pam_unix.so try_first_pass likeauth
    auth required pam_deny.so

    password sufficient pam_unix.so nullok yescrypt

    session required pam_env.so conffile=/etc/pam/environment readenv=0
    session required pam_unix.so
  '';
}
