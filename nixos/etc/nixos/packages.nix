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
    networkmanagerapplet
    pavucontrol
    rxvt_unicode
    virtmanager
    vlc

    # X tools
    autocutsel
    unclutter
    xbindkeys
    xcalib
    xclip
    xdotool
    xlibs.xev
    xorg.xbacklight
    xorg.xkbcomp
    xorg.xkill
    xorg.xmodmap
    xsel
    xss-lock

    # standard terminal tools (soft category)
    bc
    bind # for dig
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
    p7zip
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
    ripgrep
    ruby
    sox
    sshpass
    stow
    units
    weechat
    youtube-dl

    # haskell
    cabal2nix
    cabal-install
    stack
  ];
}
