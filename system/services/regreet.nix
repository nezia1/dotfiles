{
  inputs,
  config,
  ...
}: {
  programs.regreet = {
    enable = true;
    cageArgs = [
      "-s"
      "-d"
    ];
    settings = {
      GTK = let
        schemeData = inputs.basix.schemeData.base16.${config.theme.scheme};
      in {
        application_prefer_dark_theme = schemeData.variant == "dark";
      };
    };
  };
  security.pam.services.greetd = {
    enableGnomeKeyring = true;
    fprintAuth = false;
  };
}
