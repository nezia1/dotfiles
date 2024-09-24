{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    vim
    git
    wget
    curl
    tree
    python3
    lm_sensors
  ];
}
