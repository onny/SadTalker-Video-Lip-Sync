{
  description = "FHS shell for SadTalker";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs, home-manager }:
    let
      pkgs = nixpkgs.legacyPackages.x86_64-linux;
    in {
      devShell.x86_64-linux = (pkgs.buildFHSUserEnv {
        name = "sadtalker";
        targetPkgs = pkgs: (
          with pkgs; with pkgs.python3Packages; [
            python3
            libglvnd
            glib
          ] ++ [
            pip
            virtualenv
            numpy
            scipy
            torch
            torchvision
            torchaudio
          ]
        );
        profile = ''
        '';
      }).env;
    };
}
