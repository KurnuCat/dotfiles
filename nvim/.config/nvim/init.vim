" Use utf8 encoding
set encoding=utf-8

" Basic visual settings
set number

" fuzzy finder settings
map <leader>f :FZF<CR>

" map jk to esc
imap jk <Esc>

" Keybindings for better split navigation
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Open new split panes to right and bottom
set splitbelow splitright

" Enable autocompletion:
set wildmode=longest,list,full

" Disables automatic commenting on newline:
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" Open new tab
imap ,t <Esc>:tabnew<CR>

" Ignore case in a pattern
set ignorecase

" Compile document, be it groff/LaTeX/markdown/etc.
map <leader>c :w! \| !compiler "%:p"<CR>

" Runs a script that cleans out tex build files whenever I close out of a .tex file.
autocmd VimLeave *.tex !texclear %

" Save file as sudo on files that require root permission
cabbrev w!! execute 'silent! write !sudo tee % >/dev/null' <bar> edit!

" Changing the default leader key which is ""
let mapleader = '\'

" Automatically deletes all trailing whitespace and newlines at end of file on save. & reset cursor position
 	autocmd BufWritePre * let currPos = getpos(".")
	autocmd BufWritePre * %s/\s\+$//e
	autocmd BufWritePre * %s/\n\+\%$//e
  autocmd BufWritePre *.[ch] %s/\%$/\r/e " add trailing newline for ANSI C standard
  autocmd BufWritePre *neomutt* %s/^--$/-- /e " dash-dash-space signature delimiter in emails
  	autocmd BufWritePre * cal cursor(currPos[1], currPos[2])

" Auto-install vim-plug and plugins
let need_to_install_plugins = 0
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall | source $MYVIMRC
  let need_to_install_plugins = 1
endif

if need_to_install_plugins == 1
    echo "Installing plugins..."
    silent! PlugInstall
    echo "Done!"
    q
endif

" For use of vim-plug plugin manager
call plug#begin()
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'junegunn/goyo.vim'
Plug 'vimwiki/vimwiki'
Plug 'xuhdev/vim-latex-live-preview', { 'for': 'tex' }
Plug 'preservim/nerdtree'
Plug 'ap/vim-css-color'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'vim-airline/vim-airline'
Plug 'junegunn/fzf'
Plug 'LunarWatcher/auto-pairs'
Plug 'matze/vim-move'
Plug 'mhinz/vim-startify'
call plug#end()

" Autopairs toggle
let g:AutoPairsShortcutToggle = '<leader>p'

" vim-airline
	if !exists('g:airline_symbols')
  	    let g:airline_symbols = {}
	endif
	let g:airline_symbols.colnr = ' C:'
	let g:airline_symbols.linenr = ' L:'
	let g:airline_symbols.maxlinenr = '☰ '

" Nerd tree
	map <leader>n :NERDTreeToggle<CR>
	autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
    if has('nvim')
        let NERDTreeBookmarksFile = stdpath('data') . '/NERDTreeBookmarks'
    else
        let NERDTreeBookmarksFile = '~/.vim' . '/NERDTreeBookmarks'
    endif

" pdf program for vim-latex-live-preview
let g:livepreview_previewer = 'zathura'

" Start Goyo for when opening markdown files
autocmd BufRead,BufNewFile *.md :Goyo 80

" Change Vimwiki syntax to markdown and set vimwiki path
let g:vimwiki_list = [{'path': '~/sync/notes/',
                      \ 'syntax': 'markdown', 'ext': '.md'}]

" Coc prettier
command! -nargs=0 Prettier :CocCommand prettier.forceFormatDocument

" Coc servers
let g:coc_global_extensions = [
            \ 'coc-prettier',
            \ 'coc-html',
            \ 'coc-css',
            \ 'coc-tsserver',
	    \ 'coc-jedi',
            \ 'coc-sh',
	    \ 'coc-json',
	    \ '@yaegassy/coc-marksman'
            \ ]
