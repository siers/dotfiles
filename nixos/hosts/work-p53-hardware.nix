# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot.initrd.availableKernelModules = [ "xhci_pci" "thunderbolt" "nvme" "usbhid" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

  # boot.initrd.kernelModules = [ ];
  # boot.kernelModules = [ "kvm-intel" ];
  # boot.extraModulePackages = [ ];

  boot.initrd.luks.devices.enc-root.device = "/dev/disk/by-label/enc-part";

  fileSystems = pkgs.lib.recursiveUpdate {
    "/" = { device = "/dev/mapper/enc-root"; fsType = "ext4"; options = ["noatime"]; };
    "/boot" = { device = "/dev/disk/by-partlabel/EFI\\x20system\\x20partition"; fsType = "vfat"; options = ["noatime" "nofail"]; };
    "/tmp" = { device = "tmpfs"; fsType = "tmpfs"; options = ["nosuid" "nodev" "relatime"]; };
  } (import ../modules/syncthing.nix { inherit (pkgs.lib) recursiveUpdate; excluding = [ "pdf" ]; });

  swapDevices = [ { device = "/var/swapfile"; size = 4000; } ];

  nix.maxJobs = lib.mkDefault 4;
  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";
  # hardware.cpu.intel.updateMicrocode = true;

  # hardware.opengl.enable = true;
  # hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.stable;
  # hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.legacy_390;
  # hardware.nvidia.modesetting.enable = true;
  # services.xserver.videoDrivers = [ "nvidia" "modesetting" ];
  # services.xserver.videoDrivers = [ "modesetting" ];

  # environment.systemPackages = [ pkgs.nvidia-offload ];

  # hardware.nvidia.prime.sync.enable = true;
  # hardware.nvidia.prime.nvidiaBusId = "PCI:3:0:0";
  # hardware.nvidia.prime.intelBusId = "PCI:0:2:0";

  # boot.kernelParams = [ "module_blacklist=i915" ];

  ### Regular

  # hardware.nvidia.modesetting.enable = true;
  # services.xserver.videoDrivers = [ "nvidia" "modesetting" ];
  # hardware.opengl.enable = true;
  # hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.stable;

  # nixpkgs.config.allowUnfree = true;
  # services.xserver.videoDrivers = [ "nvidia" ];
  # hardware.opengl.enable = true;
  # # Optionally, you may need to select the appropriate driver version for your specific GPU.
  # hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.stable;
  # # nvidia-drm.modeset=1 is required for some wayland compositors, e.g. sway
  # hardware.nvidia.modesetting.enable = true;
}
