{ ... }:

{
  imports = [ 
    ./hardware-configuration.nix 
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

