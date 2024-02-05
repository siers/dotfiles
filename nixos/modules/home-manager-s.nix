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
  home.stateVersion = "23.05";

  home.packages = if linux then [] else ((packageSets.simple-darwin) ++ (with pkgs; [
  ]));

  # sessionVariables.EDITOR = "nvim";

  home.file.".zshrc".source = "${conf}/zsh/.zshrc";
  home.file.".config/zsh".source = "${conf}/zsh/.config/zsh";

  home.file.".gitignore".source = "${conf}/git/.gitignore";

  home.file.".tmux.conf".source = "${conf}/tmux/.tmux.conf";
  home.file.".ghci".source = "${conf}/ghci";

  home.file.".config/i3/config".source = "${conf}/x/.config/i3/config";
  home.file.".config/dunst".source = "${conf}/x/.config/dunst";
  home.file.".config/mpv".source = "${conf}/x/.config/mpv";
  # home.file.".config/xfce4".source = "${conf}/x/.config/mpv";
  home.file.".Xresources".source = "${conf}/x/.Xresources";
  home.file.".xprofile".source = "${conf}/x/.xprofile";
  home.file.".config/alacritty.toml".source = "${conf}/x/.config/alacritty.toml";
  home.file.".xbindkeysrc.scm".source = "${conf}/x/.xbindkeysrc.scm";
  home.file.".sbt/1.0/build.sbt".source = "${conf}/scala/.sbt/1.0/build.sbt";
  home.file.".sbt/1.0/plugins/plugins.sbt".source = "${conf}/scala/.sbt/1.0/plugins/plugins.sbt";

  programs.direnv.enable = true;
  programs.direnv.nix-direnv.enable = true;

  programs.nix-index.enable = true;

  programs.git.enable = true;
  programs.git.includes = [ { path = "${conf}/git/.gitconfig"; } ];
  # programs.git.difftastic.enable = true;
  programs.git.lfs.enable = true;

  services.gpg-agent.enable = linux;

  # programs.neovim = {
  #   enable = true;
  #   vimAlias = true;
  #   vimdiffAlias = true;
  #   withNodeJs = true;

  #   packages = with pkgs.vimP lugins; [
  #     yankring
  #     vim-nix
  #     { plugin = vim-startify; config = "let g:startify_change_to_vcs_root = 0"; }

  #     # palenight.vim
  #     jellyx.vim
  #     ctrlp.vim
  #     vim-airline
  #     indentLine
  #     gundo.vim # Gi
  #     vim-obsession # Session files
  #     vim-signify # Git diff signs.
  #     neomake
  #     vim-commentary
  #     vim-repeat
  #     vim-abolish # Subvert, crs.
  #     vim-sneak # f/t for double chars
  #     syntastic
  #     vim-snippets
  #     vim-surround
  #     vim-signature # Marks of all kind.
  #     vim-esearch
  #     markdown-preview.nvim, {'do': 'cd app && yarn install --frozen-lockfile --force'}
  #     fzf, { 'do': { -> fzf#install() } }
  #     fzf.vim

  #     vim-fugitive # Git.
  #     fugitive-gitlab.vim
  #     vim-rhubarb
  #     vim-fubitive

  #     coc.nvim, {'branch': 'release'}
  #     coc-json {'do': 'yarn install --frozen-lockfile --force'}
  #     coc-tsserver {'do': 'yarn install --frozen-lockfile --force'}
  #     coc-metals {'do': 'yarn install --frozen-lockfile --force'}
  #     vimspector
  #     coc-snippets {'do': 'yarn install --frozen-lockfile --force'}
  #     # coc-actions {'do': 'yarn install --frozen-lockfile --force'}

  #     vim-nix
  #     vim-es6
  #     vim-scala
  #     vim-gnupg
  #     vim-terraform
  #     vim-lilypond-integrator
  #     vim-vue
  #     scss-syntax.vim
  #     Dockerfile.vim
  #     agda-vim

  #     # The nerdtree
  #     # vim-fetch
  #     # yats.vim', {'for': ['typescript', 'typescript.jsx']}
  #     # cpsm
  #     # emmet-vim' " div#foo<C-y>, => <div id=foo>
  #     # supertab
  #     # splitjoin.vim
  #     # sideways.vim' " argument swapping
  #     # vim-easy-align
  #     # vim-minimap
  #     # coc-calc' " doesn't seem to work
  # ]
  # };

  # https://github.com/NixOS/nixpkgs/issues/196651#issuecomment-1283814322
  manual.manpages.enable = linux;
  # fonts.fontconfig.enable = mac;
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.allowUnsupportedSystem = true;
}
