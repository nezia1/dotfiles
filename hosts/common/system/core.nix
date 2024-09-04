{ hostname, ... }:

{
  networking.hostName = hostname; 
  networking.networkmanager.enable = true;

  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  users.users.nezia = {
    isNormalUser = true;
    description = "Anthony Rodriguez";
    extraGroups = [ "networkmanager" "wheel" ];
  };

  # automount
  services.udisks2.enable = true;

  services.fwupd.enable = true;

  nixpkgs.config.allowUnfree = true;
  hardware.enableAllFirmware = true;

  system.stateVersion = "24.05"; 

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
}
