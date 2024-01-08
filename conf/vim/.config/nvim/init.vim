if empty(glob('~/.config/nvim/autoload/plug.vim'))
    silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://github.com/junegunn/vim-plug/raw/master/plug.vim

    function! AuPlugged()
        exe ':PlugInstall'
        echom 'Installing plugins... **Restart Vim to load them!**'
    endfunction
    augroup AuPlugged
        autocmd!
        autocmd VimEnter * call AuPlugged()
    augroup END
endif

" Settings {{{
filetype plugin indent on
syntax on

set dir=/var/tmp nobackup
set encoding=utf-8
set ffs=unix,dos,mac
set history=10000
set undofile hidden

set list listchars=tab:»·,tab:→\ ,trail:·,nbsp:·
set expandtab shiftround smarttab autoindent
set laststatus=2 tabstop=2 shiftwidth=2 showtabline=2 softtabstop=2
set bs=indent,eol,start
set cursorline number
set nofoldenable foldmethod=indent
set breakindent showbreak=\|- showbreak=\\_

set ignorecase smartcase incsearch hlsearch
set wildmenu wildmode=longest,full
set completeopt=menu,menuone,preview
set shortmess+=cfilmnxrI
set splitbelow splitright

set showcmd
set clipboard=unnamedplus
set mouse=a
"set statusline=%f%m%r%h%w\ [%n:%{&ff}/%Y]%=[0x\%04.4B][%03v][%p%%\ line\ %l]

let g:mapleader = "\<Space>"
let g:vimspector_enable_mappings = 'HUMAN'
" }}}

" Plugins {{{
call plug#begin('~/cache/vim-plug')

" Plug 'https://github.com/drewtempelmeyer/palenight.vim'
Plug 'https://github.com/guns/jellyx.vim'
Plug 'https://github.com/ctrlpvim/ctrlp.vim'
Plug 'https://github.com/vim-airline/vim-airline'
Plug 'https://github.com/Yggdroot/indentLine'
Plug 'https://github.com/sjl/gundo.vim' " Gi
Plug 'https://github.com/tpope/vim-obsession' " Session files
Plug 'https://github.com/mhinz/vim-signify' " Git diff signs.
Plug 'https://github.com/benekastah/neomake'
Plug 'https://github.com/tpope/vim-commentary'
Plug 'https://github.com/tpope/vim-repeat'
Plug 'https://github.com/tpope/vim-abolish' " Subvert, crs.
Plug 'https://github.com/justinmk/vim-sneak' " f/t for double chars
Plug 'https://github.com/honza/vim-snippets'
Plug 'https://github.com/tpope/vim-surround'
Plug 'https://github.com/kshenoy/vim-signature' " Marks of all kind.
Plug 'https://github.com/eugen0329/vim-esearch'
Plug 'https://github.com/iamcco/markdown-preview.nvim', {'do': 'cd app && yarn install --frozen-lockfile --force'}

Plug 'https://github.com/tpope/vim-fugitive' " Git.
Plug 'https://github.com/shumphrey/fugitive-gitlab.vim'
Plug 'https://github.com/tpope/vim-rhubarb'
Plug 'https://github.com/tommcdo/vim-fubitive'

Plug 'https://github.com/neovim/nvim-lspconfig'
Plug 'https://github.com/hrsh7th/nvim-cmp'
Plug 'https://github.com/hrsh7th/cmp-nvim-lsp'
Plug 'https://github.com/hrsh7th/cmp-buffer'
Plug 'https://github.com/hrsh7th/cmp-path'
Plug 'https://github.com/hrsh7th/cmp-cmdline'
Plug 'https://github.com/scalameta/nvim-metals' ", {'commit': 'cc60a74b7bab2d545cf8f33980d3d84dea8a264d'}
Plug 'https://github.com/nvim-lua/plenary.nvim'
Plug 'https://github.com/wbthomason/packer.nvim'
" Plug 'https://github.com/L3MON4D3/LuaSnip', {'tag': 'v1*', 'do': 'make install_jsregexp'} " Replace <CurrentMajor> by the latest released major (first number of latest release)
Plug 'https://github.com/hrsh7th/vim-vsnip'

