{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  buildInputs = [
    pkgs.kubernetes-helm
    pkgs.gnumake
  ];
}