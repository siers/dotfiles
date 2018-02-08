{ config, pkgs, ... }:

with pkgs; let
  services = [
    docker
    syncthing
  ];

  graphical = [
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
  ];

  x = [
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
  ];

  termtools = [
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
  ];

  termtoolsFancy = [
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
  ];

  haskell = [ cabal2nix cabal-install stack ];

  simple = services ++ termtools ++ termtoolsFancy;
  large = graphical ++ x;
  everything = simple ++ large;
in
  {
    environment.systemPackages = everything;
    nixpkgs.config = {
      allowUnfree = true;
      chromium = {
        #enablePepperFlash = true;
        enablePepperPDF = true;
        #enableWideVine = true;
      };
    };
  }
