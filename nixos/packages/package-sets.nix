{ pkgs, ... }:

with pkgs;

let
  siers = import ./packages.nix pkgs;
  neovimConfigured = siers.alias [(pkgs.callPackage ./neovim/default.nix {})] "nvim" "nv";

  sets = {
    aliases = [
      (siers.alias [systemd] "systemctl" "sc")
      (siers.alias [neovim] "nvim" "vim")
    ];

    services = [
      docker
      ntfs3g
      openvpn
      syncthing
    ];

    graphical = [
      alacritty
      google-chrome
      dunst
      evince
      geeqie
      gnome3.eog
      gparted
      maim
      mpv
      networkmanagerapplet
      pavucontrol
      rxvt_unicode
      #virtmanager
      vlc
      spotify
      element-desktop
      python3Packages.idasen # -controller
      anki-bin
      # gsettings-desktop-schemas
    ];

    # an uncategory for all things large
    nonessential = [
      firefox
      gimp
      inkscape
      k3b
      libreoffice
      tigervnc
      imagemagick
      ffmpeg-full
      #texlive.combined.scheme-full
    ];

    x = [
      autocutsel
      dmenu
      go-upower-notify
      rofi
      siers.footswitch
      rofimoji
      unclutter
      xbindkeys
      xcalib
      xclip
      xdotool
      xorg.xev
      xorg.xbacklight
      xorg.xkbcomp
      xorg.xkill
      xorg.xmodmap
      xsel
      xss-lock
    ];

    termtoolsEssential = [
      asciinema
      bc
      bind # for dig
      coreutils
      # dtrx
      file
      pijul
      gcc
      lua
      gnumake
      htop
      inetutils
      ncdu
      neovim
      p7zip
      pass
      pv
      pwgen
      ruby
      socat
      tmux
      unzip
      utillinux
      # vitetris # essential — ha!
      watch
      wget
      which
      zip
      zstd
    ];

    termtoolsFancy = [
      direnv
      fzf
      # geoipWithDatabase
      gnupg
      iftop
      jq
      libnotify
      moreutils
      nmap
      ranger
      ripgrep
      sshpass
      stow
      units
      weechat
      youtube-dl

      neovimConfigured
    ];

    termtoolsOptional = [
      haskellPackages.pandoc
      haskellPackages.ShellCheck
      perkeep
    ];

    termtoolsLinux = [
      alsaUtils
      cryptsetup
      elfutils
      espeak
      inotify-tools
      iotop
      pmutils
      mkpasswd
      pdftk
      sysstat # pidstat
      unrar
      gitAndTools.gitFull
    ];

    dev = [ # also work
      slack
      tdesktop

      cachix
      # gitAndTools.diff-so-fancy
      #man-pages
      nix-prefetch-git
      xxd

      # ((import (fetchTarball "https://github.com/infinisil/all-hies/tarball/master") {}).
      #   selection { selector = p: { inherit (p) ghc864 ghc843; }; })

      nodejs
      yarn

      docker-compose
      kubectl

      kcat
    ];

    audio = [
      audacity
      frescobaldi
      lilypond-unstable
      musescore
      pasystray
      sox
    ];

    darwin = [
      coreutils
      findutils
      # musescore
      syncthing
      siers.xclip-for-mac

      coursier
      just
      lua
      neovim
      nodejs
      ripgrep
      sbt
      stow
      temurin-bin
      tree-sitter
      vscode-langservers-extracted
    ];
  };

  derived = with sets; rec {
    simple-cross = termtoolsEssential ++ termtoolsFancy;
    simple-darwin = simple-cross ++ darwin;
    simple = simple-cross ++ termtoolsLinux ++ aliases;

    most = builtins.concatLists [
      audio
      dev
      graphical
      services
      x
    ];

    large = nonessential;

    live = builtins.concatLists [ simple graphical x ];

    everything = simple ++ most ++ large;
  };
in
  sets // derived
