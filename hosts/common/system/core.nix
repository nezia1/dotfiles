{hostname, ...}: {
  networking.hostName = hostname;
  networking.networkmanager.enable = true;
  services = {
    xserver.xkb = {
      layout = "us";
      variant = "";
    };

    # automount
    udisks2.enable = true;

    fwupd.enable = true;
  };

  users.users.nezia = {
    isNormalUser = true;
    description = "Anthony Rodriguez";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
  };

  nixpkgs.config.allowUnfree = true;
  hardware.enableAllFirmware = true;

  system.stateVersion = "24.05";

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
}
