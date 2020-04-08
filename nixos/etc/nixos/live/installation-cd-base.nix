{ config, lib, pkgs, ... }:

with lib;

# extracted parts of installation-cd-base.nix without profiles/installation-device.nix

{
  imports =
    [
      # from installation/installation-cd-base.nix
      <nixpkgs/nixos/modules/installer/cd-dvd/iso-image.nix>
      # <nixpkgs/nixos/modules/installer/cd-dvd/channel.nix>
      <nixpkgs/nixos/modules/profiles/all-hardware.nix>

      # from profiles/installation-device.nix
      # <nixpkgs/nixos/modules/profiles/base.nix>
    ];

  ### from profiles/installation-device.nix
  environment.variables.GC_INITIAL_HEAP_SIZE = "1M";

  ### from installation/installation-cd-base.nix

  # ISO naming.
  isoImage.isoName = "${config.isoImage.isoBaseName}-${config.system.nixos.label}-${pkgs.stdenv.hostPlatform.system}.iso";

  isoImage.volumeID = substring 0 11 "NIXOS_ISO";

  # EFI booting
  isoImage.makeEfiBootable = true;

  # USB booting
  isoImage.makeUsbBootable = true;

  # Add Memtest86+ to the CD.
  boot.loader.grub.memtest86.enable = true;

  system.stateVersion = mkDefault "18.03";
}
