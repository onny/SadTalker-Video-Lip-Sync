{ pkgs ? import <nixpkgs> {} }:
let
  pretrained_models = builtins.fetchTarball {
    url = "http://dev.project-insanity.org:8080/checkpoints.tar.gz";
  };
in
(pkgs.buildFHSUserEnv {
  name = "pipzone";
  targetPkgs = pkgs: (with pkgs; [
    python3
    python3Packages.pip
    python3Packages.virtualenv
    #python3Packages.numpy
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
    cp ${pretrained_models}/* checkpoints/
    echo "try using it: python inference.py --driven_audio examples/driven_audio/chinese_poem1.wav --source_video sync_show/original.mp4 --enhancer lip --use_DAIN --time_step 0.5"
    bash
  '';
}).env
