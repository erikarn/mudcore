{ nixpkgs ? import <nixpkgs> {}, withTools ? false }:

let
  inherit (nixpkgs) lib;

  texlive = nixpkgs.texlive.combined.scheme-basic;
  mudcore = import ./default.nix { inherit nixpkgs; };
in
  mudcore.overrideAttrs (oldAttrs: {
    nativeBuildInputs = oldAttrs.nativeBuildInputs
      ++ lib.optionals withTools [ texlive ];
  })
