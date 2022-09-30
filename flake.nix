{
  description = "Mudcore, a simple MUD server";

  inputs = {
    flake-compat = {
      url = "github:edolstra/flake-compat";
      flake = false;
    };
    flake-utils.url = "github:numtide/flake-utils";
    nixpkgs.url = "github:nixos/nixpkgs";
  };

  outputs = inputs:
    {
      overlays.default = final: prev:
        {
          mudcore = prev.callPackage ./mudcore.nix {
            lua = final.lua5_2;
          };
        };
    }
    //
    inputs.flake-utils.lib.eachDefaultSystem (system:
      let
        nixpkgs = import inputs.nixpkgs {
          inherit system;
          overlays = [ inputs.self.overlays.default ];
        };
      in
      {
        packages.default = nixpkgs.mudcore;
        devShell = nixpkgs.mudcore.overrideAttrs (oldAttrs: {
          nativeBuildInputs = oldAttrs.nativeBuildInputs ++ [
            nixpkgs.texlive.combined.scheme-basic
          ];
        });
      }
    );
}
