{ pkgs, ... }:

with pkgs;

let
  nur = fetchTarball {
    # see revisions: https://github.com/nix-community/NUR/commits/master
    url = "https://github.com/nix-community/NUR/archive/9f4866850306098224356342ec0a798518aa9461.tar.gz";
    sha256 = "04387gzgl8y555b3lkz9aiw9xsldfg4zmzp930m62qw8zbrvrshd";
  };

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
      (neovim.override { vimAlias = true; })
      nmap
      ranger
      ripgrep
      sshpass
      stow
      units
      weechat
      youtube-dl
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
      #tdesktop

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
