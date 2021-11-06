{
  description = "Mudcore, a simple MUD server";

  inputs = {
    flake-compat = {
      url = "github:edolstra/flake-compat";
      flake = false;
    };
    flake-utils.url = "github:numtide/flake-utils";
    nixos-emacs.url = "github:nix-community/emacs-overlay";
    nixpkgs.url = "github:nixos/nixpkgs";
  };

  outputs = inputs:
    {
      overlay = final: prev:
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
          overlays = [ inputs.self.overlay ];
        };
      in
      {
        defaultPackage = nixpkgs.mudcore;
        devShell = nixpkgs.mudcore.overrideAttrs (oldAttrs: {
          nativeBuildInputs = oldAttrs.nativeBuildInputs ++ [
            nixpkgs.texlive.combined.scheme-basic
          ];
        });
      }
    );
}
