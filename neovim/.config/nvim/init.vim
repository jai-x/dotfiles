" ---- Basic neovim config ----

" Don't scroll cursor to edges
set scrolloff=10

" Better split opening
set splitbelow
set splitright

" Ruler
set cc=80

" Line numbers
set number

" Caps commands
command W w
command Q q

" H and L go to line ends
noremap H 0
noremap L $

" Let mouse click and scroll
set mouse=a

" Smartindent
set smartindent

" Preferred global indents
set tabstop=4
set shiftwidth=4

" Don't wrap text
set nowrap

" Highlight the line on column the cursor is on
set cursorline
set cursorcolumn

" Show tabs and trailing spaces
set listchars=tab:»\ ,extends:›,precedes:‹,nbsp:·,trail:·
set list

" Enable code folding by syntax
set foldmethod=indent
set foldlevel=99
set nofoldenable

" Better split navigation
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

command Jterm :sp <bar> :resize 20 <bar> :terminal

" Prevent getting into Replace mode
imap <Insert> <Nop>
inoremap <S-Insert> <Insert>
nmap R <Nop>

" Using escape to exit from terminal buffer instead of the default commands
tnoremap <Esc> <C-\><C-n>

" Escape to clear search highlighting in normal mode
nnoremap <Esc> :noh<Cr>

" ---- Plugin installation ----

" Setup vim plug and get plugins
call plug#begin('~/.config/nvim/vim_plug')
Plug 'Reewr/vim-monokai-phoenix' " color scheme
Plug 'itchyny/lightline.vim'     " better status bar
Plug 'ctrlpvim/ctrlp.vim'        " file search
Plug 'scrooloose/nerdtree'       " file nav split
Plug 'ervandew/supertab'         " tab completion
Plug 'tpope/vim-fugitive'        " git wrapper
Plug 'tpope/vim-rhubarb'         " allows vim-fugitive to directly browse to Github
Plug 'tommcdo/vim-fubitive'      " allows vim-fugitive to directly browse to BitBucket
Plug 'jremmen/vim-ripgrep'       " ripgrep text search
Plug 'pangloss/vim-javascript'   " better javascript highlighting
Plug 'neomake/neomake'           " Async linting and job control
Plug 'dag/vim-fish'              " Syntax highlighting for fish shell
Plug 'elixir-editors/vim-elixir' " Syntax highlighting for elixir
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() } }
call plug#end()

" ---- Plugin configuration ----

" Best colorscheme
colorscheme monokai-phoenix

" Stop showing mode as lightline.vim does this better
set noshowmode

" Use ripgrep for Ctrl-P file searching
set grepprg=rg\ --vimgrep
let g:ctrlp_user_command = 'rg %s --files --vimgrep'
let g:ctrlp_use_caching = 0 " ripgrep is fast enough to not need caching

" Show CtrlP MRU files relative to CWD
let g:ctrlp_mruf_relative = 1
let g:ctrlp_mruf_default_order = 1

" Auto NERDTree close
" autocmd bufenter * if (winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree()) | q | endif

" NERDTree size
let g:NERDTreeWinSize=35

" Neomake run on buffer write
call neomake#configure#automake('w')

" ---- Filetype specific configuration ----

augroup nerdtree_ft
    autocmd!
    autocmd Filetype nerdtree setlocal nocursorcolumn
augroup end

augroup terminal_ft
    autocmd!
    autocmd TermOpen * setlocal nonumber
    autocmd TermOpen * setlocal winfixheight
    autocmd TermOpen * setlocal winfixwidth
    autocmd TermOpen * setlocal scrolloff=0
augroup end

augroup python_ft
    autocmd!
    autocmd Filetype python setlocal tabstop=4
    autocmd Filetype python setlocal shiftwidth=4
    autocmd Filetype python setlocal expandtab
augroup end

augroup markdown_ft
    autocmd!
    autocmd Filetype markdown setlocal tabstop=2
    autocmd Filetype markdown setlocal shiftwidth=2
    autocmd Filetype markdown setlocal expandtab
    autocmd Filetype markdown setlocal spell spelllang=en_gb
    autocmd Filetype markdown setlocal textwidth=80
    autocmd Filetype markdown setlocal formatoptions=jtl
augroup end

augroup ruby_ft
    autocmd!
    autocmd Filetype ruby setlocal tabstop=2
    autocmd Filetype ruby setlocal shiftwidth=2
    autocmd Filetype ruby setlocal cc=90
    autocmd Filetype ruby setlocal expandtab
augroup end

augroup sh_ft
    autocmd!
    autocmd Filetype sh setlocal tabstop=4
    autocmd Filetype sh setlocal shiftwidth=4
    autocmd Filetype sh setlocal expandtab
augroup end

augroup commitmsg_ft
    autocmd!
    autocmd Filetype gitcommit setlocal spell spelllang=en_gb
    autocmd Filetype gitcommit setlocal cc=72
augroup end

augroup vim_ft
    autocmd!
    autocmd Filetype vim setlocal tabstop=4
    autocmd Filetype vim setlocal shiftwidth=4
    autocmd Filetype vim setlocal expandtab
augroup end

augroup javascript_ft
    autocmd!
    autocmd Filetype javascript setlocal tabstop=2
    autocmd Filetype javascript setlocal shiftwidth=2
    autocmd Filetype javascript setlocal expandtab
augroup end

augroup json_ft
    autocmd!
    autocmd Filetype json setlocal tabstop=2
    autocmd Filetype json setlocal shiftwidth=2
    autocmd Filetype json setlocal expandtab
augroup end

augroup html_ft
    autocmd!
    autocmd Filetype html setlocal tabstop=2
    autocmd Filetype html setlocal shiftwidth=2
    autocmd Filetype html setlocal expandtab
augroup end

augroup css_ft
    autocmd!
    autocmd Filetype css setlocal tabstop=2
    autocmd Filetype css setlocal shiftwidth=2
    autocmd Filetype css setlocal expandtab
augroup end

augroup cs_ft
    autocmd!
    autocmd Filetype cs setlocal tabstop=4
    autocmd Filetype cs setlocal shiftwidth=4
    autocmd Filetype cs setlocal expandtab
    autocmd Filetype cs setlocal cc=120
augroup end

augroup yaml_ft
    autocmd!
    autocmd Filetype yaml setlocal tabstop=2
    autocmd Filetype yaml setlocal shiftwidth=2
    autocmd Filetype yaml setlocal expandtab
augroup end

augroup fish_ft
    autocmd!
    autocmd Filetype fish setlocal tabstop=2
    autocmd Filetype fish setlocal shiftwidth=2
    autocmd Filetype fish setlocal expandtab
augroup end

augroup xml_ft
    autocmd!
    autocmd Filetype xml setlocal tabstop=2
    autocmd Filetype xml setlocal shiftwidth=2
    autocmd Filetype xml setlocal expandtab
augroup end
