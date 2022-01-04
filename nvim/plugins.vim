call plug#begin()

" ### Fuzzy finder
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'

nnoremap <leader>f :FZF .<CR>
nnoremap <leader>fh :FZF ~<CR>

" ### Code completion
Plug 'ncm2/ncm2'
Plug 'roxma/nvim-yarp'

" :help Ncm2PopupOpen for more information
set completeopt=noinsert,menuone,noselect

" ncm2 Extensions
Plug 'ncm2/ncm2-bufword'
Plug 'ncm2/ncm2-path'
Plug 'ncm2/ncm2-github'
Plug 'ncm2/ncm2-jedi'	" python
Plug 'ncm2/ncm2-vim'
Plug 'ncm2/ncm2-go'
Plug 'oncomouse/ncm2-biblatex'

" ### Directory tree
Plug 'scrooloose/nerdtree'

nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <leader>nerd :NERDTree<CR>
nnoremap <leader>nt :NERDTreeToggle<CR>
nnoremap <leader>nf :NERDTreeFind<CR>

let NERDTreeShowHidden=1

call plug#end()

" enable ncm2 for all buffers
autocmd BufEnter * call ncm2#enable_for_buffer()

