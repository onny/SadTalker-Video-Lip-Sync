{ pkgs ? import <nixpkgs> {} }:
let
  pretrained_models = fetchzip {
    url = "";
    hash = "";
  };
in
(pkgs.buildFHSUserEnv {
  name = "pipzone";
  targetPkgs = pkgs: (with pkgs; [
    python3
    python3Packages.pip
    python3Packages.virtualenv
    python3Packages.numpy
    python3Packages.scipy
    python3Packages.torch
    python3Packages.torchvision
    python3Packages.torchaudio
    libglvnd
    glib
  ]);
  #runScript = "bash";
  runScript = pkgs.writeScript "sadtalker-setup" ''
    #!${pkgs.runtimeShell}
    virtualenv venv
    source venv/bin/activate
    mkdir -p tmp
    TMPDIR=tmp pip install -r requirements.txt
    ls ${pretrained_models}
    poop
    bash
  '';
}).env
