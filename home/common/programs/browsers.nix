{ inputs, system, ... }:

{
  programs.firefox.enable = true;
  programs.chromium.enable = true;
  home.packages = [ inputs.zen-browser.packages."${system}".specific ];
}
