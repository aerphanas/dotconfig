{ config, pkgs, ... }:

let
  nixos-unstable = import <nixos-unstable> {
    config = removeAttrs config.nixpkgs.config [ "packageOverrides" ];
  };
in
{
  disabledModules = [
    "services/networking/minidlna.nix"
  ];
  imports = [ 
    ./hardware-configuration.nix
    <nixos-unstable/nixos/modules/services/networking/minidlna.nix>
  ];
    
  time.timeZone = "Asia/Jakarta";
  i18n.defaultLocale = "en_US.UTF-8";
  console.keyMap = "colemak";
  
  networking = {
    hostName = "nixos-20aws1hl002";
    nameservers = [ "1.1.1.1" "1.0.0.1" "2606:4700:4700::1111" "2606:4700:4700::1001" ];
    useDHCP = false;
    interfaces.enp0s25.useDHCP = true;
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
  };
  
  services = {
    xserver = {
      enable = true;
      displayManager.gdm.enable = true;
      desktopManager.gnome.enable = true;
      layout = "us";
      xkbVariant = "colemak";
      libinput.enable = true;
      videoDrivers = [ "modesetting" ];
      useGlamor = true;
    };
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
    };
    gnome = {
      games.enable = false;
      gnome-keyring.enable = true;
      gnome-initial-setup.enable = false;
      gnome-online-accounts.enable = true;
      gnome-remote-desktop.enable = true;
      gnome-user-share.enable = true;
      gnome-settings-daemon.enable = true;
      gnome-online-miners.enable = true;
      chrome-gnome-shell.enable = true;
      rygel.enable = true;
      tracker.enable = true;
      sushi.enable = true;
      tracker-miners.enable = true;
      core-shell.enable = true;
      core-utilities.enable = true;
      evolution-data-server.enable = true;
      glib-networking.enable = true;
    };
    tlp = {
      enable = true;
    };
    openssh = {
      enable = true;
      ports = [ 22 ];
      openFirewall = true;
      startWhenNeeded = true;
      permitRootLogin = "yes";
      passwordAuthentication = true;
    };
    minidlna = {
      enable = true;
      openFirewall = true;
      settings.wide_links = "yes";
      settings.inotify = "yes";
      settings.log_level = "general,artwork,database,inotify,scanner,metadata,http,ssdp,tivo=warn";
      settings.media_dir = [
        "/data/media/"
      ];
    };
    power-profiles-daemon.enable = false;
    earlyoom.enable = true;
    fstrim.enable = true;
    flatpak.enable = true;
    printing = {
      enable = true;
      startWhenNeeded = true;
    };
  };
  
  security = {
    rtkit.enable = true;
    sudo.enable = false;
    doas = {
      enable = true;
      wheelNeedsPassword = true;
      extraRules = [
        {
          groups = [ "wheel" ];
          noPass = false;
          keepEnv = true;
          persist = true;
        }
      ];
    };
  };
  
  users = {
    users.adivin = {
      isNormalUser = true;
      name = "adivin";
      description = "Muhammad Aviv Burhanudin";
      shell = pkgs.fish;
      createHome = true;
      home = "/home/adivin";
      autoSubUidGidRange = true;
      extraGroups = [ "wheel" "networkmanager" "libvirtd" "docker" "minidlna"];
      packages = with pkgs; [
        firefox-wayland
        gimp
        libreoffice
        vscode-fhs
        obs-studio
        neofetch
        megacmd
        git
        ngrok
        zim
        tdesktop
        cli-visualizer
        libsForQt5.kdenlive
      ];
    };
  };
  
  environment = {
    homeBinInPath = true;
    localBinInPath = true;
    systemPackages = with pkgs; [
      # screensaver
      pipes
      terminal-parrot
      asciiquarium
      globe-cli
      cbonsai
      
      # archive
      rar
      unrar
      zip
      unzip
    
      # virtualisation
      virt-manager
      
      # SystemTools
      wget
      gparted
      
      # FileSystemSupport
      zfs
      lvm2
      exfat
      ntfs3g
      hfsprogs
      jfsutils
      udftools
      xfsprogs
      e2fsprogs
      f2fs-tools
      dosfstools
      util-linux
      cryptsetup
      nilfs-utils
      btrfs-progs
      
      # customize
      gnome.gnome-tweaks
      papirus-icon-theme
      capitaine-cursors
      v4l-utils
      
      # container
      tilix
      docker-credential-helpers
    ];
  };
  fonts = {
    fontDir.enable = true;
    fonts = with pkgs; [
      noto-fonts
      noto-fonts-cjk
      noto-fonts-emoji
      liberation_ttf
      fira-code
      fira-code-symbols
      mplus-outline-fonts.githubRelease
      dina-font
      proggyfonts
      redhat-official-fonts
      ubuntu_font_family
      hack-font
      corefonts
      hasklig
    ];
  };
  programs = {
    mtr.enable = true;
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
    fish = {
      enable = true;
      vendor.completions.enable = true;
    };
    dconf.enable = true;
  };
  
  virtualisation = {
    libvirtd.enable = true;
    docker.enable = true;
  };
  
  zramSwap = {
    enable = true;
    algorithm = "zstd";
  };
  nix = {
    allowedUsers = [ "adivin" ];
    trustedUsers = [ "root" "adivin" ];
    settings.experimental-features = [ "nix-command" "flakes" ];
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