" Plug 'https://github.com/neoclide/coc.nvim', {'branch': 'release'}
" Plug 'https://github.com/neoclide/coc-json', {'do': 'yarn install --frozen-lockfile --force'}
" Plug 'https://github.com/neoclide/coc-tsserver', {'do': 'yarn install --frozen-lockfile --force'}
" " Plug 'https://github.com/scalameta/coc-metals', {'do': 'yarn install --frozen-lockfile --force'}
" Plug 'https://github.com/puremourning/vimspector'
" Plug 'https://github.com/neoclide/coc-snippets', {'do': 'yarn install --frozen-lockfile --force'}
" " Plug 'https://github.com/iamcco/coc-actions', {'do': 'yarn install --frozen-lockfile --force'}

Plug 'https://github.com/jamessan/vim-gnupg'
Plug 'https://github.com/hashivim/vim-terraform'
Plug 'https://github.com/derekelkins/agda-vim'
" Plug 'https://github.com/ashinkarov/nvim-agda'
Plug 'https://github.com/nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

" The Plugs below don't mean much to me.
Plug 'https://github.com/preservim/nerdtree'
Plug 'https://github.com/wsdjeg/vim-fetch'
" Plug 'https://github.com/HerringtonDarkholme/yats.vim', {'for': ['typescript', 'typescript.jsx']}
" Plug 'https://github.com/nixprime/cpsm'
Plug 'https://github.com/junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'https://github.com/junegunn/fzf.vim'
" Plug 'https://github.com/ervandew/supertab'
" Plug 'https://github.com/AndrewRadev/splitjoin.vim'
" Plug 'https://github.com/AndrewRadev/sideways.vim' " argument swapping
" Plug 'https://github.com/junegunn/vim-easy-align'
" Plug 'https://github.com/severin-lemaignan/vim-minimap'
" Plug 'https://github.com/liuchengxu/vista.vim'
" Plug 'https://github.com/hrsh7th/vim-vsnip-integ'
Plug 'https://github.com/mrcjkb/haskell-tools.nvim'
Plug 'https://github.com/simrat39/rust-tools.nvim'
" Plug 'https://github.com/pmizio/typescript-tools.nvim'

call plug#end()
"}}}

