{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];
    
  boot = {
    consoleLogLevel = 0;
    kernelModules = [ "kvm-intel" "v4l2loopback" ];
    kernelPackages = pkgs.linuxPackages_6_0;
    extraModulePackages = [ pkgs.linuxKernel.packages.linux_6_0.v4l2loopback ];
    loader = {
      systemd-boot = {
        enable = true;
        consoleMode = "keep";
        memtest86.enable = true;
        configurationLimit = 7;
      };
      efi.canTouchEfiVariables = true;
    };
    initrd = {
      enable = true;
      verbose = true;
      compressor = "cat";
      supportedFilesystems = [ "btrfs" "ext4" ];
      availableKernelModules = [ "xhci_pci" "ehci_pci" "ahci" "usb_storage" "usbhid" "sd_mod" "sr_mod" "rtsx_pci_sdmmc" ];
      kernelModules = [ "dm-snapshot" ];
      secrets = { "/bianca" = /root/bianca; };
      luks.devices."rootfs" = {
        device = "/dev/disk/by-uuid/1d60fcfa-e404-4903-8c66-fdc86e4bc595";
        preLVM = false;
      };
      luks.devices."userfs" = {
        device = "/dev/disk/by-uuid/89609626-f197-438d-918b-fe789ff858a3";
        keyFile = "/bianca";
        preLVM = true;
      };
    };
  };

  fileSystems."/" = {
      device = "/dev/disk/by-uuid/0a1ae8b0-cdc4-4708-a551-2253229c91e5";
      fsType = "btrfs";
    };
    
  fileSystems."/home/adivin" = {
      device = "/dev/disk/by-uuid/3efcee78-2bc1-4311-9e0a-8105eabfea36";
      fsType = "ext4";
  };
  
  fileSystems."/boot" = { 
      device = "/dev/disk/by-uuid/152A-EDFF";
      fsType = "vfat";
    };

  swapDevices = [ ];

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
  #hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
