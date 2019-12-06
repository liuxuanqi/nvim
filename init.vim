" __  ____   __  _   ___     _____ __  __ ____   ____ 
"|  \/  \ \ / / | \ | \ \   / /_ _|  \/  |  _ \ / ___|
"| |\/| |\ V /  |  \| |\ \ / / | || |\/| | |_) | |    
"| |  | | | |   | |\  | \ V /  | || |  | |  _ <| |___ 
"|_|  |_| |_|   |_| \_|  \_/  |___|_|  |_|_| \_\\____|
                                                     
" Author: @theniceboy

" Checkout-list
" vim-esearch
" fmoralesc/worldslice
" SidOfc/mkdx

" ===
" === Auto load for first time uses
" ===
if empty(glob('~/.config/nvim/autoload/plug.vim'))
	silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
		\ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" ====================
" === Editor Setup ===
" ====================

" ===
" === System
" ===
"set clipboard=unnamed
let &t_ut=''

set encoding=UTF-8
set autochdir "auto switch dirs
set number
set relativenumber
set cursorline
set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4

" come from vimplus
set autoindent
set cindent " c stype indent
set cinoptions=g0,:0,N-s,(0)
set smartindent
set nobackup
set noswapfile
set autoread
set autowrite
set confirm

"------------------------------------------------------------------------------
" coc.nvim related
set hidden "  TextEdit might fail if not set
set updatetime=300 "for diagnostics messages
set signcolumn=yes


set list
set listchars=tab:▸\ ,trail:▫
set scrolloff=4               "Minimal number of screen lines to keep above and below the cursor.
set ttimeoutlen=0
set notimeout
set viewoptions=cursor,folds,slash,unix
set nowrap
set tw=0
set indentexpr=
set foldmethod=indent
set foldlevel=99
set foldenable
set formatoptions-=tc
set splitright
set splitbelow
set noshowmode
set showcmd
" set wildignore=log/**,node_modules/**,target/**,tmp/**,*.rbc
set wildmenu
exec "nohlsearch"
set ignorecase
set smartcase
set shortmess+=c
set inccommand=split
set ttyfast "should make scrolling faster
set lazyredraw "same as above
set visualbell
silent !mkdir -p ~/.config/nvim/tmp/backup
silent !mkdir -p ~/.config/nvim/tmp/undo
set backupdir=~/.config/nvim/tmp/backup,.
set directory=~/.config/nvim/tmp/backup,.
if has('persistent_undo')
	set undofile
	set undodir=~/.config/nvim/tmp/undo,.
endif
set colorcolumn=80

" Cursor shape
let &t_SI = "\<Esc>]50;CursorShape=1\x7"
let &t_SR = "\<Esc>]50;CursorShape=2\x7"
let &t_EI = "\<Esc>]50;CursorShape=0\x7"

au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif


" ===
" === Terminal Behavior
" ===
let g:neoterm_autoscroll = 1
autocmd TermOpen term://* startinsert
tnoremap <C-N> <C-\><C-N>


" ===
" === Basic Mappings
" ===
let mapleader=" "

nnoremap <c-s> :w<cr> " Save & quit

noremap <leader>rc :e ~/.config/nvim/init.vim<cr> " Open the vimrc file anytime
noremap <leader>st :Startify<cr> " Open Startify

inoremap jj <esc> 

noremap <leader><cr> :nohlsearch<cr> " Stop highlighting

noremap <silent> <leader>o za " Folding

" ===
" === Window management
" ===
" Use <space> + new arrow keys for moving the cursor around windows
noremap <leader>w <C-w>w
noremap <leader>k <C-w>k
noremap <leader>j <C-w>j
noremap <leader>h <C-w>h
noremap <leader>l <C-w>l

" split the screens
noremap <leader>sk :set nosplitbelow<CR>:split<CR>:set splitbelow<CR>
noremap <leader>sj :set splitbelow<CR>:split<CR>
noremap <leader>sh :set nosplitright<CR>:vsplit<CR>:set splitright<CR>
noremap <leader>sl :set splitright<CR>:vsplit<CR>
noremap <leader>sh <C-w>t<C-w>K " Place the two screens up and down
noremap <leader>sv <C-w>t<C-w>H " Place the two screens side by side

