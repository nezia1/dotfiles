{lib, ...}: {
  imports = [
    ./boot.nix
    ./users.nix
    ./security.nix
    ../nix
  ];
  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
      LC_ADDRESS = "fr_CH.UTF-8";
      LC_IDENTIFICATION = "fr_CH.UTF-8";
      LC_MEASUREMENT = "fr_CH.UTF-8";
      LC_MONETARY = "fr_CH.UTF-8";
      LC_NAME = "fr_CH.UTF-8";
      LC_NUMERIC = "fr_CH.UTF-8";
      LC_PAPER = "fr_CH.UTF-8";
      LC_TELEPHONE = "fr_CH.UTF-8";
      LC_TIME = "fr_CH.UTF-8";
    };
  };

  system.stateVersion = lib.mkDefault "24.05";
  time.timeZone = lib.mkDefault "Europe/Paris";
  zramSwap.enable = true;
}
