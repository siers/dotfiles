" configure haskell properly for god's sakes!
" https://www.reddit.com/r/haskell/comments/a4lr0h/haskell_programming_set_up_in_vim/

" http://ix.io/1BXY
" cinoremap <Space>ex.. <C-r>=fnameescape(expand('%:.'))<CR>
" cnoremap <Space>ex.h <C-r>=fnameescape(expand('%:.:h'))<CR>
" cnoremap <Space>ex.t <C-r>=expand('%:t')<CR>

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

" ==============================================================================

set dir=/var/tmp nobackup
set encoding=utf-8
set ffs=unix,dos,mac
set history=10000
set undofile

set expandtab shiftround smarttab autoindent
set nofoldenable foldmethod=indent
set laststatus=2 tabstop=4 shiftwidth=4 showtabline=4 softtabstop=4

set ignorecase smartcase
set incsearch hlsearch
set wildmenu wildmode=longest,full completeopt=menu,menuone,preview

set showcmd
set bs=indent,eol,start
set clipboard=unnamedplus
set cursorline number
set mouse=a
set shortmess+=I
set splitbelow splitright
set statusline=%f%m%r%h%w\ [%n:%{&ff}/%Y]%=[0x\%04.4B][%03v][%p%%\ line\ %l]

let g:mapleader = "\<Space>"

" ==============================================================================

" curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs \
"    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
call plug#begin('~/.config/nvim/plugged')

Plug 'https://github.com/guns/jellyx.vim'
Plug 'https://github.com/ctrlpvim/ctrlp.vim'
Plug 'https://github.com/vim-airline/vim-airline'
Plug 'https://github.com/ervandew/supertab'
Plug 'https://github.com/Yggdroot/indentLine'
Plug 'https://github.com/junegunn/vim-easy-align'
Plug 'https://github.com/AndrewRadev/splitjoin.vim'
Plug 'https://github.com/AndrewRadev/sideways.vim' " argument swapping
Plug 'https://github.com/sjl/gundo.vim'
Plug 'https://github.com/tpope/vim-obsession'
Plug 'https://github.com/mhinz/vim-signify' " Git diff signs.
Plug 'https://github.com/benekastah/neomake'

Plug 'https://github.com/tpope/vim-commentary'
Plug 'https://github.com/tpope/vim-repeat'
Plug 'https://github.com/tpope/vim-abolish' " Subvert, crs.
Plug 'https://github.com/justinmk/vim-sneak' " f/t for double chars

Plug 'https://github.com/tpope/vim-fugitive' " Git.
Plug 'https://github.com/tpope/vim-rhubarb'
Plug 'https://github.com/tommcdo/vim-fubitive'

Plug 'https://github.com/hashivim/vim-terraform'
Plug 'https://github.com/ekalinin/Dockerfile.vim'
Plug 'https://github.com/LnL7/vim-nix'
Plug 'https://github.com/gisraptor/vim-lilypond-integrator'
Plug 'https://github.com/cakebaker/scss-syntax.vim'
Plug 'https://github.com/bronson/vim-ruby-block-conv'
Plug 'https://github.com/posva/vim-vue'
Plug 'https://github.com/isRuslan/vim-es6'

" The Plugs below don't mean much to me.
"Plug 'https://github.com/SirVer/ultisnips'
Plug 'https://github.com/vim-scripts/vis' " :'<,'>B s/// for visual blocks
Plug 'https://github.com/thiagoalessio/rainbow_levels.vim'
Plug 'https://github.com/nixprime/cpsm'
" Plug 'https://github.com/mattn/emmet-vim' " div#foo<C-y>, => <div id=foo>

Plug 'junegunn/fzf'
" Plug 'autozimu/LanguageClient-neovim', { 'branch': 'next', 'do': 'bash install.sh' }
" Plug 'roxma/nvim-completion-manager'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
let g:deoplete#enable_at_startup = 1
Plug 'tbodt/deoplete-tabnine', { 'do': './install.sh' }
Plug 'vim-syntastic/syntastic'

if ! exists("vimpager")
    " No commands below this comment will be executed in vimpager,
    Plug 'https://github.com/tpope/vim-surround'
    Plug 'https://github.com/kshenoy/vim-signature' " Marks of all kind.
endif

call plug#end()

" ==============================================================================

let g:syntastic_always_populate_loc_list = 1

"

let g:ctrlp_user_command = ['.git/', 'ls .git/CTRLP-ALL 2> /dev/null && find -type f || git --git-dir=%s/.git ls-files -oc --exclude-standard 2> /dev/null']
let g:ctrlp_map = ''

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

" let g:ctrlp_match_func = {'match': 'cpsm#CtrlPMatch'}
" ERROR: cpsm built with version of Python not supported by Vim

xmap ga <Plug>(EasyAlign) | nmap ga <Plug>(EasyAlign)

nnoremap <Leader>eh :SidewaysLeft<CR>
nnoremap <Leader>el :SidewaysRight<CR>
nnoremap <leader>er :RainbowLevelsToggle<cr>

command! Session :Obsession .session.vim

" Just like standard f/F except it works on multiple lines.
nmap f <Plug>Sneak_f
nmap F <Plug>Sneak_F
vmap f <Plug>Sneak_f
vmap F <Plug>Sneak_F

