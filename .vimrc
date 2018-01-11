"vundle
set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
"git interface
Plugin 'tpope/vim-fugitive'
"filesystem
Plugin 'scrooloose/nerdtree'
Plugin 'jistr/vim-nerdtree-tabs'
Plugin 'kien/ctrlp.vim' 
Plugin 'Xuyuanp/nerdtree-git-plugin'

"copy and paste
Plugin 'tmux-plugins/vim-tmux-focus-events'
Plugin 'roxma/vim-tmux-clipboard'

"markdown
Plugin 'iamcco/mathjax-support-for-mkdp'
Plugin 'iamcco/markdown-preview.vim'

"vim-template
Plugin 'aperezdc/vim-template'

"html
"  isnowfy only compatible with python not python3
Plugin 'isnowfy/python-vim-instant-markdown'
Plugin 'jtratner/vim-flavored-markdown'
Plugin 'suan/vim-instant-markdown'
Plugin 'nelstrom/vim-markdown-preview'

"python sytax checker
Plugin 'nvie/vim-flake8'
Plugin 'vim-scripts/Pydiction'
Plugin 'vim-scripts/indentpython.vim'
Plugin 'scrooloose/syntastic'
Plugin 'Yggdroot/indentLine'
"auto-completion stuff
Plugin 'klen/python-mode'
Plugin 'Valloric/YouCompleteMe'
Plugin 'klen/rope-vim'
Plugin 'davidhalter/jedi-vim'
Plugin 'ervandew/supertab'
"code folding
Plugin 'tmhedberg/SimpylFold'

"Colors!!!
Plugin 'altercation/vim-colors-solarized'
Plugin 'jnurmine/Zenburn'
Plugin 'fugalh/desert.vim'

"Powerline
Plugin 'Lokaltog/powerline',{'rtp': 'powerline/bindings/vim/'}
"Plugin 'powerline/powerline'
"Plugin 'vim-airline/vim-airline'
"Plugin 'vim-airline/vim-airline-themes'

"isort 
Plugin 'fisadev/vim-isort'

"yapf
Plugin 'google/yapf',{'rtp': 'plugins/vim'}
call vundle#end()

filetype plugin indent on    " enables filetype detection
let g:SimpylFold_docstring_preview = 1

"pymode
let g:pymode_rope_lookup_project = 0
let g:pymode_rope = 0

"powerline 
let g:Powerline_symbols='fancy'
"let g:Powerline_symbols = 'unicode'
set laststatus=2

"let g:airline_theme='papercolor'

"autocomplete
let g:ycm_autoclose_preview_window_after_completion=1
let g:ycm_autoclose_preview_window_after_insertion =1
let g:ycm_key_invoke_completion='<C-Space>'
let g:pydiction_location='~/.vim/bundle/Pydiction/complete-dict'

"custom keys
let mapleader=" "
map <leader>g:YcmCompleter GoToDefinitionElseDeclaration<CR>

" jedi shortcuts
let g:jedi#goto_command = "<leader>d"
let g:jedi#documentation_command = "K"
let g:jedi#usages_command = "<leader>n"
let g:jedi#show_call_signatures = "1"
let g:jedi#completions_enabled = 0

"indent line
let g:indentLine_char = "┆"
let g:indentLine_enabled = 1
let g:autopep8_disable_show_diff=1


call togglebg#map("<F5>")

"colorscheme solarized
set guifont=Monaco:h14
"set guifont = Powerline:h14

colorscheme desert
let NERDTreeIgnore=['\.pyc$', '\~$'] "ignore files in NERDTree

"nerdtree git
let g:NERDTreeIndicatorMapCustom = {
    \ "Modified"  : "✹",
    \ "Staged"    : "✚",
    \ "Untracked" : "✭",
    \ "Renamed"   : "➜",
    \ "Unmerged"  : "═",
    \ "Deleted"   : "✖",
    \ "Dirty"     : "✗",
    \ "Clean"     : "✔︎",
    \ 'Ignored'   : '☒',
    \ "Unknown"   : "?"
    \ }


