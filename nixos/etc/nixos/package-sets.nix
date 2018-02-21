{ pkgs, ... }:

with pkgs;

let
  sets = {
    services = [
      docker
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
      virtmanager
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
      texlive.combined.scheme-full
    ];

    x = [
      actkbd # don't tell anyone, but it's not an X-util
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

    termtoolsEssential = [
      bc
      bind # for dig
      coreutils
      cryptsetup
      elfutils
      file
      file
      gitAndTools.gitFull
      gnumake
      htop
      inetutils
      inotify-tools
      ncdu
      p7zip
      python
      ruby
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
      pdftk
      ranger
      ripgrep
      sshpass
      stow
      units
      weechat
      youtube-dl
    ];

    dev = [
      cabal2nix
      cabal-install
      ghc
      manpages
      nix-prefetch-git
      nix-repl
      stack
    ];

    audio = [
      audacity
      frescobaldi
      lilypond
      musescore
      sox
    ];
  };

  derived = with sets; rec {
    simple = termtoolsEssential ++ termtoolsFancy;
    large = builtins.concatLists [
      audio
      dev
      graphical
      nonessential
      services
      x
    ];

    everything = simple ++ large;
  };

  # It would be better if I had a total order on sets instead preorder.
  derivationsPreorder = a: b:
    let namePresort = builtins.sort (a: b: a.name > b.name);
    in namePresort a == namePresort b;

in
  with derived; with sets;
  assert derivationsPreorder everything (builtins.concatLists (builtins.attrValues sets));

  sets // derived