lua <<EOF
  local api = vim.api
  local cmd = vim.cmd

  local function map(mode, lhs, rhs, opts)
    local options = { noremap = true }
    if opts then
      options = vim.tbl_extend("force", options, opts)
    end
    api.nvim_set_keymap(mode, lhs, rhs, options)
  end

  ----------------------------------
  -- OPTIONS -----------------------
  ----------------------------------
  -- global
  vim.opt_global.completeopt = { "menuone", "noinsert", "noselect" }

  -- LSP mappings
  map("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>")
  map("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>")
  map("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>")
  map("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>")
  -- map("n", "gds", "<cmd>lua vim.lsp.buf.document_symbol()<CR>")
  map("n", "gws", "<cmd>lua vim.lsp.buf.workspace_symbol()<CR>")
  map("n", "<leader>cl", [[<cmd>lua vim.lsp.codelens.run()<CR>]])
  map("n", "<leader>sh", [[<cmd>lua vim.lsp.buf.signature_help()<CR>]])
  map("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>")
  map("n", "<leader>F", "<cmd>lua vim.lsp.buf.format()<CR>")
  map("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>")
  map("n", "<leader>ws", '<cmd>lua require"metals".hover_worksheet()<CR>')
  map("n", "<leader>aa", [[<cmd>lua vim.diagnostic.setqflist()<CR>]]) -- all workspace diagnostics
  map("n", "<leader>ae", [[<cmd>lua vim.diagnostic.setqflist({severity = "E"})<CR>]]) -- all workspace errors
  map("n", "<leader>aw", [[<cmd>lua vim.diagnostic.setqflist({severity = "W"})<CR>]]) -- all workspace warnings
  map("n", "<leader>d", "<cmd>lua vim.diagnostic.setloclist()<CR>") -- buffer diagnostics only
  map("n", "<leader>i", "<cmd>MetalsOrganizeImports<CR>")
  map("n", "[g", "<cmd>lua vim.diagnostic.goto_prev { wrap = false }<CR>")
  map("n", "]g", "<cmd>lua vim.diagnostic.goto_next { wrap = false }<CR>")

  local has_words_before = function()
    unpack = unpack or table.unpack
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
  end

  local feedkey = function(key, mode)
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
  end

  -- completion related settings
  -- This is similiar to what I use
  local cmp = require("cmp")
  cmp.setup({
    sources = {
      { name = "nvim_lsp" },
      { name = "vsnip" },
    },
    snippet = {
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body)
      end,
    },
    mapping = {
      ["<CR>"] = cmp.mapping.confirm({ select = true }),
      ["<Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
        elseif vim.fn["vsnip#available"](1) == 1 then
          feedkey("<Plug>(vsnip-expand-or-jump)", "")
        elseif has_words_before() then
          cmp.complete()
        else
          fallback() -- The fallback function sends a already mapped key. In this case, it's probably `<Tab>`.
        end
      end, { "i", "s" }),
      ["<S-Tab>"] = cmp.mapping(function()
        if cmp.visible() then
          cmp.select_prev_item()
        elseif vim.fn["vsnip#jumpable"](-1) == 1 then
          feedkey("<Plug>(vsnip-jump-prev)", "")
        end
      end, { "i", "s" }),
    }
  })

  ----------------------------------
  -- LSP Setup ---------------------
  ----------------------------------
  local metals_config = require("metals").bare_config()

  -- Example of settings
  metals_config.settings = {
    showImplicitArguments = true,
    showImplicitConversionsAndClasses = true,
    excludedPackages = { "akka.actor.typed.javadsl", "com.github.swagger.akka.javadsl" },
  }

  -- *READ THIS*
  -- I *highly* recommend setting statusBarProvider to true, however if you do,
  -- you *have* to have a setting to display this in your statusline or else
  -- you'll not see any messages from metals. There is more info in the help
  -- docs about this
  metals_config.init_options.statusBarProvider = "on"

  -- Example if you are using cmp how to make sure the correct capabilities for snippets are set
  metals_config.capabilities = require("cmp_nvim_lsp").default_capabilities()

  -- Autocmd that will actually be in charging of starting the whole thing
  local nvim_metals_group = api.nvim_create_augroup("nvim-metals", { clear = true })
  api.nvim_create_autocmd("FileType", {
    pattern = { "scala", "sbt" },
    callback = function()
      require("metals").initialize_or_attach(metals_config)
    end,
    group = nvim_metals_group,
  })

  local nvim_haskell_group = api.nvim_create_augroup("nvim-haskell", { clear = true })
  api.nvim_create_autocmd("FileType", {
    pattern = { "haskell" },
    callback = function()
      local ht = require('haskell-tools')
      vim.g.haskell_tools = {
        hls = {
          settings = {
            haskell = {
              formattingProvider = "fourmolu",
              plugin = {
                class = { -- missing class methods
                  codeLensOn = true,
                },
                importLens = { -- make import lists fully explicit
                  codeLensOn = true,
                },
                refineImports = { -- refine imports
                  codeLensOn = true,
                },
                tactics = { -- wingman
                  codeLensOn = false,
                },
                ['ghcide-type-lenses'] = { -- show/add missing type signatures
                  globalOn = false,
                },
              },
            },
          },
        },
      }
    end,
    group = nvim_haskell_group,
  })

  local lspconfig = require('lspconfig')
  lspconfig.glslls.setup{}
  lspconfig.tsserver.setup {}
  -- lspconfig.rust_analyzer.setup {
  --   -- Server-specific settings. See `:help lspconfig-setup`
  --   settings = {
  --     ['rust-analyzer'] = {},
  --   },
  -- }

  local rt = require("rust-tools")

  rt.setup({
    server = {
      on_attach = function(_, bufnr)
        -- Hover actions
        vim.keymap.set("n", "<C-space>", rt.hover_actions.hover_actions, { buffer = bufnr })
        -- Code action groups
        vim.keymap.set("n", "<Leader>a", rt.code_action_group.code_action_group, { buffer = bufnr })
      end,
    },
  })

  require'nvim-treesitter.configs'.setup {
    -- A list of parser names, or "all" (the five listed parsers should always be installed)
    ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "scala", "glsl" },

    -- Install parsers synchronously (only applied to `ensure_installed`)
    sync_install = false,

    -- Automatically install missing parsers when entering buffer
    -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
    auto_install = true,

    -- List of parsers to ignore installing (or "all")
    ignore_install = { "javascript" },

    ---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
    -- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!

    highlight = {
      enable = true,
    },
  }