" Resize splits with arrow keys
noremap <up> :res +5<CR>
noremap <down> :res -5<CR>
noremap <left> :vertical resize-5<CR>
noremap <right> :vertical resize+5<CR>

" Rotate screens
noremap <leader>srh <C-w>b<C-w>K
noremap <leader>srv <C-w>b<C-w>H

" ===
" === Tab management
noremap <leader>tn :tabe<CR> " Create a new tab with tn
noremap <leader>tc :tabc<CR> " close tab
noremap <leader>to :tabo<CR>
noremap <silent><c-j> :-tabnext<cr>
noremap <silent><c-k> :+tabnext<cr>



" ===
" === Buffer management
" Move around buffers
noremap <C-L> :bn<CR>
noremap <C-H> :bp<CR>
noremap <C-C> :Bclose<CR>

" Opening a terminal window
noremap <LEADER>/ :set splitbelow<CR>:sp<CR>:term<CR>

" Auto change directory to current dir
autocmd BufEnter * silent! lcd %:p:h

" using setting after save
autocmd BufWritePost $MYVIMRC source $MYVIMRC

" Compile function
noremap <LEADER>r :call CompileRunGcc()<CR>
func! CompileRunGcc()
	exec "w"
	if &filetype == 'c'
		exec "!g++ % -o %<"
		exec "!time ./%<"
	elseif &filetype == 'cpp'
		set splitbelow
		exec "!g++ -pthread -std=c++17 % -Wall -o %<"
		:sp
		:res -15
		:term ./%<
	elseif &filetype == 'java'
		exec "!javac %"
		exec "!time java %<"
	elseif &filetype == 'sh'
		:!time bash %
	elseif &filetype == 'python'
		set splitbelow
		:sp
		:term python3 %
	elseif &filetype == 'html'
		silent! exec "!chromium % &"
	elseif &filetype == 'markdown'
		exec "MarkdownPreview"
	elseif &filetype == 'tex'
		silent! exec "VimtexStop"
		silent! exec "VimtexCompile"
	elseif &filetype == 'go'
		set splitbelow
		:sp
		:term go run %
	endif
endfunc

" ===
" === Install Plugins with Vim-Plug
" ===

call plug#begin('~/.config/nvim/plugged')

" Pretty Dress
Plug 'vim-airline/vim-airline'  " statusline
Plug 'theniceboy/eleline.vim'   " another statusline
Plug 'vim-airline/vim-airline-themes'
" Plug 'bling/vim-bufferline'     " list buffer in command line
"Plug 'liuchengxu/space-vim-theme'
"Plug 'morhetz/gruvbox'
"Plug 'ayu-theme/ayu-vim'
"Plug 'rakr/vim-one'
"Plug 'mhartington/oceanic-next'
"Plug 'kristijanhusak/vim-hybrid-material'
Plug 'ajmwagar/vim-deus' " color with language support

Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
" Plug 'Xuyuanp/nerdtree-git-plugin'

Plug 'neoclide/coc.nvim', {'branch': 'release'} " Auto Complete
Plug 'mbbill/undotree' " Undo Tree
Plug 'mhinz/vim-startify' " welcom page

Plug 'rbgrouleff/bclose.vim' " buffer close

" Git
Plug 'mhinz/vim-signify'
Plug 'gisphm/vim-gitignore', { 'for': ['gitignore', 'vim-plug'] }
Plug 'fszymanski/fzf-gitignore', { 'do': ':UpdateRemotePlugins' }
Plug 'tpope/vim-fugitive' " gv dependency
Plug 'junegunn/gv.vim' " gv (normal) to show git log

Plug 'reedes/vim-wordy' "spelling check
Plug 'ron89/thesaurus_query.vim' " 同义词替换
Plug 'easymotion/vim-easymotion'

