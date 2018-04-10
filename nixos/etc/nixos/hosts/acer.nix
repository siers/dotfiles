{ config, pkgs, ... }:

{
  imports =
    [ ./acer-hardware.nix
    ];

  networking.hostName = "acer"; # Define your hostname.


  hardware.cpu.intel.updateMicrocode = true;

  boot = {
    kernelParams = ["acpi_backlight=vendor"];

    # $ cd /boot; mkdir -p EFI/Microsoft/Boot; cp EFI/BOOT/BOOTX64.EFI EFI/Microsoft/Boot/bootmgfw.efi
    loader.grub = { enable = true; device = "nodev"; efiSupport = true; efiInstallAsRemovable = true; };
    loader.systemd-boot.enable = true;

    initrd.luks.devices = [{ name = "enc-vg"; device = "/dev/sda8"; preLVM = true; allowDiscards = true; }];
  };

  fileSystems = [
    { mountPoint = "/"; device = "/dev/disk/by-uuid/00c80c0f-1459-4b0a-ab88-d3b9313e22e7"; fsType = "ext4"; options = ["noatime"]; }
    { mountPoint = "/boot"; device = "/dev/sda1"; fsType = "vfat"; options = ["noatime" "nofail"]; }
    { mountPoint = "/tmp"; device = "tmpfs"; fsType = "tmpfs"; options = ["nosuid" "nodev" "relatime"]; }
  ] ++ import ../lib/syncthing.nix;

  swapDevices = [ { device = "/dev/vg/swap"; } ];

  services = (import ../lib/xserver.nix).i3;

  environment.systemPackages = (import ../lib/package-sets.nix { inherit pkgs; }).everything;
}
