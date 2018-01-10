#! /usr/bin/env nix-shell
#! nix-shell -i bash -p utillinux -p cryptsetup -p rsync

set -euo pipefail

sudo true

SUDO_USER_HOME="$(getent passwd "${SUDO_USER:-$USER}" | cut -d: -f6)"

export RECALL="$0"

# Escalate privileges for the rest of the script
if [ -z "${UNSHARED:-}" ]; then
    exec sudo ALLOC=$ALLOC KEY_FILE=$KEY_FILE unshare -m bash /dev/stdin "$@" <<-EOF
        export STORE="\$(mktemp -d /dev/shm/keys-tmp-XXX)"
        mount -t ramfs ramfs "\$STORE"
        UNSHARED=1 "$RECALL" "\$@"
EOF
fi

echo "ALLOC=$ALLOC, KEY_FILE=$KEY_FILE"

set -x

fallocate -l "$ALLOC" image
device="$(sudo losetup --find --show -L image)"
sfdisk "$device" <<< ";"

cryptsetup luksFormat "$device" "$KEY_FILE"
cryptsetup open "$device" initdrive --key-file "$KEY_FILE"
mkfs.ext4 /dev/mapper/initdrive
mount /dev/mapper/initdrive "$STORE"

(
    cd "$SUDO_USER_HOME"
    rsync -aRP "$@" "$STORE"
)

umount "$STORE"
cryptsetup close initdrive
losetup -d "$device"
