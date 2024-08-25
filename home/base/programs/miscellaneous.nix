{ pkgs, ... }:

{
  programs.fzf.enable = true;
  programs.fastfetch.enable = true;
  home.packages = with pkgs; [ proton-pass spotify vesktop wl-clipboard ];
}
