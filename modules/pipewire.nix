{ config, lib, ... }:

let 
  cfg = config.modules.pipewire;
in 
  {
  options.modules.pipewire.enable = lib.mkEnableOption "pipewire module";
  config = lib.mkIf cfg.enable {
    hardware.pulseaudio.enable = false;
    # rtkit is optional but recommended
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      # If you want to use JACK applications, uncomment this
      #jack.enable = true;
    };

    services.pipewire.extraConfig.pipewire."92-low-latency" = {
      "context.properties" = {
        "default.clock.rate" = 48000;
        "default.clock.quantum" = 32;
        "default.clock.min-quantum" = 32;
        "default.clock.max-quantum" = 32;
      };
    };
  };
}