EOF

" require("typescript-tools").setup{}

" Plugin settings {{{
silent! colorscheme jellyx
" silent! colorscheme palenight

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_mode_map = { "mode": "active",
                          \ "active_filetypes": [],
                          \ "passive_filetypes": ["scala"] }

let g:ctrlp_user_command = ['.git/', 'ls .git/CTRLP-ALL 2> /dev/null && find -type f || (git --git-dir=%s/.git ls-files -oc --exclude-standard 2> /dev/null | uniq)']
let g:ctrlp_map = ''

"xmap ga <Plug>(EasyAlign) | nmap ga <Plug>(EasyAlign)

" Just like standard f/F except it works on multiple lines.
nmap f <Plug>Sneak_f
nmap F <Plug>Sneak_F
vmap f <Plug>Sneak_f
vmap F <Plug>Sneak_F

" Keeps s/S original functionality.
" https://github.com/justinmk/vim-sneak/issues/87
nmap <Plug>(Go_away_Sneak_s) <Plug>Sneak_s
nmap <Plug>(Go_away_Sneak_S) <Plug>Sneak_S

nnoremap <Backspace> :Vista!!<CR>

" let g:vista_default_executive = 'coc'
let g:vista_close_on_jump = 1
let g:vista_sidebar_width = 60

function! CtrlP()
  if (getcwd() == $HOME)
    echo "Won't run in ~"
    return
  endif
  if (getcwd() == '/')
    echo "Won't run in /"
    return
  endif
  CtrlP
endfunction

nnoremap <C-p> :call CtrlP()<CR>

Plug 'https://gist.github.com/drasill/ff9b94025dc8aa7e404f',
    \ { 'dir': g:plug_home.'/vim-fzf-git-ls-files/plugin', 'rtp': '..' }

" }}}

" Autocmds {{{
augroup vimrc
    autocmd!
augroup END
augroup format
    autocmd!
augroup END

" When reading a file, jump to the last cursor position.
autocmd vimrc FileType go setlocal noet
autocmd vimrc FileType vim nnoremap <buffer> <F9> :source %<CR>
autocmd vimrc FileType vim setlocal foldmethod=marker
autocmd vimrc FileType ruby,terraform,yaml,javascript,nix,scss,vim,vue,css,erb,haskell,scala setlocal sw=2 ts=2
autocmd vimrc FileType erb setlocal sw=2 ts=2

autocmd vimrc BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
autocmd vimrc BufWritePre * %s/\s\+$//e
autocmd format BufWritePre * lua vim.lsp.buf.format()

function! AuFocusLost()
    " Save when losing focus.
    exe ':silent! update'

    " Go back to normal mode from insert mode.
    if mode() == 'i'
      exe ':stopinsert'
    endif

    if getbufvar(bufnr('%'), '&filetype') == 'fzf'
      exe ':q'
    endif
endfunction
autocmd vimrc FocusLost * call AuFocusLost()
" }}}

" Commands {{{
command! Config :tabedit ~/.config/nvim/init.vim
command! NF :-tabedit notes
command! NN :-tabedit notes/notes
command! Wtmp :w! `mktemp`
command! -range=% Sum :<line1>,<line2>!paste -sd+ | bc
command! CL :tabedit %
command! RMNL :%g/^$/d

command! Session :Obsession .session.vim
command! PU :PlugUpdate
command! PI :PlugInstall
command! PC :PlugClean

" :Share to sprunge.us
exec 'command! -range=% Share :<line1>,<line2>write !pasty'
" }}}

