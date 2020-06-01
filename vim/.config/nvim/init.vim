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
set undofile

set list lcs=tab:»·,trail:·
set expandtab shiftround smarttab autoindent
set laststatus=2 tabstop=4 shiftwidth=4 showtabline=4 softtabstop=4
set bs=indent,eol,start
set cursorline number
set nofoldenable foldmethod=indent

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
" }}}

" Plugins {{{
call plug#begin('~/.config/nvim/plugged')

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
Plug 'https://github.com/vim-syntastic/syntastic'
Plug 'https://github.com/SirVer/ultisnips'
Plug 'https://github.com/honza/vim-snippets'
Plug 'https://github.com/tpope/vim-surround'
Plug 'https://github.com/kshenoy/vim-signature' " Marks of all kind.
Plug 'https://github.com/liuchengxu/vista.vim'

Plug 'https://github.com/tpope/vim-fugitive' " Git.
Plug 'https://github.com/shumphrey/fugitive-gitlab.vim'
Plug 'https://github.com/tpope/vim-rhubarb'
Plug 'https://github.com/tommcdo/vim-fubitive'

Plug 'https://github.com/neoclide/coc.nvim', {'branch': 'release'}
Plug 'https://github.com/neoclide/coc-json', {'do': 'yarn install --frozen-lockfile --force'}
Plug 'https://github.com/neoclide/coc-tsserver', {'do': 'yarn install --frozen-lockfile --force'}
Plug 'https://github.com/scalameta/coc-metals', {'do': 'yarn install --frozen-lockfile --force'}
Plug 'https://github.com/weirongxu/coc-explorer', {'do': 'yarn install --frozen-lockfile --force'}

Plug 'https://github.com/LnL7/vim-nix'
Plug 'https://github.com/isRuslan/vim-es6'
Plug 'https://github.com/derekwyatt/vim-scala'
Plug 'https://github.com/jamessan/vim-gnupg'
Plug 'https://github.com/hashivim/vim-terraform'
Plug 'https://github.com/gisraptor/vim-lilypond-integrator'
Plug 'https://github.com/posva/vim-vue'
Plug 'https://github.com/cakebaker/scss-syntax.vim'
Plug 'https://github.com/ekalinin/Dockerfile.vim'

" The Plugs below don'https://github.com/t mean much to me.
Plug 'https://github.com/wsdjeg/vim-fetch'
Plug 'https://github.com/HerringtonDarkholme/yats.vim', {'for': ['typescript', 'typescript.jsx']}
Plug 'https://github.com/nixprime/cpsm'
Plug 'https://github.com/junegunn/fzf.vim'
" Plug 'https://github.com/mattn/emmet-vim' " div#foo<C-y>, => <div id=foo>
" Plug 'https://github.com/ervandew/supertab'
" Plug 'https://github.com/AndrewRadev/splitjoin.vim'
" Plug 'https://github.com/AndrewRadev/sideways.vim' " argument swapping
" Plug 'https://github.com/junegunn/vim-easy-align'

call plug#end()
"}}}

" Plugin settings {{{
silent! colorscheme jellyx
" silent! colorscheme palenight

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_mode_map = { "mode": "active",
                           \ "active_filetypes": [],
                           \ "passive_filetypes": ["scala"] }

let g:ctrlp_user_command = ['.git/', 'ls .git/CTRLP-ALL 2> /dev/null && find -type f || git --git-dir=%s/.git ls-files -oc --exclude-standard 2> /dev/null']
let g:ctrlp_map = ''

let g:UltiSnipsExpandTrigger = "<C-s>"
let g:UltiSnipsEditSplit = "vertical"

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

let g:vista_default_executive = 'coc'
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

" Language servers {{{
call coc#config('coc.preferences', {
      \ 'diagnostic.errorSign': 'E',
      \ 'diagnostic.warningSign': 'W',
      \ 'diagnostic.infoSign': 'I',
      \ 'diagnostic.hintSign': 'H',
      \ })

call coc#config('diagnostic', {
      \ 'refreshAfterSave': 0,
      \ 'maxWindowHeight': 16,
      \ })

