{ pkgs, ... }:

{
  fonts = {
    fontconfig = {
      enable = true;
      defaultFonts = {
        monospace = [ "MonaspiceNe Nerd Font" ];
        emoji = [ "Noto Color Emoji "];
      };
    };
  };

  home.packages = with pkgs; [ 
    noto-fonts-color-emoji
    (nerdfonts.override { fonts = [ "Monaspace" ]; })
  ];
}
