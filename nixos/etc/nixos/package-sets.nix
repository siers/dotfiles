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
      filezilla
      firefox
      geeqie
      gnome3.eog
      #google-chrome
      gparted
      mpv
      networkmanagerapplet
      pavucontrol
      rxvt_unicode
      virtmanager
      vlc
    ];

    graphicalNonessential = [
      gimp
      inkscape
      k3b
      libreoffice
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
      sox
      sshpass
      stow
      units
      weechat
      youtube-dl
      rubyripper
    ];

    dev = [
      cabal2nix
      cabal-install
      ghc
      nix-repl
      stack
    ];
  };

  derived = with sets; rec {
    simple = termtoolsEssential ++ termtoolsFancy;
    large = services ++ graphical ++ graphicalNonessential ++ x ++ dev;
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
