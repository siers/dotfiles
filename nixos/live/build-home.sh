#! /usr/bin/env nix-shell
#! nix-shell -i bash -p utillinux -p cryptsetup -p rsync

set -euo pipefail

sudo true

SUDO_USER_HOME="$(getent passwd "${SUDO_USER:-$USER}" | cut -d: -f6)"
image="${image:-image}"

export RECALL="$0"

# Escalate privileges for the rest of the script, with separate mounts
if [ -z "${UNSHARED:-}" ]; then
    exec sudo ALLOC="$ALLOC" ORIG_USER="$USER" KEY_FILE="$KEY_FILE" SUDO_USER_HOME="$SUDO_USER_HOME" \
        unshare -m bash /dev/stdin "$@" <<-EOF
        export STORE="\$(mktemp -d /dev/shm/keys-tmp-XXX)"
        UNSHARED=1 "$RECALL" "\$@"
EOF
fi

# With escalated privileges:

# usage:
# (cd /tmp; vim password-nl; echo -n $(cat password-nl) > password)
# ALLOC=100M KEY_FILE=<(echo -n /tmp/password) ./modules/build-home.sh

echo "ALLOC=$ALLOC, KEY_FILE=$KEY_FILE"

set -x

allocate_image() {
    fallocate -l "$ALLOC" "$image"
    device="$(sudo losetup --find --show -L "$image")"
    sfdisk "$device" <<< ";"
}

format_image() {
    cryptsetup luksFormat "$device" "$KEY_FILE"
    cryptsetup open "$device" initdrive --key-file "$KEY_FILE"
    mkfs.ext4 /dev/mapper/initdrive
    mount /dev/mapper/initdrive "$STORE"
}

unmount_image() {
    umount "$STORE"
    cryptsetup close initdrive
    losetup -d "$device"
}

allocate_image
format_image
./live/build-home-contents.sh || :
unmount_image
