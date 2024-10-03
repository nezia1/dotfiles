{pkgs, ...}: {
  imports = [
    ./browsers.nix
    ./gtk.nix
  ];

  programs.fzf.enable = true;
  programs.fastfetch.enable = true;
  home.packages = with pkgs; [
    imhex
    obsidian
    proton-pass
    spotify
    vesktop
    wl-clipboard
    stremio
  ];
}
