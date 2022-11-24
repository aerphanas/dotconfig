{ config, pkgs, ... }: {

  containers.haskell-devel = {
    privateNetwork = true;
    hostAddress = "192.168.100.10";
    localAddress = "192.168.100.11";
    config = { config, pkgs, ... } : {
      boot.isContainer = true;
      
      networking = {
        hostName = "haskell-devel";
        useDHCP = false;
        firewall = {
          enable = true;
          allowedTCPPorts = [ 3000 4000 ];
        };
      };
      
      users = {
        users.orpheus = {
          isNormalUser = true;
          name = "orpheus";
          description = "orpheus user";
          createHome = true;
          home = "/home/orpheus";
          extraGroups = [ "users" ];
          packages = with pkgs; [
            git
            curl
            wget
            tmux
            openvscode-server
            elmPackages.elm
            HaskellEnv
          ];
        };
      };
      
      fonts = {
        fontDir.enable = true;
        fonts = with pkgs; [
          hasklig
        ];
      };
      
      programs = {
        gnupg.agent = {
          enable = true;
          enableSSHSupport = true;
          pinentryFlavor = "curses";
        };
      };
      
      nixpkgs.config = {
        packageOverrides = super: let self = super.pkgs; in {
          HaskellEnv = self.haskell.packages.ghc924.ghcWithHoogle (
            haskellPackages: with haskellPackages; [
            
              # libraries
              base
              containers
              hakyll
              
              # tools
              haskell-language-server
              cabal-install
              
            ]
          );
        };
      };
      
      system.stateVersion = "22.05";
    };
  };

  containers.lamp-server = {
    privateNetwork = true;
    hostAddress = "192.168.100.12";
    localAddress = "192.168.100.13";
    config = { config, pkgs, ... } : {
      boot.isContainer = true;
      
      networking = {
        hostName = "lamp-server";
        useDHCP = false;
        firewall = {
          enable = true;
          allowedTCPPorts = [ 80 443 ];
        };
      };
      
      services = {
        httpd = {
          enable = true;
          enablePHP = true;
          adminAddr = "webmaster@localhost";
          virtualHosts."localhost" = {
            listenAddresses = [ "192.168.100.13" ];
            documentRoot = "/var/www";
          };
        };
        
        mysql = {
          enable = true;
          package = pkgs.mariadb;
        };
      };
      
      environment.systemPackages = with pkgs; [
        curl
        wget
        git
      ];
      
      system.stateVersion = "22.05";
    };
  };
  
  containers.mariadb-server = {
    privateNetwork = true;
    hostAddress = "192.168.100.14";
    localAddress = "192.168.100.15";
    config = { config, pkgs, ... } : {
      boot.isContainer = true;
      networking = {
        hostName = "mariadb-server";
        useDHCP = false;
        firewall = {
          enable = true;
          allowedTCPPorts = [ 3306 ];
        };
      };
      services = {
        mysql = {
          enable = true;
          package = pkgs.mariadb;
        };
      };
      system.stateVersion = "22.05";
    };
  };

  containers.redis-server = {
    privateNetwork = true;
    hostAddress = "192.168.100.16";
    localAddress = "192.168.100.17";
    config = { config, pkgs, ... } : {
      boot.isContainer = true;
      networking = {
        hostName = "redis-server";
        useDHCP = false;
        firewall.enable = true;
      };
      services = {
        redis.servers.tartarus = {
          enable = true;
          syslog = true;
          port = 6379;
          databases = 2;
          openFirewall = true;
        };
      };
      system.stateVersion = "22.05";
    };
  };

}
