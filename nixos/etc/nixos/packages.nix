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

    # standard terminal tools (soft category)
    bc
    coreutils
    cryptsetup
    elfutils
    file
    gitAndTools.gitFull
    gnumake
    htop
    inetutils
    ncdu
    tmux
    unrar
    utillinux
    wget
    which
    zip

    # fancy terminal tools
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
    sox
    sshpass
    stow
    weechat

    # X tools
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
