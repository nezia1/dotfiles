{
  description = "A template that shows all standard flake outputs";

  # The nixos-20.09 branch of the NixOS/nixpkgs repository on GitHub.
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs = { nixpkgs, ... }: 
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { 
        inherit system;  
      };
    in {
      devShells.${system}.go = pkgs.mkShell {
        nativeBuildInputs = with pkgs; [ go gopls ];
      };
    };

}