" Creative maps {{{
map E <Home>y$
map <Leader>SF :s/_/-/g<CR>^gu$ " lowercase + _→-
map <Leader>S :%s/\s\+$//<CR>
map <Leader>x :%s/>/>\r/g<CR>gg=G " turn single line tags into multi-line
map <Leader>y ggVG
map <Leader>V vip!sort<CR>:w<CR>

map <Leader>P :!realpath "%" \| tr -d '\n' \| xclip -sel clip<CR><CR>
map <Leader>O :!realpath --relative-to=. "%" \| tr -d '\n' \| xclip -sel clip<CR><CR>
map <Leader>o :e `xclip -sel clip -o`<CR>
map <Leader>I :!echo -n "$(basename "%")" \| cut -f1 -d . \| tr -d '\n' \| xclip -sel clip<CR><CR>
map <Leader>R :setlocal relativenumber!<CR>
map <Leader>X :!run tmux-term<CR><CR>
map <Leader>gs yiw:!urxvt -e sh -c "cd $(pwd); git show --stat=1000 -p <C-r>0 \| vim -c 'set buftype=nofile' -" &<CR><CR> " show commit
" map <Leader>gs yiw:!urxvt -e sh -c \"cd $(pwd); git show --stat -p <C-r>0 \| vim '+nnoremap q :qal!<CR>' -" &<CR><CR> " show commit
" :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR>

cnoremap mk. !mkdir -p <c-r>=expand("%:h")<cr>/
nnoremap <F9> :!./%<CR>
nnoremap <F1> :NERDTreeToggle<CR>
nnoremap <F10> :!make clean &<CR><CR>
nnoremap <F11> :!make &<CR><CR>
nnoremap <Leader>z :setlocal spell<CR>z= " Suggest word under/after the cursor.
nnoremap <expr> gp '`[' . strpart(getregtype(), 0, 1) . '`]' " Reselect last pasted text.

inoremap <F2> <C-R>=expand("%:t:r")<CR>
nnoremap <F4>      =strftime("%b %-d")<CR>P
inoremap <F4> <C-R>=strftime("%b %-d")<CR>
nnoremap <F5>     "=strftime("%c")<CR>P
inoremap <F5> <C-R>=strftime("%c")<CR>
nnoremap <F6>     "=strftime("%F-%T")<CR>P
inoremap <F6> <C-R>=strftime("%F-%T")<CR>
" }}}

" Remaps {{{
map <Leader>gb :Git blame<CR>
map <Leader>gd :Gdiff<CR>
map <Leader>gu :GBrowse!<CR>
map <C-j> :noh<CR>:<ESC>
imap <silent> <C-j> <ESC>:noh<CR>i
imap <silent> <C-_> <ESC>:undo<CR>a
map <Leader>W :setlocal nowrap!<CR>
map <Leader>w :noautocmd w<CR>
map <Leader>T :set paste!<CR>
"map <Leader>N :set relativenumber!<CR>
map <silent> <M-m> :tabm +1<CR>
map <silent> <M-n> :tabm -1<CR>
map <M-z> :q<CR>
map â :q<CR>

" map <Leader>q :wq<CR>
" map <Leader>w :w<CR>

" Indent visually selected text.
vnoremap < <gv
vnoremap > >gv
" ^R in visual does :%s/SELECTED/
vnoremap <C-r> "hy:%s/<C-r>h/

" Visually select word under the cursor without moving.
nmap * g*N
nmap # g#N

ca te tabedit
ca W w
ca E e
ca Q q
map <M-h> <C-w>h
map <M-j> <C-w>j
map <M-k> <C-w>k
map <M-l> <C-w>l
map <M-q> <C-w>s
map <M-w> <C-w>v
map <C-n> gT
map <CR> gt " this used to be <c-m>
map <C-t> :tabnew %<CR><C-o>zz
map <Leader><C-t> :-tabnew %<CR><C-o>zz
nnoremap <Leader>N :-tabnew<CR>
nnoremap <Leader>M :tabnew<CR>
map â :q<CR>
nnoremap y_ ^yg_
" }}}

