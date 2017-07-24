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

set expandtab shiftround smarttab autoindent
set nofoldenable foldmethod=indent
set tabstop=4 laststatus=2 shiftwidth=4 showtabline=2 softtabstop=4

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

" ==============================================================================

" curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs \
"    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
call plug#begin('~/.config/nvim/plugged')

Plug 'https://github.com/ctrlpvim/ctrlp.vim'
Plug 'https://github.com/tpope/vim-fugitive' " Git.
Plug 'https://github.com/tpope/vim-rhubarb'
Plug 'https://github.com/tommcdo/vim-fubitive'
Plug 'https://github.com/tpope/vim-commentary'
Plug 'https://github.com/tpope/vim-surround'
Plug 'https://github.com/tpope/vim-repeat'
Plug 'https://github.com/tpope/vim-abolish' " Subvert, crs.
Plug 'https://github.com/ervandew/supertab'
Plug 'https://github.com/junegunn/vim-easy-align'
Plug 'https://github.com/kshenoy/vim-signature' " Marks of all kind.
Plug 'https://github.com/Yggdroot/indentLine'
Plug 'https://github.com/FooSoft/vim-argwrap'
Plug 'https://github.com/guns/jellyx.vim'
Plug 'https://github.com/AndrewRadev/sideways.vim' " argument swapping
Plug 'https://github.com/evanmiller/nginx-vim-syntax'
Plug 'https://github.com/vim-airline/vim-airline'
Plug 'https://github.com/hashivim/vim-terraform'
Plug 'https://github.com/AndrewRadev/splitjoin.vim'
Plug 'https://github.com/ekalinin/Dockerfile.vim'

Plug 'https://github.com/severin-lemaignan/vim-minimap'
"Plug 'https://github.com/Valloric/YouCompleteMe', { 'do': './install.py' }
"Plug 'https://github.com/justinmk/vim-sneak' " f/t for double chars
"Plug 'https://github.com/junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
"Plug 'https://github.com/Raimondi/delimitMate'
"Plug 'https://github.com/tpope/vim-sleuth' " Local tabs/spaces.

if system("hostname") == "spiral\n"
    Plug 'https://github.com/mhinz/vim-signify' " Git diff signs.
endif

call plug#end()

" ==============================================================================

nnoremap <silent> <leader>a :ArgWrap<CR>
let g:ctrlp_user_command = ['.git/', 'ls .git/CTRLP-ALL 2> /dev/null && find -type f || git --git-dir=%s/.git ls-files -oc --exclude-standard 2> /dev/null']

" Keeps s/S original functionality.
" https://github.com/justinmk/vim-sneak/issues/87
"nmap <Plug>(Go_away_Sneak_s) <Plug>Sneak_s
"nmap <Plug>(Go_away_Sneak_S) <Plug>Sneak_S

xmap ga <Plug>(EasyAlign) | nmap ga <Plug>(EasyAlign)

nnoremap <M-H> :SidewaysLeft<CR>
nnoremap <M-L> :SidewaysRight<CR>

" ==============================================================================

filetype plugin indent on
syntax on
silent! colorscheme jellyx

if ! exists("vimpager")
    " No commands below this comment will be executed in vimpager,
    " it whines about my :Share.
    set list lcs=tab:»·,trail:·
else
    set nonumber
endif

" When reading a file, jump to the last cursor position.
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
au FileType ruby      setlocal sw=2 ts=2
au FileType go        setlocal noet
au FileType terraform setlocal sw=2 ts=2
au FileType yaml      setlocal sw=2 ts=2

ca te tabedit
ca W w
ca E e
ca Q q

let g:mapleader = "\<Space>"

"   <Leader>standard filenames
map <Leader>sf :s/_/-/g<CR>^gu$

map <Leader>s :%s/\s\+$//<CR>
map <Leader>y mtggVG"+y`tzz
map <Leader>b :ls<CR>:b
map <Leader>p :!realpath % \| tr -d '\n' \| xclip<CR><CR>
map <Leader>v vip!hs-import-sort<CR>:w<CR>
map <Leader>i ?^import <CR>:noh<CR>
map <Leader>r :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR>
map <Leader>x :%s/>/>\r/g<CR>gg=G
map <Leader>gd :Gdiff<CR>
map <Leader>gb :Gblame<CR>
map <Leader>gu :Gbrowse!<CR>
map <Leader>gs yiw:!urxvt -e sh -c "cd $(pwd); git show --stat -p <C-r>0 \| vim -" &<CR><CR>

map <Leader>w :w<CR>
map <Leader>q :wq<CR>
map <M-a> gT
map <M-s> gt
map <M-z> :q<CR>
map <M-t> :tabnew<CR>

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

map <silent> <F1> :NERDTreeToggle<CR>
nnoremap <F5> "=strftime("%c")<CR>P
inoremap <F5> <C-R>=strftime("%c")<CR>
nnoremap <F6> "=strftime("%F-%T")<CR>P
inoremap <F6> <C-R>=strftime("%F.%T")<CR>
nmap <F9> :!./%<CR>
map <F10> :!make clean &<CR><CR>
map <F11> :!make &<CR><CR>
map <F12> :make all<CR>
inoremap <F6> <C-R>=strftime("%F-%T")<CR>

" :Share to sprunge.us
exec 'command! -range=% Share :<line1>,<line2>write !paste'

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

" Reselect last pasted text.
nnoremap <expr> gp '`[' . strpart(getregtype(), 0, 1) . '`]'

function! s:CharacterDelta(delta) " Char analog of C-{x,a}
    normal! yl
    let c = nr2char(char2nr(getreg('"')) + a:delta)
    call setreg('"', c)
    normal! ""vP
endf
map <M-x> :call <SID>CharacterDelta(1)<CR>
map <M-c> :call <SID>CharacterDelta(-1)<CR>

"hi Normal ctermbg=none