call coc#config('explorer', {
      \ 'keyMappings.<tab>': 'quit',
      \ 'keyMappings.<cr>': ['expandable?', 'expandOrCollapse', 'open'],
      \ 'openAction.changeDirectory': 0,
      \ 'quitOnOpen': 1,
      \ 'sources': [{'name': 'file', 'expand': 1}],
      \ 'file.columns': ['git', 'indent', 'icon', 'filename', 'readonly', ['fullpath'], ['size'], ['created'], ['modified']],
      \ 'file.showHiddenFiles': 1,
      \ 'width': 60,
      \ 'icon.enableNerdfont': 1,
      \ 'previewAction.onHover': 0,
      \ })

call coc#config('languageserver.haskell', {
      \ 'command': 'hie-wraper',
      \ 'args': ['--lsp'],
      \ "rootPatterns": ["stack.yaml", "cabal.config", "package.yaml"],
      \ "filetypes": ["hs", "lhs", "haskell" ],
      \ "initializationOptions.languageServerHaskell": {},
      \ })

" nnoremap <Tab> :CocCommand explorer<CR>
" }}}

" Autocmds {{{
augroup vimrc
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
command! NF :tabedit notes
command! NN :tabedit notes/notes
command! -range=% Sum :<line1>,<line2>!paste -sd+ | bc
command! CL :tabedit %
command! RMNL :%g/^$/d

command! Session :Obsession .session.vim
command! PI :PlugInstall
command! PC :PlugClean

" :Share to sprunge.us
exec 'command! -range=% Share :<line1>,<line2>write !pasty'
" }}}

" Jump to file: ~/.config/nvim/plugin/coc-mappings.vim

" Creative maps {{{
map <Leader>sf :s/_/-/g<CR>^gu$ " lowercase + _→-
map <Leader>s :%s/\s\+$//<CR>
map <Leader>x :%s/>/>\r/g<CR>gg=G " turn single line tags into multi-line
map <Leader>y myggVG"+y`ymyzz " yank file
map <Leader>v vip!sort<CR>:w<CR>

map <Leader>P :!realpath % \| tr -d '\n' \| xclip<CR><CR>
map <Leader>O :!realpath --relative-to=. % \| tr -d '\n' \| xclip<CR><CR>
map <Leader>I :!echo -n "$(basename %)" \| xclip<CR><CR>
map <Leader>R :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR>
map <Leader>X :!run tmux-term<CR><CR>
map <Leader>gs yiw:!urxvt -e sh -c "cd $(pwd); git show --stat -p <C-r>0 \| vim -" &<CR><CR> " show commit

cnoremap mk. !mkdir -p <c-r>=expand("%:h")<cr>/
nnoremap <F9> :!./%<CR>
nnoremap <F10> :!make clean &<CR><CR>
nnoremap <F11> :!make &<CR><CR>
nnoremap <Leader>z :setlocal spell<CR>z= " Suggest word under/after the cursor.
nnoremap <expr> gp '`[' . strpart(getregtype(), 0, 1) . '`]' " Reselect last pasted text.

nnoremap <F4>      =strftime("%b %-d")<CR>P
inoremap <F4> <C-R>=strftime("%b %-d")<CR>
nnoremap <F5>     "=strftime("%c")<CR>P
inoremap <F5> <C-R>=strftime("%c")<CR>
nnoremap <F6>     "=strftime("%F-%T")<CR>P
inoremap <F6> <C-R>=strftime("%F-%T")<CR>
" }}}

" Remaps {{{
map <Leader>gb :Gblame<CR>
map <Leader>gd :Gdiff<CR>
map <Leader>gu :Gbrowse!<CR>
map <C-j> :noh<CR>:<ESC>
imap <silent> <C-j> <ESC>:noh<CR>i
imap <silent> <C-_> <ESC>:undo<CR>a
map <Leader>W :setlocal nowrap!<CR>
map <Leader>T :set paste!<CR>
"map <Leader>N :set relativenumber!<CR>
map <silent> gr :tabm +1<CR>
map <silent> gR :tabm -1<CR>

" map <Leader>q :wq<CR>
" map <Leader>w :w<CR>

" Indent visually selected text.
vnoremap < <gv
vnoremap > >gv

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
map <C-m> gt
map <C-t> :tabnew %<CR><C-o>zz
nnoremap <Leader>N :tabnew<CR>:tabm -1<CR>
nnoremap <Leader>M :tabnew<CR>
map <M-z> :q<CR>
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
" }}}

" Functions {{{
function! SaveTrash(...)
  exe printf("write! trash/%s", strftime("%F-%H-%M"))
endf

command! Trash :call SaveTrash()
" }}}
