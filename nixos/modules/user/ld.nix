{ config, pkgs, ... }:

{
  users.extraUsers.ld = {
    isNormalUser = true;
    uid = 1001;
    shell = pkgs.zsh;
    hashedPassword = config.secrets.passwordLd;
    # openssh.authorizedKeys.keys = ["ssh-ed25519 "];
    extraGroups = [ "networkmanager" "cdrom" "audio" "camera" "video" "input" ];
  };

  home-manager.users.ld = { pkgs, ... }: {
    home.stateVersion = "22.05";

    nixpkgs.config.allowUnfree = true;

    home.packages = with pkgs; [
      scala
      sbt
      jetbrains.idea-community
      vscode
      openjdk
    ];

    programs.zsh = {
      enable = true;
      autocd = true;
      dotDir = ".config/zsh";
      enableAutosuggestions = true;
      enableCompletion = true;
      shellAliases = {
        l = "ls";
      };

      initExtra = ''
        bindkey '^ ' autosuggest-accept
      '';

      plugins = with pkgs; [
        {
          name = "zsh-syntax-highlighting";
          src = fetchFromGitHub {
            owner = "zsh-users";
            repo = "zsh-syntax-highlighting";
            rev = "0.6.0";
            sha256 = "0zmq66dzasmr5pwribyh4kbkk23jxbpdw4rjxx0i7dx8jjp2lzl4";
          };
          file = "zsh-syntax-highlighting.zsh";
        }
      ];
    };

    programs.fzf = {
      enable = true;
      enableZshIntegration = true;
    };
  };
}
