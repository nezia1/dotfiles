{
  config,
  lib,
  ...
}: let
  cfg = config.modules.pipewire;
in {
  options.modules.pipewire.enable = lib.mkEnableOption "pipewire module";
  options.modules.pipewire.latencyFix.enable = lib.mkEnableOption "enable latency fixes";
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

    services.pipewire.extraConfig.pipewire."92-low-latency" = lib.mkIf cfg.latencyFix.enable {
      "context.properties" = {
        "default.clock.rate" = 48000;
        "default.clock.allowed-rates" = [48000];
        "default.clock.quantum" = 2048;
        "default.clock.min-quantum" = 1024;
      };
    };
  };
}
