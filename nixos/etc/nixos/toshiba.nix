{ config, pkgs, ... }:

{
  imports =
    [
      ./toshiba-hardware-configuration.nix
    ];

  networking.hostName = "toshiba"; # Define your hostname.

  hardware.cpu.intel.updateMicrocode = true;

  boot = {
    loader.timeout = -1;
    loader.grub = {
      enable = true;
      version = 2;
      device = "/dev/sda"; # or "nodev" for efi only
      extraEntries = ''
        menuentry "Microsoft Windows Vista/7/8/8.1/10 BIOS-MBR" {
        insmod part_msdos
        insmod ntfs
        insmod search_fs_uuid
        insmod ntldr
        # get that UUID wrong and windows will screw around with grub and render system unbootable
        search --fs-uuid --set=root --hint-bios=hd0,msdos1 --hint-efi=hd0,msdos1 --hint-baremetal=ahci0,msdos1 4012AA8B7E6CB042
        ntldr /bootmgr
        }
      '';
    };

    extraModprobeConfig = "options snd-hda-intel model=generic";

    initrd.luks.devices = [
      { name = "enc-vg"; device = "/dev/sda3"; preLVM = true; allowDiscards = true; }
    ];
  };

  fileSystems = [
    { mountPoint = "/"; device = "/dev/vg/root"; fsType = "ext4"; options = ["noatime"]; }
    { mountPoint = "/boot"; device = "/dev/sda1"; fsType = "ntfs"; options = ["noatime" "nofail"]; }
    { mountPoint = "/tmp"; device = "tmpfs"; fsType = "tmpfs"; options = ["nosuid" "nodev" "relatime"]; }
  ] ++
  (map
    (dir: {
      mountPoint = "/home/s/" + dir;
      device = "/home/s/.syncthing/shares/home/" + dir;
      options = ["bind"];
    })
    ["audio" "bin" "code" "data" "foto" "hack" "http" "log" "pdf"])
  ;

  swapDevices = [ { device = "/dev/vg/swap"; } ];
}
