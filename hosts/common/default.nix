_: {
  imports = [
    ./system
    ./syncthing
    ./sops.nix
  ];
  modules = {
    gnome.enable = true;
    stylix.enable = true;
    docker.enable = true;
    pipewire.enable = true;
  };
}
