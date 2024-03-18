set nocompatible
syntax on
filetype plugin indent on

set nu rnu tgc cc=80 scl=yes so=5
set ts=2 sts=2 sw=2 et si ai
set wmnu ttyfast mouse=a
set spr sb

colo habamax

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
" Must run :PlugInstall, :CoC-Install coc-clangd, for the extension, must have
" nodejs, npm and clangd packages/binaries
" https://github.com/clangd/coc-clangd
Plug 'neoclide/coc.nvim', {'branch': 'release'}
call plug#end()

" coc.nvim keybinds
" https://github.com/neoclide/coc.nvim/wiki/Completion-with-sources
function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

inoremap <silent><expr> <Tab> coc#pum#visible() ? coc#pum#next(1) : CheckBackspace() ? "\<Tab>" : coc#refresh()
inoremap <expr> <Tab> coc#pum#visible() ? coc#pum#next(1) : "\<Tab>"
inoremap <expr> <S-Tab> coc#pum#visible() ? coc#pum#prev(1) : "\<S-Tab>"

" inoremap <silent><expr> <c-space> coc#refresh()
" inoremap <silent><expr> <c-@> coc#refresh()

" Pick behaviour when pressing enter
" inoremap <expr> <cr> coc#pum#visible() ? coc#pum#confirm() : "\<CR>"
inoremap <silent><expr> <cr> coc#pum#visible() ? coc#_select_confirm() : "\<C-g>u\<CR>"
" inoremap <silent><expr> <cr> coc#pum#visible() ? coc#_select_confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
" inoremap <silent><expr> <cr> coc#pum#visible() && coc#pum#info()['index'] != -1 ? coc#pum#confirm() : "\<C-g>u\<CR>"

