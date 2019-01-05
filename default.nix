{ nixpkgs ? import <nixpkgs> {} }:
with nixpkgs;
let
  commit = lib.substring 0 7 (lib.commitIdFromGitRepo ./.git);
  mudcore = callPackage (import ./mudcore.nix {
    name = "mudcore-git-${commit}";
    src = ./.;
  }) {
    lua = lua5_2;
    zeromq = zeromq4;
  };
in
  mudcore
