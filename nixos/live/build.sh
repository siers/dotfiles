#! /usr/bin/env bash

set -eu

export device=/dev/sdc
export image=image
XXX="\e[1;33mXXX\e[0m"

calc-sizes() {
    of_seek=$(sudo device=$device live/find-image-offset.rb)

    sed -i "s/^  imageOffset = \".*\";$/  imageOffset = \"$of_seek\";/" live/live.nix
    sed -i "s/^  imageSize = \".*\";$/  imageSize = \"$(du -b image | cut -f1)\";/" live/live.nix
}

# run this in terminal via copypasting
build-home() {
    [ -e /tmp/password ] || (cd /tmp; vim password-nl; echo -n "$(cat password-nl)" > password)
    ALLOC=2.5G KEY_FILE=/tmp/password ./live/build-home.sh

    calc-sizes
}

# run this in terminal via copypasting
burn-home() {
    calc-sizes

    ! [ -f "$device" ] && sudo \
        dd oflag=seek_bytes if=image bs=1M of="$device" seek="$of_seek" status=progress

    [ -e stick ] && \
        dd oflag=seek_bytes if=image bs=1M of=stick seek=5GB conv=notrunc
}

build-iso() {
    # has the patch for removing compression for mksquashfs
    export NIX_PATH=nixpkgs=$HOME/code/cache/nixpkgs

    nix-build '<nixpkgs/nixos>' -A config.system.build.isoImage -I nixos-config=live/live.nix
    [ -e stick ] && dd if="$(find-iso)" of=stick bs=1M conv=notrunc status=progress
}

find-iso() {
    find result/iso/*.iso
}

test-iso() {
    iso="$(find-iso)"

    # du image $iso
    # 2.1G    image
    # 4.0G    result/iso/nixos-19.09.git.e10c65c-x86_64-linux.iso
    # fallocate -l 10G stick

    image="$(find 2>&- stick "$iso" | head -n1)"
    qemu-system-x86_64 -boot d -cdrom "$image" -m 4000
}

burn-iso() {
    iso="$(find-iso)"
    ln -sf "$iso" ~/code/cache/images/"$(date +%F-%H.%M)-nixos.iso"

    ! [ -f "$device" ]
    sudo dd if="$iso" of="$device" bs=4M status=progress
}

reburn-home() {
    build-home
    burn-home
}

reburn-iso() {
    build-iso
    burn-iso
}

reburn() {
    reburn-home # might change image offset/size, so goes first
    reburn-iso
}

cleanup-store-images() {
    sudo unshare -m bash -c 'cd /nix/store; mount -o rw,remount .; bash'
    and run
    find . -maxdepth 1 -type f -printf '%s %p\n'| sort -nr | head -n 10 | awk '{print $2}' | grep squashfs
    rm those above and
    rm *.iso
}

# # usage:
# # subshell because having set -e in live shell kills it instantly
# (. live/build.sh; build-iso && test-iso)
