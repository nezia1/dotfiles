{ pkgs, ... }:

{

  home.packages = with pkgs; [ 
    protonup-qt 
    bottles
    lutris
  ];
}
