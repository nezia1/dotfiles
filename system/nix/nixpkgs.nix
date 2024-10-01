_: {
  nixpkgs = {
    config.allowUnfree = true;
    overlays = [
      (_: prev: {
        lib =
          prev.lib
          // import ../../lib {
            inherit (prev) lib pkgs;
          };
      })
    ];
  };
}