" Maps with functions {{{
function! s:MoveLine(direction) " Move line <count> lines higher/lower.
    if a:direction == 'k'
        let s:much  = -v:count1 - 1
    el
        let s:much  = '+' . v:count1
    en
    exe ':m ' . s:much
endf
nmap ek :<C-u>call <SID>MoveLine('k')<CR>
nmap ej :<C-u>call <SID>MoveLine('j')<CR>

function! s:CharacterDelta(delta) " Char analog of C-{x,a}
    normal! yl
    let c = nr2char(char2nr(getreg('"')) + a:delta)
    call setreg('"', c)
    normal! ""vP
endf
map <M-x> :call <SID>CharacterDelta(1)<CR>
map <M-c> :call <SID>CharacterDelta(-1)<CR>

function! s:ScalaSpecOpen()
  if @% !~# '/\(main\|test\)/'
    echoerr "unrecognizable filename pattern"
    return
  endif

  if @% =~# '/main/'
    let l:test = substitute(@%, '/main/', '/test/', '')
    let l:spec = substitute(l:test, '\.scala$', 'Spec.scala', '')
  else
    let l:test = substitute(@%, '/test/', '/main/', '')
    let l:spec = substitute(l:test, 'Spec\.scala$', '.scala', '')
  end

  execute 'edit '. l:spec
endf
autocmd vimrc FileType scala nnoremap <buffer> <C-w><C-e> :call <SID>ScalaSpecOpen()<CR>
autocmd vimrc FileType scala nnoremap <buffer> <Leader>E :call <SID>ScalaSpecOpen()<CR>
" }}}

" Functions {{{
function! SaveTrash(...)
  if a:0 == 0
    let suffix = ""
  else
    let suffix = "." . a:1
  end
  echo a:
  exe printf("write! trash/%s%s", strftime("%F.%H:%M"), suffix)
endf

command! -nargs=? Trash :call SaveTrash(<f-args>)

function! FnReminder(fn)
  call writefile([strftime("%F-%T") . ' ' . a:fn], "notes/filenames", "a")
endf
command! FnReminder :call FnReminder(@%)
nmap <leader>fr :FnReminder<CR>

" https://github.com/daGrevis/Dotfiles/blob/c4f32aed80d7742e436c1de11188a3ce44e93fdd/neovim/.config/nvim/init.vim#L234
function! g:Copy(text)
  let @* = a:text
  let @+ = a:text
endfunction
" }}}

" Markdown {{{
let g:mkdp_open_to_the_world = 1 " normally firewalled anyway
let g:mkdp_port = '7777'
let g:mkdp_page_title = 'Md: ${name}'
let g:mkdp_browserfunc = 'g:Mkdp_browserfunc'

function! g:Mkdp_browserfunc(url)
  echom a:url
  call Copy(a:url)
endfunction

function! Md()
    exe ':MarkdownPreview'
endfunction
command! Md call Md()
" }}}

" " Vimspector
" nmap <leader>vc <Plug>VimspectorContinue                     " When debugging, continue. Otherwise start debugging.
" nmap <leader>vst <Plug>VimspectorStop                        " Stop debugging.
" nmap <leader>vrt <Plug>VimspectorRestart                     " Restart debugging with the same configuration.
" nmap <leader>vrs <Plug>VimspectorReset                       " Restart debugging with the same configuration.
" nmap <leader>vp <Plug>VimspectorPause                        " Pause debuggee.
" nmap <leader>vbb <Plug>VimspectorToggleBreakpoint            " Toggle line breakpoint on the current line.
" nmap <leader>vbc <Plug>VimspectorToggleConditionalBreakpoint " Toggle conditional line breakpoint on the current line.
" nmap <leader>vbf <Plug>VimspectorAddFunctionBreakpoint       " Add a function breakpoint for the expression under cursor
" nmap <leader>vrc <Plug>VimspectorRunToCursor                 " Run to Cursor
" nmap <leader>vsn <Plug>VimspectorStepOver                    " Step Over
" nmap <leader>vsi <Plug>VimspectorStepInto                    " Step Into
" nmap <leader>vso <Plug>VimspectorStepOut
" " }}}
