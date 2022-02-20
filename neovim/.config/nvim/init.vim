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

" Prerequisite for compe plugin
set completeopt=menuone,noselect

" ---- Plugin installation ----

" Setup vim plug and get plugins
call plug#begin('~/.config/nvim/vim_plug')
Plug 'Reewr/vim-monokai-phoenix' " color scheme
Plug 'itchyny/lightline.vim'     " better status bar
Plug 'ctrlpvim/ctrlp.vim'        " file search
Plug 'scrooloose/nerdtree'       " file nav split
Plug 'tpope/vim-fugitive'        " git wrapper
Plug 'tpope/vim-rhubarb'         " allows vim-fugitive to directly browse to Github
Plug 'tpope/vim-sleuth'          " auto-detect indent settings
Plug 'jremmen/vim-ripgrep'       " ripgrep text search
Plug 'pangloss/vim-javascript'   " better javascript highlighting
Plug 'dag/vim-fish'              " Syntax highlighting for fish shell
Plug 'elixir-editors/vim-elixir' " Syntax highlighting for elixir
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() } }
Plug 'neovim/nvim-lspconfig'     " Config extension for neovim lsp support
Plug 'hrsh7th/nvim-compe'        " Auto completion that hooks into lsp
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
" call neomake#configure#automake('w')

" Neovim LSP
lua << EOF
local pid = vim.fn.getpid()
-- Omnisharp (C#)
local omnisharp_bin = "/home/jai/opt/omnisharp-v1.37.14/run"
require'lspconfig'.omnisharp.setup{
    cmd = { omnisharp_bin, "--languageserver" , "--hostPID", tostring(pid) };
}

-- Clangd (C/C++)
require 'lspconfig'.clangd.setup{}

-- Solargraph (Ruby)
require 'lspconfig'.solargraph.setup{}
EOF

" Compe
lua << EOF
-- Compe setup
require'compe'.setup {
  enabled = true;
  autocomplete = true;
  debug = false;
  min_length = 1;
  preselect = 'enable';
  throttle_time = 80;
  source_timeout = 200;
  incomplete_delay = 400;
  max_abbr_width = 100;
  max_kind_width = 100;
  max_menu_width = 100;
  documentation = true;

  source = {
    path = true;
    nvim_lsp = true;
  };
}
EOF

" Hook compe into LSP
lua << EOF
local t = function(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local check_back_space = function()
  local col = vim.fn.col('.') - 1
  if col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
    return true
  else
    return false
  end
end

-- Use (s-)tab to:
--- move to prev/next item in completion menuone
--- jump to prev/next snippet's placeholder
_G.tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t "<C-n>"
  elseif check_back_space() then
    return t "<Tab>"
  else
    return vim.fn['compe#complete']()
  end
end
_G.s_tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t "<C-p>"
  else
    return t "<S-Tab>"
  end
end

vim.api.nvim_set_keymap("i", "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("i", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})

--This line is important for auto-import
vim.api.nvim_set_keymap('i', '<cr>', 'compe#confirm("<cr>")', { expr = true })
vim.api.nvim_set_keymap('i', '<c-space>', 'compe#complete()', { expr = true })
EOF

" Autoformat
nnoremap <silent> ff    <cmd>lua vim.lsp.buf.formatting_sync()<CR>
" Rename word
nnoremap <silent> fr    <cmd>lua vim.lsp.buf.rename()<CR>
" Hover word for info
nnoremap <silent> fh    <cmd>lua vim.lsp.buf.hover()<CR>

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
    autocmd Filetype ruby setlocal cc=90
augroup end

augroup commitmsg_ft
    autocmd!
    autocmd Filetype gitcommit setlocal spell spelllang=en_gb
    autocmd Filetype gitcommit setlocal cc=72
augroup end

augroup cs_ft
    autocmd!
    autocmd Filetype cs setlocal cc=120
augroup end
