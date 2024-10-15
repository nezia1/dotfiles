{
  pkgs,
  inputs,
  ...
}: {
  home.packages = with pkgs; [
    protonup-qt
    bottles
    lutris
    path-of-building
    r2modman

    # steamtinkerlaunch dependencies
    xdotool
    xorg.xwininfo
    yad
  ];
  programs.mangohud.enable = true;
}