" Other useful utilities
Plug 'terryma/vim-multiple-cursors'
Plug 'tpope/vim-surround' " type ysks' to wrap the word with '' or type cs'` to change 'word' to `word`
Plug 'godlygeek/tabular' " alignment tool ;Tabularize /= to align the = 
Plug 'scrooloose/nerdcommenter' " in <space>cc to comment a line
Plug 'tmhedberg/SimpylFold'     " zo to fold
Plug 'AndrewRadev/switch.vim'   " gs to switch
Plug 'ryanoasis/vim-devicons'
Plug 'chrisbra/Colorizer' " Show colors with :ColorHighlight
Plug 'airblade/vim-rooter'
Plug 'tpope/vim-eunuch' " do stuff like :SudoWrite
Plug 'itchyny/calendar.vim'

" lsp base highlight for c++
Plug 'jackguo380/vim-lsp-cxx-highlight' " highlight based on ccls

" cpp-mode
Plug 'chxuan/cpp-mode' " generate definition from declaration
Plug 'tpope/vim-commentary' " comment out

call plug#end()

let g:colorizer_syntax = 1


" ===
" === Create a _machine_specific.vim file to adjust machine specific stuff, like python interpreter location
" ===
let has_machine_specific_file = 1
if empty(glob('~/.config/nvim/_machine_specific.vim'))
	let has_machine_specific_file = 0
	silent! exec "!cp ~/.config/nvim/default_configs/_machine_specific_default.vim ~/.config/nvim/_machine_specific.vim"
endif
source ~/.config/nvim/_machine_specific.vim


" ===
" === Dress up my vim
" ===
set termguicolors	" enable true colors support
let $NVIM_TUI_ENABLE_TRUE_COLOR=1
set background=dark
let ayucolor="mirage"
let g:oceanic_next_terminal_bold = 1
let g:oceanic_next_terminal_italic = 1
let g:one_allow_italics = 1

set list
"set listchars=eol:$,tab:>-,trail:~,extends:>,precedes:<


"color ayu
"color dracula
"color one
color deus


hi NonText ctermfg=gray guifg=grey10
"hi SpecialKey ctermfg=blue guifg=grey70

hi Normal ctermbg=NONE guibg=NONE " set background transparent
hi LineNr ctermbg=NONE guibg=NONE
hi SignColumn ctermbg=NONE guibg=NONE

set listchars=tab:\|\ ,

" ===================== Start of Plugin Settings =====================

" ===
" === Airline
" ===
let g:airline#extensions#tabline#enabled=1
let g:airline#extensions#tabline#buffer_nr_show=1
let g:airline#extensions#tabline#formatter ='unique_tail'

" ===
" === NERDTree
" ===
noremap tt :NERDTreeToggle<CR>
let NERDTreeMapOpenExpl = ""
let NERDTreeMapUpdir = "N"
let NERDTreeMapUpdirKeepOpen = "n"
let NERDTreeMapOpenSplit = ""
let NERDTreeMapOpenVSplit = "I"
let NERDTreeMapActivateNode = "i"
let NERDTreeMapOpenInTab = "o"
let NERDTreeMapOpenInTabSilent = "O"
let NERDTreeMapPreview = ""
let NERDTreeMapCloseDir = ""
let NERDTreeMapChangeRoot = "l"
let NERDTreeMapMenu = ","
let NERDTreeMapToggleHidden = "zh"
let NERDTreeShowLineNumbers=1 " enable line numbers
autocmd FileType nerdtree setlocal relativenumber " make sure relative line numbers are used

" ===========================================================================
" python
let g:python3_host_prog='/usr/local/bin/python3.7'

" === highlight
" ===vim-lsp-cxx-highlight
let g:lsp_cxx_hl_use_text_props=1
" ===========================================================================
" === coc
" ===
	let g:coc_global_extensions = ['coc-python', 'coc-git', 'coc-vimlsp', 
        \'coc-json', 'coc-marketplace', 'coc-snippets', 'coc-yank', 
        \'coc-highlight', 'coc-pairs', 'coc-lists', 'coc-gitignore',
        \'coc-omnisharp']

