let g:mapleader="<space>"

" https://github.com/junegunn/vim-plug/wiki/tips#automatic-installation
" Ensure vim-plug is installed
if empty(glob('~/.vim/autoload/plug.vim'))
  silent execute '!curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" https://github.com/junegunn/vim-plug/wiki/tutorial
" :PlugInstall to install plugins in this list
" :PlugUpdate
" :PlugClean after removing a line from the list
" git must be installed
" Put the following line in between
" Plug <plugin-name> [options]
call plug#begin()
" https://github.com/nvm-sh/nvm
" Must install nodejs/node, npm, nvm (for local updated node versions) and clangd
" https://github.com/clangd/coc-clangd
" Must run :PlugInstall, :CocInstall coc-clangd, :CocCommand clangd.install,
" for local updated clangd versions
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" https://github.com/rose-pine/vim
Plug 'rose-pine/vim'
call plug#end()

set nocompatible
syntax on
filetype plugin indent on
set nu rnu tgc cc=80 scl=yes so=5 bg=dark
set ts=2 sts=2 sw=2 et si ai
set wmnu ttyfast mouse=a nobk nowb ut=300
set spr sb
colo rosepine

" https://github.com/neoclide/coc.nvim/wiki/Completion-with-sources
" coc-nvim config
function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Mapping tab to navigate autocomplete
inoremap <silent><expr> <Tab> coc#pum#visible() ? coc#pum#next(1) : CheckBackspace() ? "\<Tab>" : coc#refresh()
inoremap <expr> <Tab> coc#pum#visible() ? coc#pum#next(1) : "\<Tab>"
inoremap <expr> <S-Tab> coc#pum#visible() ? coc#pum#prev(1) : "\<S-Tab>"

" Mapping enter to confirm autocomplete
inoremap <silent><expr> <cr> coc#pum#visible() ? coc#_select_confirm() : "\<C-g>u\<CR>"

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming
nmap <leader>rn <Plug>(coc-rename)
