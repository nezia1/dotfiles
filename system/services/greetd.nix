{
  pkgs,
  config,
  lib,
  ...
}: {
  programs.regreet.enable = true;

  # greetd display manager
  services.greetd = {
    enable = true;
    settings = {
      default_session = let
        greeter = lib.getExe config.programs.regreet.package;
        program = "${lib.getExe pkgs.cage} -s";
      in {
        command = "${program} -- ${greeter}";
        user = "nezia";
      };
      # unlock GPG keyring on login
      security.pam.services.greetd.enableGnomeKeyring = true;
    };
  };
}
