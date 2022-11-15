with (import <nixpkgs> {});

let
  haskellDeps = ps: with ps; [
    base
    haskell-language-server
    containers
  ];
  haskellEnv = haskell.packages.ghc924.ghcWithPackages haskellDeps;
in mkShell {
  buildInputs = [
    haskellEnv
    haskellPackages.cabal-install
  ];
}
