{ config, pkgs, ... }: {

  time.timeZone = "Asia/Jakarta";
  i18n.defaultLocale = "en_US.UTF-8";
  console.keyMap = "colemak";
  
  environment = {
    homeBinInPath = true;
    localBinInPath = true;
    sessionVariables = {
      DOTNET_ROOT = "${pkgs.dotnet-sdk_7}";
    };
    gnome.excludePackages = with pkgs; [
      gnome.geary
      gnome.gnome-maps
      gnome.cheese
      gnome.gnome-contacts
    ];
    systemPackages = with pkgs; [
      # screensaver
      # pipes
      # terminal-parrot
      # asciiquarium
      # globe-cli
      # cbonsai
      
      # archive
      rar
      unrar
      zip
      unzip
    
      # virtualisation
      virt-manager
      
      # SystemTools
      wget
      # gparted
      
      # FileSystemSupport
      # zfs
      lvm2
      exfat
      ntfs3g
      # hfsprogs
      # jfsutils
      udftools
      # xfsprogs
      e2fsprogs
      # f2fs-tools
      dosfstools
      util-linux
      cryptsetup
      # nilfs-utils
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
    java.enable = true;
  };
  
  virtualisation = {
    libvirtd.enable = true;
    docker.enable = true;
  };
  
  #zramSwap = {
  #  enable = true;
  #  algorithm = "zstd";
  #};
  
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
  
  documentation = {
    enable = true;
    man.enable = true;
    doc.enable = true;
    info.enable = true;
    dev.enable = true;
    nixos.enable = true;
  };
  
}