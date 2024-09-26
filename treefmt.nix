# TODO: maybe use flake-parts
{...}: {
  # Used to find the project root
  projectRootFile = "flake.nix";
  programs.alejandra.enable = true;
}
