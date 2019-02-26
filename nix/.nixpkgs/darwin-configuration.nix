{ config, pkgs, ... }:

let
  psets = import ~/Share/code/desktop/dotfiles/nixos/etc/nixos/lib/package-sets.nix { inherit pkgs; };
in

{
  environment.systemPackages = with pkgs; psets.simple-darwin;

  # services.nix-daemon.enable = true;

  # Create /etc/bashrc that loads the nix-darwin environment.
  programs.zsh.enable = true;

  # Used for backwards compatibility, please read the changelog before changing. $ darwin-rebuild changelog
  system.stateVersion = 3;

  # You should generally set this to the total number of logical cores in your system. $ sysctl -n hw.ncpu
  nix.maxJobs = 4;
  nix.buildCores = 4;
}
