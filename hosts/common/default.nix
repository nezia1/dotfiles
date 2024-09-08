_:
{
  imports = [
    ./system 
    ./syncthing 
    ./sops.nix
  ];

  modules.gnome.enable = true;
  modules.stylix.enable = true;
  modules.docker.enable = true;
  modules.pipewire.enable = true;
}
