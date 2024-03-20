" TODO: bugs when sourcing this script the first time
" TODO: it seems `:colo rosepine` is called before the plugin is installed
" (despite the --sync; does PlugInstall open a new buffer so that the reading
" of .vimrc goes on and errors out?
" TODO: `Plug 'rose-pine/vim'` in the plugin list is probably failing (other
" colorschemes like gruvbox are working?)
" TODO: `coc-settings.json` is put into 000 permission mode when installed for
" some reason " must `chmod +rw` it manually

set nocp
syntax on
filetype plugin indent on

let g:mapleader="<space>"
" List all extenstions used by coc-nvim
let g:coc_global_extensions=['coc-clangd']

" https://github.com/junegunn/vim-plug/wiki/tips#automatic-installation
" Install vim-plug if not found
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

" Run PlugInstall if there are missing plugins
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \| PlugInstall --sync | source $MYVIMRC
\| endif

" https://github.com/junegunn/vim-plug/wiki/tutorial
" :PlugInstall to install plugins in this list
" :PlugUpdate
" :PlugClean after removing a line from the list
" git must be installed
" Put the following line in between
" Plug <plugin-name> [options]
call plug#begin()

" https://github.com/rose-pine/vim
Plug 'rose-pine/vim'

" https://github.com/nvm-sh/nvm
" Use nvm to install local updated node/nodejs version (required)
" https://github.com/clangd/coc-clangd
" Run `:CocCommand clangd.install` for local updated clangd version, else will
" use system installed binaries (older version)
Plug 'neoclide/coc.nvim', {'branch': 'release'}

call plug#end()

set ts=2 sts=2 sw=2 et si ai
set nu rnu so=5 scl=yes cc=80
set wmnu ttyfast mouse=a nobk nowb ut=300
set tgc bg=dark spr sb
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
