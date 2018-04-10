{ config, pkgs, ... }:

{
  imports =
    [ ./inspiron-hardware.nix
    ];

  networking.hostName = "inspiron";

  hardware.cpu.intel.updateMicrocode = true;

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.initrd.luks.devices = [
    { name = "enc-vg"; device = "/dev/sda2"; preLVM = true; allowDiscards = true; }
    { name = "enc-home"; device = "/dev/sda3"; preLVM = true; allowDiscards = true; }
  ];

  fileSystems = [
    { mountPoint = "/"; device = "/dev/vg/root"; fsType = "ext4"; options = ["noatime"]; }
    { mountPoint = "/boot"; device = "/dev/sda1"; fsType = "vfat"; options = ["noatime" "nofail"]; }
    { mountPoint = "/home"; device = "/dev/mapper/enc-home"; fsType = "ext4"; options = ["noatime" "nofail"]; }
    { mountPoint = "/tmp"; device = "tmpfs"; fsType = "tmpfs"; options = ["nosuid" "nodev" "relatime"]; }
  ] ++ import ../lib/syncthing.nix;

  swapDevices = [ { device = "/dev/vg/swap"; } ];

  services = (import ../lib/xserver.nix).i3;

  environment.systemPackages = (import ../lib/package-sets.nix { inherit pkgs; }).everything;
}
