{ config, pkgs, ... }:

{
  imports = [
    <home-manager/nixos>
  ];

  home-manager.users.s = { pkgs, ... }: {
    home.packages = with pkgs; [
      asciinema
    ];

    home.file.".zshrc".source = /home/s/code/df/zsh/.zshrc;
    home.file.".config/zsh".source = /home/s/code/df/zsh/.config/zsh;

    home.file.".gitconfig".source = /home/s/code/df/git/.gitconfig;
    home.file.".gitignore".source = /home/s/code/df/git/.gitignore;
    home.file.".gitignorex".source = /home/s/code/df/git/.gitignore;
  };

  home-manager.users.ld = { pkgs, ... }: {
    home.packages = with pkgs; [
      scala
      sbt
    ];
  }
}

# agdaWithPackages-2.6.1
# asciinema-2.0.2
# dex-login-1.0.0
# dtrx-7.1
# expect-5.45.4
# git-filter-repo-2.29.0
# gnuplot-5.2.8
# hub-2.12.7
# kbfs-5.0.0
# kdenlive-20.08.2
# keybase-gui-5.0.0
# lm-sensors-3.6.0
# lsd-0.18.0
# lz4-1.9.2
# meld-3.21.0
# niv-0.2.16
# nix-2.4pre20210503_6d2553a
# openjdk-11.0.9+11
# parallel-20200822
# perl5.32.0-Image-ExifTool-12.00
# pv-1.6.6
# python3-3.8.5-env
# python3.7-mitmproxy-5.3.0
# restic-0.9.6
# signal-desktop-1.39.4
# vscode-1.44.1
# wdiff-1.2.2
# websocat-1.6.0
# ws-0.2.1
# xwininfo-1.1.4
# yourkit-2019.1-b133
