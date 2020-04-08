{ config, pkgs, ... }:

{
  imports =
  [
    ./inspiron-hardware.nix
    <nixos-hardware/lenovo/thinkpad/t480s>
    # ../lib/packages/steam.nix
    ../lib/libinput.nix
  ];

  networking.hostName = "t480";

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.initrd.luks.devices = [
    { name = "enc-vg"; device = "/dev/disk/by-uuid/a4ee2444-0bc4-4d6c-9754-c7f2353cca35"; preLVM = true; allowDiscards = true; } # /dev/sda3
    { name = "enc-home"; device = "/dev/disk/by-uuid/79e9c6d6-6c41-4951-95c2-a98dafe11507"; preLVM = true; allowDiscards = true; } # /dev/sda4
  ];

  fileSystems = [
    { mountPoint = "/"; device = "/dev/vg/root"; fsType = "ext4"; options = ["noatime"]; }
    { mountPoint = "/boot"; device = "/dev/sda2"; fsType = "vfat"; options = ["noatime" "nofail"]; }
    { mountPoint = "/home"; device = "/dev/mapper/enc-home"; fsType = "ext4"; options = ["noatime" "nofail"]; }
    { mountPoint = "/tmp"; device = "tmpfs"; fsType = "tmpfs"; options = ["nosuid" "nodev" "relatime"]; }
  ] ++ import ../lib/syncthing.nix {};

  swapDevices = [ { device = "/dev/vg/swap"; } ];

  #

  services = (import ../lib/xserver.nix).xfce-i3-backlight;

  hardware.cpu.intel.updateMicrocode = true;

  virtualisation.virtualbox.host = {
    enable = true;
    headless = true;
  };

  environment.systemPackages = (import ../lib/package-sets.nix { inherit pkgs; }).everything;
}
