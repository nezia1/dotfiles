_:
{
  imports = [
    ./system 
    ./syncthing 
    ./sops.nix
  ];

  modules.stylix.enable = true;
  modules.docker.enable = true;
  modules.pipewire.enable = true;
}
