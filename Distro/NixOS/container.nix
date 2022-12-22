{ config, pkgs, ... }: {

  containers.haskell-devel = {
    privateNetwork = true;
    hostAddress = "192.168.100.10";
    localAddress = "192.168.100.11";
    allowedDevices = [
      {
        modifier = "mrw";
        node = "/dev/snd";
      }
    ];
    bindMounts."/dev/snd".hostPath = "/dev/snd";
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
            sox
          ];
        };
      };
      
      fonts = {
        fontDir.enable = true;
        fonts = with pkgs; [
          hasklig
        ];
      };
      sound.enable = true;
      programs = {
        gnupg.agent = {
          enable = true;
          enableSSHSupport = true;
          pinentryFlavor = "curses";
        };
      };
      
      nixpkgs.config = {
        packageOverrides = super: let self = super.pkgs; in {
          HaskellEnv = self.haskell.packages.ghc902.ghcWithPackages (
            haskellPackages: with haskellPackages; [
              # libraries
              hakyll
              
              # tools
              haskell-language-server
              cabal-install
              ghci-dap
              haskell-debug-adapter
            ]
          );
        };
      };
      
      system.stateVersion = "22.11";
    };
  };

  containers.lamp-server = {
    privateNetwork = true;
    hostAddress = "192.168.100.16";
    localAddress = "192.168.100.17";
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
      
      system.stateVersion = "22.11";
    };
  };
  
  containers.mariadb-server = {
    privateNetwork = true;
    hostAddress = "192.168.100.18";
    localAddress = "192.168.100.19";
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
      system.stateVersion = "22.11";
    };
  };

  containers.redis-server = {
    privateNetwork = true;
    hostAddress = "192.168.100.20";
    localAddress = "192.168.100.21";
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
      system.stateVersion = "22.11";
    };
  };

}