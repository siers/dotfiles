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
Plug 'https://github.com/honza/vim-snippets'
Plug 'https://github.com/tpope/vim-surround'
Plug 'https://github.com/kshenoy/vim-signature' " Marks of all kind.
" Plug 'https://github.com/liuchengxu/vista.vim'

Plug 'https://github.com/tpope/vim-fugitive' " Git.
Plug 'https://github.com/shumphrey/fugitive-gitlab.vim'
Plug 'https://github.com/tpope/vim-rhubarb'
Plug 'https://github.com/tommcdo/vim-fubitive'

Plug 'https://github.com/neoclide/coc.nvim', {'branch': 'release'}
Plug 'https://github.com/neoclide/coc-json', {'do': 'yarn install --frozen-lockfile --force'}
Plug 'https://github.com/neoclide/coc-tsserver', {'do': 'yarn install --frozen-lockfile --force'}
Plug 'https://github.com/scalameta/coc-metals', {'do': 'yarn install --frozen-lockfile --force'}
" Plug 'https://github.com/puremourning/vimspector'
Plug 'https://github.com/neoclide/coc-snippets', {'do': 'yarn install --frozen-lockfile --force'}
Plug 'https://github.com/iamcco/coc-actions', {'do': 'yarn install --frozen-lockfile --force'}

Plug 'https://github.com/LnL7/vim-nix'
Plug 'https://github.com/isRuslan/vim-es6'
Plug 'https://github.com/derekwyatt/vim-scala'
Plug 'https://github.com/jamessan/vim-gnupg'
Plug 'https://github.com/hashivim/vim-terraform'
Plug 'https://github.com/gisraptor/vim-lilypond-integrator'
Plug 'https://github.com/posva/vim-vue'
Plug 'https://github.com/cakebaker/scss-syntax.vim'
Plug 'https://github.com/ekalinin/Dockerfile.vim'

" The Plugs below don't mean much to me.
Plug 'https://github.com/wsdjeg/vim-fetch'
Plug 'https://github.com/HerringtonDarkholme/yats.vim', {'for': ['typescript', 'typescript.jsx']}
Plug 'https://github.com/nixprime/cpsm'
Plug 'https://github.com/junegunn/fzf.vim'
" Plug 'https://github.com/mattn/emmet-vim' " div#foo<C-y>, => <div id=foo>
" Plug 'https://github.com/ervandew/supertab'
" Plug 'https://github.com/AndrewRadev/splitjoin.vim'
" Plug 'https://github.com/AndrewRadev/sideways.vim' " argument swapping
" Plug 'https://github.com/junegunn/vim-easy-align'
" Plug 'https://github.com/severin-lemaignan/vim-minimap'

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

call coc#config('languageserver.haskell', {
      \ "command": "haskell-language-server-wrapper",
      \ "args": ["--lsp", "-l", "/tmp/hlsp.log"],
      \ "rootPatterns": ["*.cabal", "stack.yaml", "cabal.project", "package.yaml", "hie.yaml"],
      \ "filetypes": ["haskell", "lhaskell"]
      \ })

call coc#config("coc.preferences.formatOnSaveFiletypes", ["scala"])

" call coc#config("metals.serverVersion", "0.9.0") " downgrade

" nnoremap <Tab> :CocCommand explorer<CR>
let g:vimspector_enable_mappings = 'HUMAN'
" packadd! vimspector
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

" Intellisense maps {{{
" You will have a bad experience with diagnostic messages with the default of 4000.
set updatetime=300

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> <leader>gr <Plug>(coc-references)

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Remap for format selected region
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>F  <Plug>(coc-format)

" Toggle panel with Tree Views
nnoremap <silent> <space>t :<C-u>CocCommand metals.tvp<CR>
" Toggle Tree View 'metalsBuild'
nnoremap <silent> <space>tb :<C-u>CocCommand metals.tvp metalsBuild<CR>
" Toggle Tree View 'metalsCompile'
nnoremap <silent> <space>tc :<C-u>CocCommand metals.tvp metalsCompile<CR>
" Reveal current current class (trait or object) in Tree View 'metalsBuild'
" nnoremap <silent> <space>tf :<C-u>CocCommand metals.revealInTreeView metalsBuild<CR>
nnoremap <silent> <space>tf :<C-u>CocCommand metals.revealInTreeView metalsPackages<CR>

" Use K to either doHover or show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" My own mappings
nmap <space>e :CocCommand explorer<CR>
"
" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by another plugin.
" inoremap <silent><expr> <TAB>
"       \ pumvisible() ? "\<C-n>" :
"       \ <SID>check_back_space() ? "\<TAB>" :
"       \ coc#refresh()
" inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

" Used in the tab autocompletion for coc
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

imap <C-l> <Plug>(coc-snippets-expand-jump)

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Show all diagnostics
nnoremap <silent> <space>D  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>

xmap <silent> <leader>a :<C-u>execute 'CocCommand actions.open ' . visualmode()<CR>
nmap <silent> <leader>a :<C-u>set operatorfunc=<SID>cocActionsOpenFromSelected<CR>g@
" }}}

" Creative maps {{{
map <Leader>SF :s/_/-/g<CR>^gu$ " lowercase + _→-
map <Leader>S :%s/\s\+$//<CR>
map <Leader>x :%s/>/>\r/g<CR>gg=G " turn single line tags into multi-line
map <Leader>y ggVG
map <Leader>v vip!sort<CR>:w<CR>

map <Leader>P :!realpath % \| tr -d '\n' \| xclip -sel clip<CR><CR>
map <Leader>O :!realpath --relative-to=. % \| tr -d '\n' \| xclip -sel clip<CR><CR>
map <Leader>I :!echo -n "$(basename %)" \| cut -f1 -d . \| tr -d '\n' \| xclip -sel clip<CR><CR>
map <Leader>R :setlocal relativenumber!<CR>
map <Leader>X :!run tmux-term<CR><CR>
map <Leader>gs yiw:!urxvt -e sh -c "cd $(pwd); git show --stat -p <C-r>0 \| vim -" &<CR><CR> " show commit
" :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR>

cnoremap mk. !mkdir -p <c-r>=expand("%:h")<cr>/
nnoremap <F9> :!./%<CR>
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
map <Leader>gb :Gblame<CR>
map <Leader>gd :Gdiff<CR>
map <Leader>gu :Gbrowse!<CR>
map <C-j> :noh<CR>:<ESC>
imap <silent> <C-j> <ESC>:noh<CR>i
imap <silent> <C-_> <ESC>:undo<CR>a
map <Leader>W :setlocal nowrap!<CR>
map <Leader>T :set paste!<CR>
"map <Leader>N :set relativenumber!<CR>
map <silent> <M-m> :tabm +1<CR>
map <silent> <M-n> :tabm -1<CR>

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
" }}}
