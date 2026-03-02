{ conf, pkgs, ... }:

let
  linux = pkgs.stdenv.isLinux;
  mac = !pkgs.stdenv.isLinux;
  packages =
    if linux
    then ../packages/package-sets.nix
    else ~/dotfiles/nixos/packages/package-sets.nix;
  packageSets = import packages { inherit pkgs; };
in {
  home.stateVersion = "25.05";

  home.packages = if linux then [] else ((packageSets.simple-darwin)); # ++ (with pkgs; [ neovim-unwrapped ]));

  home.file.".zshrc".source = "${conf}/zsh/.zshrc";
  home.file.".config/zsh".source = "${conf}/zsh/.config/zsh";
  home.file.".tmux.conf".source = "${conf}/tmux/.tmux.conf";
  home.file.".gitignore".source = "${conf}/git/.gitignore";

  home.file.".config/i3/config".source = "${conf}/x/.config/i3/config";
  home.file.".config/dunst".source = "${conf}/x/.config/dunst";
  home.file.".config/mpv".source = "${conf}/x/.config/mpv";
  home.file.".Xresources".source = "${conf}/x/.Xresources";
  home.file.".xprofile".source = "${conf}/x/.xprofile";
  home.file.".config/alacritty.toml".source = "${conf}/x/.config/alacritty.toml";
  home.file.".xbindkeysrc.scm".source = "${conf}/x/.xbindkeysrc.scm";
  # home.file.".config/xfce4".source = "${conf}/x/.config/mpv";

  # home.file.".config/nix/nix.conf".source = "${conf}/nix/.config/nix/nix.conf";

  home.file.".sbt/1.0/build.sbt".source = "${conf}/scala/.sbt/1.0/build.sbt";
  home.file.".sbt/1.0/plugins/plugins.sbt".source = "${conf}/scala/.sbt/1.0/plugins/plugins.sbt";

  home.file.".ghci".source = "${conf}/ghci";

  programs.direnv.enable = true;
  programs.direnv.nix-direnv.enable = true;

  programs.nix-index.enable = true;

  programs.git.enable = true;
  programs.git.includes = [ { path = "${conf}/git/.gitconfig"; } ];
  # programs.git.difftastic.enable = true;
  programs.git.lfs.enable = true;

  services.gpg-agent.enable = linux;

  # https://github.com/NixOS/nixpkgs/issues/196651#issuecomment-1283814322
  manual.manpages.enable = linux;
  # fonts.fontconfig.enable = mac;
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.allowUnsupportedSystem = true;
}
