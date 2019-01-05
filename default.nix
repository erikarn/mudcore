{ nixpkgs ? import <nixpkgs> {} }:

let
  mudcore = with nixpkgs; callPackage ./mudcore.nix {
    lua = lua5_2;
    zeromq = zeromq4;
  };
in
  mudcore
