{ config, ... }: {

  networking = {
    hostName = "nixos-20aws1hl002";
    nameservers = [ "1.1.1.1" "1.0.0.1" "2606:4700:4700::1111" "2606:4700:4700::1001" ];
    useDHCP = false;
    interfaces.enp0s25.useDHCP = true;
    interfaces.enp0s25.wakeOnLan.enable = true;
    interfaces.wlp3s0.useDHCP = true;
    firewall = {
      enable = true;
      allowedTCPPorts = [ 
        443                           #HTTPS
        80                            #HTTP
        8080                          #HTTP Alternate
        22                            #SSH
        53                            #DNS
        1194                          #Openvpn
        27036                         #Steam ; Remote Play
        27015                         #Steam ; SRCDS Rcon port
        3389                          #Gnome Rdp
        34545
        143                           #IMAP
        993                           #IMAP3
        ];
      allowedUDPPorts = [
        443                           #HTTPS
        80                            #HTTP
        8080                          #HTTP Alternate
        22                            #SSH
        53                            #DNS
        1194                          #Openvpn
        4380                          #Steam
        27015                         #Steam : gameplay traffic
        3478                          #Steam : Steamworks P2P Networking and Steam Voice Chat
        4379                          #Steam : Steamworks P2P Networking and Steam Voice Chat
        4380                          #Steam : Steamworks P2P Networking and Steam Voice Chat
        3389                          #Gnome Rgp
        1900                          #Gnome Rygel
        34545
      ];
      allowedTCPPortRanges = [
        { from = 27015; to = 27030; } # Steam : To log into Steam and download content
        { from = 19302; to = 19309; } # Google : meet
        { from = 1714;  to = 1764;  } # KDE Connect
      ];
      allowedUDPPortRanges = [
        { from = 27015; to = 27030; } # Steam : To log into Steam and download content
        { from = 27000; to = 27100; } # Steam : Game traffic
        { from = 27031; to = 27036; } # Steam : Remote Play
        { from = 19302; to = 19309; } # Google : meet
        { from = 50000; to = 65535; } # Discord
      ];
    };
    nat = {
      enable = true;
      internalInterfaces = ["ve-+"];
      externalInterface = "enp0s25";
      enableIPv6 = true;
    };
  };
  
}