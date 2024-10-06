{pkgs, ...}: {
  programs.mpv.enable = true;
  home.packages = [
    pkgs.gnome-calculator
    pkgs.loupe
    pkgs.spotify
    pkgs.stremio
    pkgs.celluloid
  ];
}
