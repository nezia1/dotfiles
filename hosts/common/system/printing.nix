{ pkgs, ... }:

{
  # setup printing service
  services.printing.enable = true;

  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };

  services.printing.drivers = [ pkgs.gutenprint pkgs.hplip ];

  hardware.sane.enable = true; # enables support for SANE scanners
  hardware.sane.extraBackends = [ 
    pkgs.sane-airscan     # generic
    pkgs.hplip            # HP
    pkgs.epkowa           # Epson
    pkgs.utsushi          # other printers
  ];
  services.udev.packages = [ pkgs.sane-airscan pkgs.utsushi ];
}
