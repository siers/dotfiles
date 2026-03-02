{ pkgs, ... }:

with pkgs;

let
  siers = import ./packages.nix pkgs;
  sets = {
    aliases = [
      (siers.alias [systemd] "systemctl" "sc")
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
      coreutils-full
      # dtrx
      file
      pijul
      gcc
      lua
      gnumake
      htop
      inetutils
      ncdu
      neovim-unwrapped
      lilypond-unstable
      p7zip
      pass
      pv
      pwgen
      ruby
      socat
      tmux
      unzip
      util-linux
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
      # youtube-dl
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
      # tdesktop

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

      imagemagick
      ffmpeg-full
      libiconv
      mediainfo
      sox
    ];

    audio = [
      audacity
      frescobaldi
      musescore
      pasystray
      sox
    ];

    darwin = [
      findutils
      # musescore
      syncthing
      siers.xclip-for-mac

      coursier
      just
      lua
      nodejs
      ripgrep
      sbt
      bloop
      stow
      temurin-bin
      tree-sitter
      vscode-langservers-extracted
    ];
  };

  derived = with sets; rec {
    simple-cross = termtoolsEssential ++ termtoolsFancy;
    simple-darwin = simple-cross ++ darwin ++ dev;
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
