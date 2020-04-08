{ config, pkgs, ... }:

/*
export NIX_PATH=nixpkgs=$HOME/code/cache/nixpkgs # for mksquashfs patch
nix-build '<nixpkgs/nixos>' -A config.system.build.isoImage -I nixos-config=live/live.nix

# this runs mksquashfs for the whole output image, which takes time if you have a big image
# mksquashfs /nix/store/-squashfs.img -keep-as-directory -all-root -b 1048576 -comp xz -Xdict-size 100%
# so to make this run fast, clone nixpkgs, append -noI -noD -noF in make-squashfs.nix to remove compression
*/

let
  deviceName = "/dev/disk/by-id/usb-_USB_DISK_2.0_07035CAF1846F268-0:0";
  imageOffset = "29410455552";
  imageSize = "2147483648";

  stow-home = pkgs.writeShellScriptBin "stow-home" ''
    chown s:users ~s
    cd ~s/code/desktop/dotfiles
    ${pkgs.utillinux}/bin/runuser -u s stow -t ~s ack git nix shells ssh tmux vim x zsh
  '';
in

{
  imports =
    [
      ./installation-cd-base.nix
      ./../lib/base.nix
      ./../lib/services.nix
    ];

  networking.hostName = "nixos-live";
  networking.wireless.enable = false; # because services.nix starts wireless

  programs.zsh.enable = true;

  services = (import ../lib/xserver.nix).xfce-i3-backlight;

  environment.systemPackages = builtins.concatLists [
    ((import ../lib/package-sets.nix { inherit pkgs; }).live)
    (with pkgs; [
      #
    ])
  ];

  #

  boot.initrd.extraUtilsCommands = ''
    copy_bin_and_libs ${pkgs.utillinux}/bin/losetup
  '';

  boot.initrd.luks.forceLuksSupportInInitrd = true;
  boot.initrd.preLVMCommands = ''
    # https://github.com/NixOS/nixpkgs/blob/e10c65cdb/nixos/modules/system/boot/luksroot.nix#L108
    mkdir -p /crypt-ramfs
    mount -t ramfs none /crypt-ramfs
    mkdir -p /run/cryptsetup

    w() { [ -e "${deviceName}" ] || (sleep 1; false); }
    www() { w || w || w; }
    www || www || www || echo "cannot find ${deviceName}"

    imageOffset="$([ -e ${deviceName} ] && echo ${imageOffset} || echo 5\000\000\000)"
    bootdev="$(find 2>&- "${deviceName}" /dev/sr0 | head -1)"
    loopdev="$($out/bin/losetup --show -fo $imageOffset --sizelimit ${imageSize} $bootdev)"

    if ! $out/bin/cryptsetup open "$loopdev" enc-home; then
      echo "cryptsetup faiure: $?"
      sh
    fi
  '';

  boot.initrd.postDeviceCommands = ''
    umount /crypt-storage 2>/dev/null
    umount /crypt-ramfs 2>/dev/null
  '';

  systemd.services.stow = {
    wantedBy = [ "multi-user.target" ];
    after = [ "home-s-code.mount" ];
    description = "stow files";
    serviceConfig = {
      Type = "simple";
      User = "root";
      ExecStart = ''${stow-home}/bin/stow-home'';
    };
  };

  fileSystems = [
    { mountPoint = "/home/s"; device = "/dev/mapper/enc-home"; fsType = "ext4"; options = ["noatime"]; }
  ] ++ import ../lib/syncthing.nix;
}
