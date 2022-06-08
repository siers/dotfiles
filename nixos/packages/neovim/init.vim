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
command! NF :-tabedit notes
command! NN :-tabedit notes/notes
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
map <Leader>SF :s/_/-/g<CR>^gu$ " lowercase + _→-
map <Leader>S :%s/\s\+$//<CR>
map <Leader>x :%s/>/>\r/g<CR>gg=G " turn single line tags into multi-line
map <Leader>y ggVG
map <Leader>V vip!sort<CR>:w<CR>

map <Leader>P :!realpath "%" \| tr -d '\n' \| xclip -sel clip<CR><CR>
map <Leader>O :!realpath --relative-to=. "%" \| tr -d '\n' \| xclip -sel clip<CR><CR>
map <Leader>I :!echo -n "$(basename "%")" \| cut -f1 -d . \| tr -d '\n' \| xclip -sel clip<CR><CR>
map <Leader>R :setlocal relativenumber!<CR>
map <Leader>X :!run tmux-term<CR><CR>
map <Leader>gs yiw:!urxvt -e sh -c "cd $(pwd); git show --stat -p <C-r>0 \| vim -" &<CR><CR> " show commit
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
map <Leader>w :w<CR>
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
map <C-m> gt
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

" Plugin settings {{{
silent! colorscheme jellyx
" silent! colorscheme palenight

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_mode_map = { "mode": "active",
                           \ "active_filetypes": [],
                           \ "passive_filetypes": ["scala"] }

let g:ctrlp_user_command = ['.git/', 'ls .git/CTRLP-ALL 2> /dev/null && find -type f || git --git-dir=%s/.git ls-files -oc --exclude-standard 2> /dev/null']
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
" }}}
