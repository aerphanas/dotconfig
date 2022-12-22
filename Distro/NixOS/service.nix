{ config, ... }: {

  services = {
    xserver = {
      enable = true;
      displayManager.gdm.enable = true;
      desktopManager.gnome.enable = true;
      layout = "us";
      xkbVariant = "colemak";
      libinput.enable = true;
      videoDrivers = [ "modesetting" ];
      #useGlamor = true;
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
      gnome-browser-connector.enable = true;
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
  
}