{ inputs, system, ... }:

{
  programs.chromium.enable = true;
  home.packages = [ inputs.zen-browser.packages."${system}".specific ];
}
