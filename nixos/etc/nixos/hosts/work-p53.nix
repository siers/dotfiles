{ config, pkgs, lib, ... }:

{
  imports =
  [
    ./work-p53-hardware.nix
    <nixos-hardware/lenovo/thinkpad/p53>

    ../lib/libinput.nix
    ../lib/openvpn.nix
    ../lib/printing.nix
    ../lib/backlight.nix
    ../lib/prometheus.nix
    ../lib/evolution.nix
  ];

  networking.hostName = "rv-p53";

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  #

  services = lib.attrsets.recursiveUpdate
    (import ../lib/xserver.nix).xfce-i3
    {
    };

  # xserver.videoDrivers = [ "modesetting" "nvidia" ];
  # xserver.config = ''
  #   Section "OutputClass"
  #     Identifier "nvidia"
  #     MatchDriver "nvidia-drm"
  #     Driver "nvidia"

  #     Option "PrimaryGPU" "Yes"
  #     Option "AllowEmptyInitialConfiguration"
  #   EndSection
  # '';
  # hardware.nvidia.optimus_prime = {
  #   enable = true;
  #   # Bus ID of the NVIDIA GPU. You can find it using lspci, either under 3D or VGA
  #   nvidiaBusId = "PCI:3c:00:0";
  #   # Bus ID of the Intel GPU. You can find it using lspci, either under 3D or VGA
  #   intelBusId = "PCI:0:2:0";
  # };

  #

  virtualisation.virtualbox.host = {
    enable = true;
    headless = true;
  };

  environment.systemPackages = (import ../lib/package-sets.nix { inherit pkgs; }).everything ++ [
  ];

  fonts = {
    # fonts = [ pkgs.google-fonts ];
  };
}