" Keeps s/S original functionality.
" https://github.com/justinmk/vim-sneak/issues/87
nmap <Plug>(Go_away_Sneak_s) <Plug>Sneak_s
nmap <Plug>(Go_away_Sneak_S) <Plug>Sneak_S

let g:rainbow_levels = [
    \{'ctermbg': 232, 'guibg': '#121212'},
    \{'ctermbg': 233, 'guibg': '#1c1c1c'},
    \{'ctermbg': 234, 'guibg': '#262626'},
    \{'ctermbg': 235, 'guibg': '#303030'},
    \{'ctermbg': 236, 'guibg': '#3a3a3a'},
    \{'ctermbg': 237, 'guibg': '#444444'},
    \{'ctermbg': 238, 'guibg': '#4e4e4e'},
    \{'ctermbg': 239, 'guibg': '#585858'},
    \{'ctermbg': 240, 'guibg': '#626262'}]

" ==============================================================================

filetype plugin indent on
syntax on
silent! colorscheme jellyx

if ! exists("vimpager")
    set list lcs=tab:»·,trail:·
else
    set nonumber
endif

" When reading a file, jump to the last cursor position.
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
au FileType go         setlocal noet
au FileType vim        nnoremap <buffer> <F9> :source %<CR>
au FileType ruby,terraform,yaml,javascript,nix,scss,vim,vue,css,erb,haskell setlocal sw=2 ts=2
au FileType erb setlocal sw=2 ts=2
autocmd BufWritePre * %s/\s\+$//e
map <silent> <leader>st :set ts=2 sw=2<CR>

" ==============================================================================

ca te tabedit
ca W w
ca E e
ca Q q

"   <Leader>standard filenames
map <Leader>sf :s/_/-/g<CR>^gu$
map <Leader>s :%s/\s\+$//<CR>
map <Leader>x :%s/>/>\r/g<CR>gg=G
map <Leader>y myggVG"+y`ymyzz
map <Leader>l :setlocal nowrap!<CR>
map <Leader>t :set paste!<CR>
map <Leader>N :set relativenumber!<CR>

" map <Leader>h vip!hs-import-sort<CR>:w<CR>
map <Leader>i ?^import <CR>:noh<CR>
map <Leader>i ?^import <CR>:noh<CR>
map <Leader>v vip!sort<CR>:w<CR>

map <Leader>p :!realpath % \| tr -d '\n' \| xclip<CR><CR>
map <Leader>o :!realpath --relative-to=. % \| tr -d '\n' \| xclip<CR><CR>
map <Leader>O :!echo -n "$(basename %)" \| xclip<CR><CR>
map <Leader>r :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR>
" git show
map <Leader>gs yiw:!urxvt -e sh -c "cd $(pwd); git show --stat -p <C-r>0 \| vim -" &<CR><CR>
map <silent> gr :tabm +1<CR>
map <silent> gR :tabm -1<CR>

" map <Leader>b :ls<CR>:b
map <Leader>gb :Gblame<CR>
map <Leader>gd :Gdiff<CR>
map <Leader>gu :Gbrowse!<CR>
map <Leader>q :wq<CR>
map <Leader>w :w<CR>
map <Leader>e :e<CR>
map <C-n> gT
map <C-m> gt
map <M-a> gT
map <M-s> gt
map <C-t> :tabnew<CR>
map <M-r> :tabnew<CR>gR
map <M-z> :q<CR>

nnoremap <M-n> ^
nnoremap <M-m> $
map [o O<ESC>
map ]o o<ESC>
map <M-h> <C-w>h
map <M-j> <C-w>j
map <M-k> <C-w>k
map <M-l> <C-w>l
map <M-q> <C-w>s
map <M-w> <C-w>v
nmap <Down> gj
nmap <Up> gk
map <C-j> :noh<CR>:<ESC>
imap <silent> <C-j> <ESC>:noh<CR>i
imap <silent> <C-_> <ESC>:undo<CR>a

cnoremap mk. !mkdir -p <c-r>=expand("%:h")<cr>/
nnoremap zh 10zh
nnoremap zl 10zl

map <silent> <F1> :NERDTreeToggle<CR>
nnoremap <F4> <C-R>=strftime("%b %-d")<CR>P
inoremap <F4> <C-R>=strftime("%b %-d")<CR>
nnoremap <F5> "=strftime("%c")<CR>P
inoremap <F5> <C-R>=strftime("%c")<CR>
nnoremap <F6> "=strftime("%F-%T")<CR>P
inoremap <F6> <C-R>=strftime("%F.%T")<CR>
nmap <F9> :!./%<CR>
map <F10> :!make clean &<CR><CR>
map <F11> :!make &<CR><CR>
map <silent> <leader>c :%!rufo 2> /dev/null \|\| :<CR>
inoremap <F6> <C-R>=strftime("%F-%T")<CR>

" Reselect last pasted text.
nnoremap <expr> gp '`[' . strpart(getregtype(), 0, 1) . '`]'

" ==============================================================================

" :Share to sprunge.us
exec 'command! -range=% Share :<line1>,<line2>write !pasty'

command! Config :tabedit ~/.config/nvim/init.vim
command! -range=% Sum :<line1>,<line2>!paste -sd+ | bc

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
