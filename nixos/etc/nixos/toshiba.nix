{ config, pkgs, ... }:

{
  imports =
    [
      ./toshiba-hardware-configuration.nix
    ];

  networking.hostName = "toshiba"; # Define your hostname.

  boot.loader.timeout = -1;
  boot.loader.grub = {
    enable = true;
    version = 2;
    device = "/dev/sda"; # or "nodev" for efi only
    extraEntries = ''
      menuentry "Microsoft Windows Vista/7/8/8.1/10 BIOS-MBR" {
        insmod part_msdos
        insmod ntfs
        insmod search_fs_uuid
        insmod ntldr
        search --fs-uuid --set=root --hint-bios=hd0,msdos1 --hint-efi=hd0,msdos1 --hint-baremetal=ahci0,msdos1 C406782E06782418
        ntldr /bootmgr
      }
    '';
  };

  boot.extraModprobeConfig = "options snd-hda-intel model=generic";

  boot.initrd.luks.devices = [
    { name = "enc-vg"; device = "/dev/sda3"; preLVM = true; allowDiscards = true; }
  ];

  fileSystems = [
    { mountPoint = "/"; device = "/dev/vg/root"; fsType = "ext4"; options = ["noatime"]; }
    { mountPoint = "/boot"; device = "/dev/sda1"; fsType = "ntfs"; options = ["noatime" "nofail"]; }
    { mountPoint = "/tmp"; device = "tmpfs"; fsType = "tmpfs"; options = ["nosuid" "nodev" "relatime"]; }

    { mountPoint = "/tmp"; device = "/home/s"; options = ["bind"]; }
  ];

  swapDevices = [ { device = "/dev/vg/swap"; } ];
}
