{ pkgs, ... }:

{
  imports = [ 
    ./hardware-configuration.nix 
  ];

  modules.nvidia.enable = true;
  modules.gaming.enable = true;

  hardware.uni-sync = {
    enable = true;
    devices = [
      {
        device_id = "VID:3314/PID:41218/SN:6243168001";
        sync_rgb = true;
        channels = [
          {
            mode = "Manual";
            speed = 60;
          }
          {
            mode = "Manual";
            speed = 60;
          }
          {
            mode = "Manual";
            speed = 60;
          }
          {
            mode = "Manual";
            speed = 60;
          }
        ];
      }
    ];
  };
  stylix.image = ../../wallpapers/lucy-edgerunners-wallpaper.jpg;
}

