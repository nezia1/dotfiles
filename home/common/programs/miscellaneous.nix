{ pkgs, ... }:

{
  programs.fzf.enable = true;
  programs.fastfetch.enable = true;
  home.packages = with pkgs; [ element-desktop obsidian proton-pass spotify vesktop wl-clipboard ];
}
