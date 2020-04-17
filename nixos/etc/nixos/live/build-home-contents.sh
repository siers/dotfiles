#!/usr/bin/env zsh

set -eux
setopt extendedglob

excludes=/tmp/.rsync-buildhome-excludes
cat > "$excludes" <<-EOF
.syncthing/shares/home/code/desktop/dotfiles/nixos/etc/nixos/image
.syncthing/shares/home/code/desktop/dotfiles/nixos/etc/nixos/stick

code/cache

.stack-work
venv
node_modules

result
*.sql.gpg
EOF

cd "$SUDO_USER_HOME"

rsync -vaR \
    "--exclude-from=$excludes" \
    .config/{google-chrome,syncthing/config.xml} \
    .weechat/^*logs \
    {.ssh,.gnupg,.histfile} \
    .syncthing/shares/home \
    "$STORE"

with-dirs() {
    mkdir -p "$@"
    chown "${ORIG_USER}:users" "$@"
}

with-dirs "$STORE/"{code,data,log}
