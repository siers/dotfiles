set encoding=utf-8
set bs=indent,eol,start
set expandtab
set tabstop=4
set laststatus=2
set shiftwidth=4
set showtabline=2
set softtabstop=4
set nofoldenable
set foldmethod=indent
set smarttab
set shiftround
set number
set hidden
set nobackup
set autoindent
set mouse=a
set incsearch
set hlsearch
set dir=/var/tmp
set wildmenu
set wildmode=longest,full
set completeopt=menu,menuone,preview
set ignorecase
set smartcase
set statusline=%f%m%r%h%w\ [%n:%{&ff}/%Y]%=[0x\%04.4B][%03v][%p%%\ line\ %l]
set ffs=unix,dos,mac
set clipboard=unnamedplus
set history=10000
filetype plugin indent on
syntax on
silent! colorscheme jellyx
let g:AutoCloseExpandEnterOn = ""
if ! exists("vimpager")
    " No commands below this comment will be executed in vimpager,
    " it whines about my :Share.
    set list lcs=tab:»·,trail:·
else
    set nonumber
endif

" Load pathogen managed plugins.
silent! call pathogen#infect()

" When reading a file, jump to the last cursor position.
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
au FileType ruby   setlocal sw=4
au FileType ruby   setlocal ts=4
au FileType ruby   setlocal sw=2
au FileType ruby   setlocal ts=2
au FileType go     setlocal noet

" My keymaps.
" gvim key maps.
if has("gui_running")
    set gfn=Monaco\ 10
    set go=
    "colorscheme ir_black
    map <A-h> <C-w>h
    map <A-j> <C-w>j
    map <A-k> <C-w>k
    map <A-l> <C-w>l
    map <A-q> <C-w>s
    map <A-w> <C-w>v
endif

ca te tabedit
ca W w
ca E e
ca Q q

"ap <Leader>shell expand; to apply on formats 'PS1 % some cmd'
map <Leader>se yypdf%x!!sh>GkyyGGpOj
map <Leader>s :%s/\s\+$//<CR>
map <Leader>y mtggVG"+y`tzz
map <Leader>b :ls<CR>:b
map <Leader>p :!realpath % \| tr -d '\n' \| xclip<CR><CR>
map <Leader>v vip!hs-import-sort<CR>:w<CR>
map <Leader>i ?^import <CR>:noh<CR>
map <Leader>gd :Gdiff<CR>
map <Leader>gb :Gblame<CR>
map <Leader>gs yiw:!git show <C-r>0<CR>
map <Leader>w :w<CR>
map <Leader>q :wq<CR>

map [o O<ESC>
map ]o o<ESC>
map <M-h> <C-w>h
map <M-j> <C-w>j
map <M-k> <C-w>k
map <M-l> <C-w>l
map <M-q> <C-w>s
map <M-w> <C-w>v
map <F12> :make all<CR>
map <F11> :!make &<CR><CR>
map <F10> :!make clean &<CR><CR>
map <M-a> gT
map <M-s> gt
map <M-z> :q<CR>
map <M-Z> :Bclose!<CR><M-z>
map <M-t> :tabnew<CR>
map <silent> <F1> :NERDTreeToggle<CR>
map <silent> <F3> :Tlist<CR>
map <C-j> :noh<CR>:<ESC>
" Insert maps, so awesome, you'll shit rainbow.
imap <silent> <C-j> <ESC>:noh<CR>i
imap <silent> <C-_> <ESC>:undo<CR>a
" Rarely used maps.
nmap <F9> :!./%<CR>
nnoremap <F5> "=strftime("%c")<CR>P
inoremap <F5> <C-R>=strftime("%c")<CR>
nnoremap <F6> "=strftime("%F-%T")<CR>P
inoremap <F6> <C-R>=strftime("%F-%T")<CR>
nnoremap <silent> \r :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR>

nmap <Down> gj
nmap <Up> gk
fu! s:go(direction)
    if a:direction == 'k'
        let s:much  = -v:count1 - 1
    el
        let s:much  = '+' . v:count1
    en
    exe ':m ' . s:much
endf
nmap ek :<C-u>call <SID>go('k')<CR>
nmap ej :<C-u>call <SID>go('j')<CR>
" Reselect last pasted text.
nnoremap <expr> gp '`[' . strpart(getregtype(), 0, 1) . '`]'

hi Normal ctermbg=none

" Paste to sprunge.us, the best paste site by rupa.
let s:cmd = system("uname -s | tr -d '\n'") == "Darwin" ? "pbcopy" : "xclip"
exec 'command! -range=% Share :<line1>,<line2>write !curl -sF "sprunge=<-" http://sprunge.us|'.s:cmd

" fun! -- ctions!
" My first function in VimL for char analog of C-{x,a}
fu! Chr_delta(delta)
    normal! yl
    let c = nr2char(char2nr(getreg('"')) + a:delta)
    call setreg('"', c)
    normal! ""vP
endf
map <M-x> :call Chr_delta(1)<CR>
map <M-c> :call Chr_delta(-1)<CR>

let g:ctrlp_user_command = [
            \ '.git/',
            \ 'git --git-dir=%s/.git ls-files -oc --exclude-standard'
            \ ]

" grevis
" function! StatusLinePath()
"     let s:path = @%
"     if s:path ==# ''
"         let s:path = '[No Name]'
"     endif
"
"     if mode() ==# 'v' || mode() ==# 'V'
"         exe 'normal "xy'
"         let s:col = strlen(@x)
"         exe 'normal gv'
"     else
"         let s:col = virtcol('.')
"     endif
"
"     let s:output = s:path . ':' . line('.') . '|' . s:col
"     return s:output
" endfunction
"
" set statusline=
" " Path and line number.
" set statusline+=%{StatusLinePath()}
"
