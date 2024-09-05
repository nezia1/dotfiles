{ ... }:
{
  imports = [
    ./system 
    ./syncthing 
    ./sops.nix
    ./stylix.nix
  ];
  modules.gnome.enable = true;
}
