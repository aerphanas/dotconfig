{ config, pkgs, ... }:

let nixos-unstable = import <nixos-unstable> {
      config = removeAttrs config.nixpkgs.config [ "packageOverrides" ];
    };
in {
  disabledModules = [
    "services/networking/minidlna.nix"
  ];
  
  imports = [ 
    ./hardware-configuration.nix
    ./container.nix
    ./network.nix
    ./service.nix
    ./system.nix
    ./user.nix
    <nixos-unstable/nixos/modules/services/networking/minidlna.nix>
  ];
  
  nix = {
    allowedUsers = [ "adivin" ];
    trustedUsers = [ "root" "adivin" ];
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
      # for Haskell.nix
      trusted-public-keys = [ "hydra.iohk.io:f/Ea+s+dFdN+3Y/G+FDgSq+a5NEWhJGzdjvKNGv0/EQ=" ];
      substituters = [ "https://cache.iog.io" ];
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
  };
  
  nixpkgs.config = {
    allowUnfree = true;
    #allowBroken = true;
    packageOverrides = pkgs: {
      nixpkgs-unstable = import <nixpkgs-unstable> { config = config.nixpkgs.config; };
    };
  };
  
  system = {
    copySystemConfiguration = true;
    stateVersion = "22.05";
  };
  
}

