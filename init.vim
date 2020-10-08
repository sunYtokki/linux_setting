call plug#begin('/home/syk2145/.config/nvim/plugged')

    Plug 'neoclide/coc.nvim', {'branch': 'release'}

    "syntax highlighting
    Plug 'sheerun/vim-polyglot'
    Plug 'ianks/vim-tsx'
    Plug 'jackguo380/vim-lsp-cxx-highlight'

    "file navigation
    Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
    Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
    Plug 'ctrlpvim/ctrlp.vim'

    "git plug-ins
    Plug 'airblade/vim-gitgutter'
    Plug 'tpope/vim-fugitive'
    Plug 'Xuyuanp/nerdtree-git-plugin'
    Plug 'ryanoasis/vim-devicons'

    "convini
    Plug 'scrooloose/nerdcommenter'
    Plug 'optroot/auto-pairs'
    Plug '907th/vim-auto-save'
    Plug 'tpope/vim-surround'

    "colorschemes
    Plug 'lifepillar/vim-solarized8'

call plug#end()

"colorscheme
set termguicolors

let g:solarized_extra_hi_groups = "1"
let g:solarized_italics = "1"
let g:solarized_statusline = "low"
let g:solarized_visibility = "low"
colorscheme solarized8 
noremap <silent><leader>csl :colo solarized8 <bar>:set bg=light<CR>
noremap <silent><leader>csd :colo solarized8 <bar>:set bg=dark<CR>

"autoasve
let g:auto_save = 0
let g:auto_save_events = ["InsertLeave", "TextChanged"]
noremap <leader>as :let auto_save = 1<CR>
noremap <leader>ns :let auto_save = 0<CR>

" Persistent undo
set undofile
set undodir=$HOME/.config/nvim/undo
set undolevels=1000
set undoreload=10000

"misc
set clipboard+=unnamedplus
set number!
set mouse:a 
set ignorecase
set backupdir^=~/.backup
set dir^=~/.backup//

"save fold
set foldmethod=manual
augroup remember_folds
  autocmd!
  au BufWinLeave ?* mkview 
  au BufWinEnter ?* silent! loadview 
augroup END

"change cursor and highlite line when insert mode
autocmd InsertEnter * set cul
autocmd InsertLeave * set nocul

""blink cursor :help guicursor
":set guicursor=n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50
  "\,a:blinkwait500-blinkoff500-blinkon350
  "\,sm:block-blinkwait500-blinkoff400-blinkon250

"indent seting by file type
set tabstop=4 shiftwidth=4 expandtab
autocmd FileType html,css,scss,javascriptreact,javascript,javascript.jsx setlocal expandtab softtabstop=2 shiftwidth=2  
autocmd FileType text setlocal expandtab softtabstop=2 textwidth=76 spell spelllang=en_us

"remap some filetypes
autocmd FileType javascript setlocal ft=javascript.jsx
autocmd FileType htmldjango setlocal ft=html
"autocmd FileType javascriptreact syntax match Comment +\/\/.\+$+
"autocmd FileType htmldjango syntax match Comment +s/^\(.*\)$/<!-- \1 -->/+

" :set list
set listchars=eol:↪,space:•,tab:▒░,trail:░,extends:⟩,precedes:⟨

"correct current working directory
autocmd BufEnter * silent! lcd %:p:h

"disable arrows on nmap
nnoremap <Down> <Nop>
nnoremap <Left> <Nop>
nnoremap <Right> <Nop>
nnoremap <Up> <Nop>

"hjkl navigation on imap
inoremap <C-h> <Left>
inoremap <C-j> <Down>
inoremap <C-k> <Up>
inoremap <C-l> <Right>

"switch to visual mode on imap
imap <C-v> <BS>v

"insert blank line on nmap
nnoremap <Space><Space> a<Space><esc>
nnoremap <Return> o<esc>

"keep visual selection when shift indent
vnoremap < <gv
vnoremap > >gv

"clear highlights on hitting ESC twice
nnoremap <silent> <esc><esc> :noh<return>

" naviate between pane
nnoremap <C-h> <C-w><C-h>
nnoremap <C-l> <C-w><C-l>
nnoremap <C-k> <C-w><C-k>
nnoremap <C-j> <C-w><C-j>

"resize pane
if bufwinnr(1)
    noremap <S-up> :resize +5<CR>
    noremap <S-down> :resize -5<CR>
    noremap <S-rght> :vertical resize +5<CR>
    noremap <S-left> :vertical resize -5<CR>
endif

"close buffer without closing split pane
command! BD :bn|:bd#

"vim setting for coc
    " TextEdit might fail if hidden is not set.
set hidden 
    " Some servers have issues with backup files, see #649.
set nobackup 
set nowritebackup
    " Give more space for displaying messages.
set cmdheight=2 
set updatetime=300
    " Don't pass messages to |ins-completion-menu|.
set shortmess+=c 
    " Always show the signcolumn, otherwise it would shift the text each time
set signcolumn=yes 

"coc LSP functions
    " Use tab for trigger completion with characters ahead and navigate.
    " make sure tab is not mapped by other plugin 
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

    " Use <Tab> and <S-Tab> to navigate the completion list <cr> to confirm
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>" 
inoremap <expr> <S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

    "completion trigger
inoremap <silent><expr> <c-n> coc#refresh() 

    "diagnostics navigation
nmap <silent> g[ <Plug>(coc-diagnostic-prev) 
nmap <silent> g] <Plug>(coc-diagnostic-next)

    " GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

    "Close the preview window when completion is done.
autocm! CompleteDone * if pumvisible() == 0 | pclose | endif

    " Use + to show documentation in preview window.
nnoremap <silent> + :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

    " Symbol renaming.
nmap <leader>n <Plug>(coc-rename)

    "coc-highlight all occurrence
autocmd CursorHold * silent call CocActionAsync('highlight')

nmap <C-n> :NERDTreeToggle<CR>
"Nerd Commenter
vmap -- <plug>NERDCommenterToggle
nmap -- <plug>NERDCommenterToggle

