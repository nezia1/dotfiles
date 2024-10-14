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
    inputs.umu.packages.${pkgs.system}.umu
  ];
  programs.mangohud.enable = true;
}
