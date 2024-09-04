{ ... }: {

  imports = [ 
    ./core.nix
    ./boot.nix 
    ./audio.nix
    ./locale.nix 
    ./packages.nix
    ./printing.nix
    ./misc.nix
    ./nh.nix
  ];
}
