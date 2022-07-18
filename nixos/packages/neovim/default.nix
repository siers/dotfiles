{
  wrapNeovimUnstable,
  neovim-unwrapped,
  neovimUtils,
  vimPlugins,
  vimUtils,
  formats,
  writeTextDir,
  fetchFromGitHub,
  lib,
  symlinkJoin,
}:
wrapNeovimUnstable neovim-unwrapped (neovimUtils.makeNeovimConfig {
  extraLuaPackages = luaPackages:
    with luaPackages; [
      luautf8
    ];
  withNodeJs = true;
  withPython3 = true;
  extraPython3Packages = pythonPackages:
    with pythonPackages; [
      # keep
    ];
  customRC = ''
    source ${./init.vim}
  '';
  vimAlias = true;

  # https://nixos.org/manual/nixpkgs/stable/#managing-plugins-with-vim-packages

  configure.packages."myPackageEntrypoint".start = with vimPlugins; let
    jellyx = vimUtils.buildVimPlugin {
      pname = "jellyx.vim";
      version = "2022-06-16";
      src = fetchFromGitHub {
        owner = "guns";
        repo = "jellyx.vim";
        rev = "62f41762adadc28059f524ce0e7aed6092c544b5";
        sha256 = "0mc618is4ahs9ypcvgpxy7vn83m43fljkim9vv9xbg319zlv76qw";
      };
    };
    vim-esearch = vimUtils.buildVimPlugin {
      pname = "vim-esearch";
      version = "2022-06-16";
      configurePhase = "rm Makefile";
      src = fetchFromGitHub {
        owner = "eugen0329";
        repo = "vim-esearch";
        rev = "d00e5b1f29288e0d884eb523558fea891a252631";
        sha256 = "0mc478k4i0ajg4j48318nw14gac560cphk1k00qv99lqqlsxbclp";
      };
    };
    nvim-agda = vimUtils.buildVimPlugin {
      pname = "nvim-agda";
      version = "2022-06-16";
      src = fetchFromGitHub {
        owner = "ashinkarov";
        repo = "nvim-agda";
        rev = "4b347ab08157614e5acb2a9d5103115521ffa447";
        sha256 = "0s9xgka2747apskkk8ac9bhbg2w5hb52dv5glk3fsn588lb15lw9";
      };
    };
    # coc-nvim = vimUtils.buildVimPluginFrom2Nix {
    #   pname = "coc.nvim";
    #   version = "2022-06-17";
    #   src = fetchFromGitHub {
    #     owner = "neoclide";
    #     repo = "coc.nvim";
    #     rev = "6cfc134dd25a44f737ef8a70696a74664da1a96f";
    #     sha256 = "136yiq2w3v687azc7ya4lfswdl16w64swjbk6nk5zjlm8y22iwxs";
    #   };
    #   meta.homepage = "https://github.com/neoclide/coc.nvim/";
    # };
    nvim-treesitter' = nvim-treesitter.withPlugins (p:
      with p; [
        tree-sitter-bash
        tree-sitter-dockerfile
        tree-sitter-json
        tree-sitter-json5
        # tree-sitter-nix
        tree-sitter-python
        tree-sitter-toml
      ]);
  in [
    # Necessary plugins
    jellyx
    ctrlp-vim
    vim-airline
    indentLine
    gundo-vim
    vim-obsession
    vim-signify
    vim-commentary
    vim-repeat
    vim-abolish
    vim-sneak
    # vim-syntastic/syntastic
    vim-surround
    vim-signature
    vim-esearch
    markdown-preview-nvim
    vim-fugitive
    fugitive-gitlab-vim
    vim-rhubarb
    vim-fubitive

    # Language plugins
    vim-nix
    vim-scala
    vim-gnupg
    vim-terraform
    # agda-vim
    nvim-agda

    # Random
    editorconfig-vim
    nvim-treesitter'
    vim-fetch
    nerdtree

    # Language server
    # coc-nvim
    # coc-json
    # coc-tsserver
    nvim-metals
    plenary-nvim
    # vimspector
    # coc-snippets
  ];
})
