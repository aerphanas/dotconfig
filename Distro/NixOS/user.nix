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
        firefox
        gimp
        libreoffice
        vscode-fhs
        obs-studio
        megacmd
        git
        # ngrok
        tdesktop
        libsForQt5.kdenlive
        thunderbird
        openal
        cava
        qpwgraph
        easyeffects
        audacity
        # jetbrains.idea-community
        maven
        gnome-builder
        flatpak-builder
        dotnet-sdk_7
        discord
        jupyter
        ihaskell
        python3Full
        python310Packages.pip
        python310Packages.jupyterlab
        clojure
        emacs-gtk
        leiningen
        #roswell
        # sbcl
        haskellPackages.yst
        nodejs
        ran
        racket
      ];
    };
  };
  
}