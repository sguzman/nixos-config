# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, ... }:

{
  imports =
    [ <nixpkgs/nixos/modules/installer/scan/not-detected.nix>
    ];

  boot.initrd.availableKernelModules = [ "uhci_hcd" "ehci_pci" "ahci" "usbhid" "usb_storage" "sd_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" "zfs" ];
  boot.extraModulePackages = [ ];
  boot.supportedFilesystems = [ "zfs" ];

  #hardware.bluetooth.enable = true;

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/6416d4f1-57d7-4c2e-9279-3de087956fa5";
      fsType = "ext4";
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/4e73a4a7-cbf6-485c-9d24-29974a9e54e9";
      fsType = "ext4";
    };

  fileSystems."/home/sguzman/data" =
    { device = "storage";
      fsType = "zfs";
    };

  fileSystems."/home/sguzman/data/dl" =
    { device = "storage/dl";
      fsType = "zfs";
    };

  fileSystems."/home/sguzman/data/db" =
    { device = "storage/db";
      fsType = "zfs";
    };

  swapDevices =
    [ { device = "/dev/disk/by-uuid/ac359d1c-1ab5-4432-b1ec-6361cfdeb584"; }
    ];

  nix.maxJobs = lib.mkDefault 8;
}
