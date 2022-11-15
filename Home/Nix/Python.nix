with (import (fetchTarball https://github.com/nixos/nixpkgs/archive/nixpkgs-unstable.tar.gz) {});

let Deps = ps: with ps; [ pip wheel cython ];
    Env = python3.withPackages Deps;
in  mkShell {
      buildInputs = [ Env ];
      shellHook = ''
        python -m venv env
        source env/bin/activate
      '';
    }