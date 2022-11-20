{ config, ... }: {

  containers.webserver = {
    config = { config, pkgs, ... } : {
      boot.isContainer = true;
      networking.hostName = "webserver";
      networking.useDHCP = false;
      system.stateVersion = "22.05";
      services = { 
        httpd = {
          enable = true;
          adminAddr = "foo@example.org";
        };
      };
      networking.firewall.allowedTCPPorts = [ 80 ];
    };
  };
  
}