"I don't like swap files
set noswapfile

"isort 
let g:vim_isort_map = "<C-i>"

"yapf
map <C-Y> :call yapf#YAPF()<cr>
imap <C-Y> <c-o>:call yapf#YAPF()<cr>
"turn on numbering
set nu

"python with virtualenv support
py << EOF
import os.path
import sys
import vim
if 'VIRTUA_ENV' in os.environ:
  project_base_dir = os.environ['VIRTUAL_ENV']
  sys.path.insert(0, project_base_dir)
  activate_this = os.path.join(project_base_dir,'bin/activate_this.py')
  execfile(activate_this, dict(__file__=activate_this))
EOF

"it would be nice to set tag files by the active virtualenv here
":set tags=~/mytags "tags for ctags and taglist
"omnicomplete
autocmd FileType python set omnifunc=pythoncomplete#Complete

"------------Start Python PEP 8 stuff----------------
" Number of spaces that a pre-existing tab is equal to.
au BufRead,BufNewFile *py,*pyw,*.c,*.h set tabstop=4
"spaces for indents
au BufRead,BufNewFile *.py,*pyw set shiftwidth=4
au BufRead,BufNewFile *.py,*.pyw set expandtab
au BufRead,BufNewFile *.py set softtabstop=4
" Use the below highlight group when displaying bad whitespace is desired.
highlight BadWhitespace ctermbg=red guibg=red
" Display tabs at the beginning of a line in Python mode as bad.
au BufRead,BufNewFile *.py,*.pyw match BadWhitespace /^\t\+/
" Make trailing whitespace be flagged as bad.
au BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/

" Wrap text after a certain number of characters
au BufRead,BufNewFile *.py,*.pyw, set textwidth=100

" Use UNIX (\n) line endings.
au BufNewFile *.py,*.pyw,*.c,*.h set fileformat=unix

" Set the default file encoding to UTF-8:
set encoding=utf-8

" For full syntax highlighting:
let python_highlight_all=1
syntax on

" Keep indentation level from previous line:
autocmd FileType python set autoindent

"make backspaces more powerfull
set backspace=indent,eol,start

"copy 
set clipboard=unnamed

"new file template
"autocmd BufNewFile *.py 0r ~/.vim/template/sample.py
"autocmd BufNewFile *.sh 0r ~/.vim/template/sample.sh

"Folding based on indentation:
autocmd FileType python set foldmethod=indent

"nerdtree setting
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc()==0 && !exists('s:std_in') | NERDTree | endif
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" nerdtree specify
map <C-n> :NERDTreeToggle<CR>
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'

" nerdtree tab key mapping
map <C-t><C-o> <plug>NERDTreeTabsOpen<CR>
map <C-t><C-u> <plug>NERDTreeTabClose<CR>
map <C-t><C-i> <Plug>NERDTreeTabsFind<CR>

" nerdtree tab settings

"nerdtree create a new file with vim-template
"function EditNewFilename()
"  let l:filename = input("filename: ")
"  execute edit(colon)  . l:filename
"endfunction
"
"call NERDTreeAddMenuItem({
"  \ 'text': 'New with templ(A)te',
"  \ 'shortcut': 'A',
"  \ 'callback': 'EditNewFilename' })

let g:email='yuiant@qq.com'

function! GetCurrentContent()
  let l:content = getline(0,line("$"))
  let l:result = 0
  for l:temp in l:content
    if strlen(l:temp)> 0
      let l:result = 1
      break
    endif
  endfor
  if l:result == 0
    let l:extension = expand("%:c")
    exe 'Template .' . l:extension
  endif
endfunction
autocmd BufEnter * call GetCurrentContent()




"use space to open folds
"nnoremap <space> za 

"split 
nnoremap <C-H> <C-W><C-H>
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>

"----------Stop python PEP 8 stuff--------------
"js stuff"
autocmd FileType javascript setlocal shiftwidth=2 tabstop=2the splitTab
