{ pkgs, ... }:

{
  imports = [ 
    ./hardware-configuration.nix 
  ];

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

  modules.gnome.enable = true;
  modules.stylix.enable = true;
  modules.nvidia.enable = true;
  modules.gaming.enable = true;

  stylix.image = ../../wallpapers/lucy-edgerunners-wallpaper.jpg;
}

