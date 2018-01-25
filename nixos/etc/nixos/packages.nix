{ config, pkgs, ... }:

{
  nixpkgs.config = {
    allowUnfree = true;
    chromium = {
      enablePepperFlash = true;
      enablePepperPDF = true;
      #enableWideVine = true;
    };
  };

  environment.systemPackages = with pkgs; [
    # services and stuff
    docker
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
    gnome3.eog
    gparted
    inkscape
    libreoffice
    mpv
    pavucontrol
    rxvt_unicode
    virtmanager
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
    inotify-tools
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
    ranger
    ruby
    sox
    sshpass
    stow
    units
    weechat
    youtube-dl

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
