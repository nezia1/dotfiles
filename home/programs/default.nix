{pkgs, ...}: {
  imports = [
    ./browsers.nix
    ./gtk.nix
    ./media
    ./xdg.nix
  ];

  programs = {
    fzf.enable = true;
    fastfetch.enable = true;
    yazi.enable = true;
  };

  home.packages = with pkgs; [
    imhex
    obsidian
    proton-pass
    vesktop
    wl-clipboard
    fractal
  ];
}
