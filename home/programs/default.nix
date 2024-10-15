{pkgs, ...}: {
  imports = [
    ./browsers.nix
    ./media
    ./xdg.nix
    ./gtk.nix
  ];

  programs = {
    fzf.enable = true;
    hyfetch.enable = true;
    yazi.enable = true;
  };

  home.packages = with pkgs; [
    imhex
    logisim-evolution
    obsidian
    proton-pass
    vesktop
    wl-clipboard
    fractal
    cinny-desktop
    gnome-control-center
    mission-center
    playerctl
  ];
}
