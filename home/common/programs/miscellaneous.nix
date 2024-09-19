{ pkgs, ... }:

{
  programs.fzf.enable = true;
  programs.fastfetch.enable = true;
  home.packages = with pkgs; [ element-desktop imhex obsidian proton-pass spotify vesktop wl-clipboard ];
}
