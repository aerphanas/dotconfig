{ config, pkgs, ... }: {

users = {
    users.adivin = {
      isNormalUser = true;
      name = "adivin";
      description = "Muhammad Aviv Burhanudin";
      shell = pkgs.fish;
      createHome = true;
      home = "/home/adivin";
      autoSubUidGidRange = true;
      extraGroups = [ "wheel" "networkmanager" "libvirtd" "docker" ];
      packages = with pkgs; [
        firefox-wayland
        gimp
        libreoffice
        vscode-fhs
        obs-studio
        megacmd
        git
        ngrok
        tdesktop
        libsForQt5.kdenlive
        thunderbird
        gnomeExtensions.pop-shell
        openal
        cava
      ];
    };
  };
  
}
