{ pkgs, ... }:

with pkgs;
with (import ./packages.nix pkgs);

let
  sets = {
    aliases = [
      (alias [systemd] "systemctl" "sc")
    ];

    services = [
      docker
      ntfs3g
      openvpn
      syncthing
    ];

    graphical = [
      alacritty
      chromium
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
    ];

    # an uncategory for all things large
    nonessential = [
      filezilla
      firefox
      gimp
      google-chrome # has netflix, so let's have both chromes
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
      intel-brightness-script
      rofi
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

    termtoolsEssential = [
      asciinema
      bc
      bind # for dig
      coreutils
      file
      gitAndTools.gitFull
      gnumake
      htop
      inetutils
      ncdu
      p7zip
      python
      ruby
      socat
      tmux
      unzip
      utillinux
      vitetris # essential — ha!
      wget
      which
      zip
    ];

    termtoolsFancy = [
      direnv
      ffmpeg
      fzf
      # geoipWithDatabase
      gnupg
      haskellPackages.pandoc
      haskellPackages.ShellCheck
      iftop
      jq
      libnotify
      massren
      (neovim.override { vimAlias = true; withPython = true; })
      nmap
      perkeep
      ranger
      ripgrep
      sshpass
      stow
      units
      weechat
      youtube-dl
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

    dev = [
      cabal2nix
      cabal-install
      docker_compose
      ghc
      manpages
      nix-prefetch-git
      stack
      xxd
    ];

    audio = [
      audacity
      frescobaldi
      lilypond-unstable
      musescore
      sox
    ];

    darwin = [
      coreutils
      docker_compose
      findutils
      musescore
      syncthing
      xclip-for-mac
    ];
  };

  derived = with sets; rec {
    simple-darwin = termtoolsEssential ++ termtoolsFancy ++ darwin;
    simple = simple-darwin ++ termtoolsLinux;

    most = builtins.concatLists [
      audio
      dev
      graphical
      services
      x
    ];

    large = nonessential ++ aliases;

    live = builtins.concatLists [ simple most ];

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
