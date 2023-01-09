{ pkgs, neovim-flake, ... }:

with pkgs;

let
  siers = import ./packages.nix pkgs;
  neovimConfigured = siers.alias [(pkgs.callPackage ./neovim/default.nix {})] "nvim" "nv";

  sets = {
    aliases = [
      (siers.alias [systemd] "systemctl" "sc")
      (siers.sym-alias "nvim" "vim")
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
      pinentry_gnome
      spotify
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
      siers.rofimoji
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
      dtrx
      file
      gitAndTools.gitFull
      gnumake
      htop
      inetutils
      ncdu
      p7zip
      pass
      pv
      pwgen
      ruby
      socat
      tmux
      unzip
      utillinux
      vitetris # essential — ha!
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
      massren
      nmap
      ranger
      ripgrep
      sshpass
      stow
      units
      weechat
      youtube-dl

      neovimConfigured
      # (neovim-flake.outputs.neovim)
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
    ];

    dev = [ # also work
      slack
      tdesktop

      cachix
      gitAndTools.diff-so-fancy
      #man-pages
      nix-prefetch-git
      xxd

      # ((import (fetchTarball "https://github.com/infinisil/all-hies/tarball/master") {}).
      #   selection { selector = p: { inherit (p) ghc864 ghc843; }; })

      nodejs
      yarn

      docker-compose
      kubectl
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
      docker_compose
      findutils
      musescore
      syncthing
      siers.xclip-for-mac
    ];
  };

  derived = with sets; rec {
    simple-cross = termtoolsEssential ++ termtoolsFancy ++ aliases;
    simple-darwin = simple-cross ++ darwin;
    simple = simple-cross ++ termtoolsLinux;

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

  # It would be better if I had a total order on sets instead preorder.
  derivationsPreorder = a: b:
    let namePresort = builtins.sort (a: b: a.name > b.name);
    in namePresort a == namePresort b;

in
  with derived; with sets;
  #assert derivationsPreorder everything (builtins.concatLists (builtins.attrValues sets));

  sets // derived