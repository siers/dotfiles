{ config, pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    # services
    docker
    pulseaudioFull
    syncthing
    syncthing-inotify

    # graphical
    alacritty
    chromium
    dunst
    evince
    filezilla
    firefox
    gimp
    gparted
    inkscape
    libreoffice
    mpv
    pavucontrol
    rxvt_unicode
    vlc

    coreutils
    cryptsetup
    elfutils
    file
    gitAndTools.gitFull
    gnumake
    htop
    inetutils
    ncdu
    python
    tmux
    unrar
    utillinux
    wget
    wget
    which
    zip

    bc
    direnv
    espeak
    ffmpeg
    gnupg
    haskellPackages.pandoc
    haskellPackages.ShellCheck
    jq
    libnotify
    mkpasswd
    (neovim.override { vimAlias = true; })
    nix-repl
    pdftk
    python
    ruby
    sshpass
    stow
    weechat

    autocutsel
    unclutter
    xbindkeys
    xcalib
    xclip
    xlibs.xev
    xorg.xbacklight
    xorg.xkbcomp
    xorg.xkill
    xorg.xmodmap
    xsel
    xss-lock
  ];
}
