{ pkgs, ... }:

{

  home.packages = with pkgs; [ 
    protonup-qt 
    bottles
    lutris
    # steamtinkerlaunch dependencies
    unzip
    xdotool
    xorg.xwininfo
    yad
  ];
  programs.mangohud.enable = true;
}
