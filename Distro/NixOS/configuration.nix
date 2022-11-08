{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
    ];

  networking = {
    hostName = "nixos-20aws1hl002";
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

  time.timeZone = "Asia/Jakarta";

  i18n.defaultLocale = "en_US.UTF-8";
  console.keyMap = "colemak";

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
      chrome-gnome-shell.enable = true;
      gnome-keyring.enable = true;
      gnome-initial-setup.enable = false;
      gnome-online-accounts.enable = true;
      gnome-remote-desktop.enable = true;
      rygel.enable = true;
      gnome-user-share.enable = true;
      tracker.enable = true;
      sushi.enable = true;
      tracker-miners.enable = true;
      gnome-settings-daemon.enable = true;
      core-shell.enable = true;
      core-utilities.enable = true;
      evolution-data-server.enable = true;
      glib-networking.enable = true;
      gnome-online-miners.enable = true;
    };
    tlp = {
      enable = true;
    };
    openssh.enable = false;
    power-profiles-daemon.enable = false;
    earlyoom.enable = true;
    fstrim.enable = true;
    flatpak.enable = true;
    printing.enable = true;
  };

  hardware = {
    opengl = {
      driSupport = true;
      driSupport32Bit = true;
      extraPackages = [
        pkgs.intel-compute-runtime
        pkgs.intel-media-driver
        pkgs.vaapiIntel
        pkgs.vaapiVdpau
        pkgs.libvdpau-va-gl
      ];
    };
    cpu.intel.updateMicrocode = true;
    pulseaudio.enable = false;
    bluetooth.enable = true;
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
      home = "/home/adivin";
      autoSubUidGidRange = true;
      extraGroups = [ "wheel" "networkmanager" "libvirtd" ];
      packages = [ pkgs.git pkgs.firefox pkgs.gimp pkgs.libreoffice pkgs.vscode-fhs ];
    };
  };

  nix = {
    allowedUsers = [ "adivin" ];
    trustedUsers = [ "root" "adivin" ];
  };
  nixpkgs.config.allowUnfree = true;

  environment = {
    systemPackages = with pkgs; [
      # virtualisation
      virt-manager

      # firefox
      # gimp
      # libreoffice

      # SystemTools
      micro
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
    ];
  };

  programs = {
    mtr.enable = true;
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
    dconf.enable = true;
  };

  virtualisation = {
    libvirtd.enable = true;
    podman = {
      enable = true;
      networkSocket.openFirewall = true;
    };
  };

  system.stateVersion = "22.05";

}
