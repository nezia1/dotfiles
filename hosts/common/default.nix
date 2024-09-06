{ ... }:
{
  imports = [
    ./system 
    ./syncthing 
    ./sops.nix
    ./theme.nix
  ];
  modules.gnome.enable = true;
}