" Using CocList
nnoremap <silent> <leader>me :<C-u>CocList extensions<cr> " Manage extensions
nnoremap <silent> <leader>mc :<C-u>CocList commands<cr>   " Show commands
nnoremap <silent> <leader>mk :<C-u>CocList marketplace<cr>" Marketplace

"-----------------------------------------------------------------------------
" search tools
nnoremap <silent> <leader>fs :<C-u>CocList outline<cr>   " Find symbol in file
nnoremap <silent> <leader>fw :<C-u>CocList words<cr>     " Find word in file
nnoremap <silent> <leader>fd :<C-u>CocList -I symbols<cr>" Find sym in project
nnoremap <silent> <leader>ff :<C-u>CocList files<cr>     " Find files
nnoremap <silent> <leader>fe :<C-u>CocList diagnostics<cr> " Show diagnostics
nnoremap <silent> <leader>fg :<C-u>CocList grep<cr> " Show diagnostics

"-----------------------------------------------------------------------------
" git tools
nnoremap <silent> <leader>gs :<C-u>CocList gstatus<cr>
nnoremap <silent> <leader>gh :<C-u>CocList commits<cr>
nnoremap <silent> <leader>gH :GV<CR>                    " project hist
nnoremap <silent> <leader>gf :<C-u>CocList bcommits<cr> " buffer  hist
nnoremap <silent> <leader>gb :<C-u>CocList branches<cr>
nnoremap <silent> <leader>gv :<C-u>CocList gfiles<cr>

nnoremap <silent> <leader>n  :<C-u>CocNext<CR> " Default action for next item. 
nnoremap <silent> <leader>p  :<C-u>CocPrev<CR> " Default action for prev item.
nnoremap <silent> <leader>rr :<C-u>CocListResume<CR> " Resume latest coc list

"------------------------------------------------------------------------------
" list 
" nmap <silent> <leader>ll :<C-u>CocList<CR> " CocList 
" nmap <silent> <leader>b :<C-u>CocList --normal buffers<CR> "List buffers
nnoremap <silent> <leader>mu :<C-u>CocList mru<CR> " most recent used
nnoremap <silent> <leader>y	 :<C-u>CocList -A --normal yank<cr>


"------------------------------------------------------------------------------
" gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <leader> rn <Plug>(coc-rename)

" Use gh to show documentation in preview window
nnoremap <silent> gh :call <SID>show_documentation()<CR>
function! s:show_documentation()
	  if (index(['vim','help'], &filetype) >= 0)
			    execute 'h '.expand('<cword>')
					  else
							    call CocAction('doHover')
									  endif
									endfunction
"------------------------------------------------------------------------------
"autocomplete
" Use tab for trigger completion with characters ahead and navigate.
inoremap <silent><expr> <TAB>
    \ pumvisible() ? "\<C-n>" :
    \ <SID>check_back_space() ? "\<TAB>" :
    \ coc#refresh()
" inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"

function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
endfunction

inoremap <silent><expr> <c-space> coc#refresh()	" force autocomplete
" inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Remap for format selected region
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)
augroup mygroup
	autocmd!
	" Setup formatexpr specified filetype(s).
	autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end 

" Use ':Format' to format current buffer
command! -nargs=0 Format :call CocAction('format')

" ===========================================================================
" cpp-mode
nnoremap <silent><m-o>     :Switch<CR>

" easymotion
let g:EasyMotion_smartcase = 1
nmap ss <Plug>(easymotion-s2)

" vim-commentary
" set cpp comment tyle to //
autocmd FileType c,cpp,java setlocal commentstring=//\ %s

" ===
" === indentLine
" ===
let g:indentLine_char = '│'
let g:indentLine_color_term = 238
let g:indentLine_color_gui = '#333333'
silent! unmap <LEADER>ig
autocmd WinEnter * silent! unmap <LEADER>ig
let g:indentLine_fileTypeExclude = ['tex', 'markdown']

" ===================== End of Plugin Settings =====================

" Open the _machine_specific.vim file if it has just been created
if has_machine_specific_file == 0
	exec "e ~/.config/nvim/_machine_specific.vim"
endif

