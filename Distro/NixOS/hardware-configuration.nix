{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot = {
    kernelModules = [ "kvm-intel" ];
    extraModulePackages = [ ];
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    initrd = {
      enable = true;
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

  #hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}