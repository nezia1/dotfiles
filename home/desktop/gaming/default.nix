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
    r2modman
  ];
  programs.mangohud.enable = true;
}
