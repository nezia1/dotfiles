{
  inputs,
  config,
  pkgs,
  ...
}: {
  imports = [
    inputs.plasma-manager.homeManagerModules.plasma-manager
  ];
  rograms.plasma = {
    enable = true;
    workspace = {
      lookAndFeel = "org.kde.breezedark.desktop";
      inherit (config.theme) wallpaper;
    };

    input = {
      touchpads = [
        {
          enable = true;
          naturalScroll = true;
          vendorId = "093a";
          productId = "0274";
          name = "PIXA3854:00 093A:0274 Touchpad";
        }
      ];
      keyboard = {
        options = [
          "compose:ralt"
        ];
      };
    };
  };
  home.packages = with pkgs; [
    qalculate-qt
  ];
}
