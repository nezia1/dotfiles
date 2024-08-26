{ ... }:

{
  imports = [ 
    ./hardware-configuration.nix 
    ../../modules/sops.nix
    ../../modules/system.nix 
    ../../modules/gnome.nix
    ../../modules/syncthing
    ../../modules/stylix.nix
  ];

  services.fprintd.enable = true;
  services.power-profiles-daemon.enable = true;

  services.keyd = {
    enable = true;
    keyboards = {
      default = {
        ids = [ "*" ];
        settings = {
          main = {
            capslock = "overload(control, esc)";
          };
        };
      };
    };
  };
}

