{ ... }:
{
  imports = [
    ./system 
    ./syncthing 
    ./sops.nix
  ];
  modules.gnome.enable = true;
}
