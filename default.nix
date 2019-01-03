{ nixpkgs ? import <nixpkgs> {} }:

let
  inherit (nixpkgs) pkgs;

  mudcore = pkgs.callPackage ./mudcore.nix {
    lua = pkgs.lua5_2;
    zeromq = pkgs.zeromq4;
  };
in
  mudcore
