{
  description = "mkhoatd Darwin system flake";

  inputs = rec {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs, nix-homebrew }:
  let
    # configuration = { pkgs, ... }: { ... };  <- REMOVE THIS BLOCK
  in
  {
    # Build darwin flake using:
    # $ darwin-rebuild switch --flake .#simple
    darwinConfigurations."mackhoa" = nix-darwin.lib.darwinSystem {
      modules = [ 
        (import ./configuration.nix) # <-- ADD THIS IMPORT
        # configuration  <- REMOVE THIS
        nix-homebrew.darwinModules.nix-homebrew
        {
          nix-homebrew = {
            enable = true;
            user = "mkhoatd";
            autoMigrate = true;
          };
        }
      ];
    };

    # Expose the package set, including overlays, for convenience.
    darwinPackages = self.darwinConfigurations."mackhoa".pkgs;
  };
}
