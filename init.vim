" __  ____   __  _   ___     _____ __  __ ____   ____ 
"|  \/  \ \ / / | \ | \ \   / /_ _|  \/  |  _ \ / ___|
"| |\/| |\ V /  |  \| |\ \ / / | || |\/| | |_) | |    
"| |  | | | |   | |\  | \ V /  | || |  | |  _ <| |___ 
"|_|  |_| |_|   |_| \_|  \_/  |___|_|  |_|_| \_\\____|
"
"------------------------------------------------------------------------------
"  install vim-plug at first download
"------------------------------------------------------------------------------
if empty(glob('~/.config/nvim/autoload/plug.vim'))
	silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
		\ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

"------------------------------------------------------------------------------
" necessary for vim
"------------------------------------------------------------------------------
set nocompatible
set encoding=UTF-8

"------------------------------------------------------------------------------
" basic settings
"------------------------------------------------------------------------------
set autochdir      " auto switch dirs
set number
set relativenumber
set cursorline
set expandtab      " use spaces to replace tab, use CTRL-V<Tab> to insert a tab
set tabstop=4
set shiftwidth=4   " space size when using << or >>
set softtabstop=4

set autoindent
set cindent " c stype indent
set cinoptions=g0,:0,N-s,(0) " affect indent c++ keyword like public
set smartindent  "Do smart autoindenting when starting a new line.  
set nobackup
set noswapfile
set autoread    " auto read when modified outside
set autowrite   " auto write when action like changing buffer
set confirm     " need confirm when action like :q

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

"------------------------------------------------------------------------------
" termimal control
"------------------------------------------------------------------------------
let g:neoterm_autoscroll = 1
autocmd TermOpen term://* startinsert
tnoremap <C-N> <C-\><C-N>

" auto change directory to current dir
autocmd BufEnter * silent! lcd %:p:h

"------------------------------------------------------------------------------
" basic mapping
"------------------------------------------------------------------------------
let mapleader=" "

nnoremap <c-s> :w<cr> " Save & quit

nnoremap <silent> <leader>rc :e ~/.config/nvim/init.vim<cr> " Open the vimrc file anytime
nnoremap <silent> <leader>st :Startify<cr>                  " Open Startify

inoremap jj <esc> 

nnoremap <silent> <leader><cr> :nohlsearch<cr> " Stop highlighting

nnoremap <silent> <leader>o za " Folding

" ===
" === Window management
" ===
" Use <space> + new arrow keys for moving the cursor around windows
nnoremap <silent> <leader>w <C-w>w
nnoremap <silent> <leader>k <C-w>k
nnoremap <silent> <leader>j <C-w>j
nnoremap <silent> <leader>h <C-w>h
nnoremap <silent> <leader>l <C-w>l

" split the screens
nnoremap <silent> <leader>sk :set nosplitbelow<CR>:split<CR>:set splitbelow<CR>
nnoremap <silent> <leader>sj :set splitbelow<CR>:split<CR>
nnoremap <silent> <leader>sh :set nosplitright<CR>:vsplit<CR>:set splitright<CR>
nnoremap <silent> <leader>sl :set splitright<CR>:vsplit<CR>
nnoremap <silent> <leader>sh <C-w>t<C-w>K " Place the two screens up and down
nnoremap <silent> <leader>sv <C-w>t<C-w>H " Place the two screens side by side

" Resize splits with arrow keys
nnoremap <up> :res +5<CR>
nnoremap <down> :res -5<CR>
nnoremap <left> :vertical resize-5<CR>
nnoremap <right> :vertical resize+5<CR>

" Rotate screens
nnoremap <silent> <leader>srh <C-w>b<C-w>K
nnoremap <silent> <leader>srv <C-w>b<C-w>H

"------------------------------------------------------------------------------
" tab control
"------------------------------------------------------------------------------
nnoremap <silent> <leader>tn :tabe<CR> " Create a new tab with tn
nnoremap <silent> <leader>tc :tabc<CR> " close tab
nnoremap <silent> <leader>to :tabo<CR>
noremap <silent><c-j> :-tabnext<cr>
noremap <silent><c-k> :+tabnext<cr>

"------------------------------------------------------------------------------
" buffer control
"------------------------------------------------------------------------------
noremap <C-L> :bn<CR>
noremap <C-H> :bp<CR>
noremap <C-k> :Bclose<CR>


noremap <LEADER>/ :set splitbelow<CR>:sp<CR>:term<CR>
" using setting after save
autocmd BufWritePost $MYVIMRC source $MYVIMRC


" Compile function
nnoremap <silent> <leader>r :call CompileRunGcc()
func! CompileRunGcc()
	exec "w"
	if &filetype == 'c'
		exec "!g++ % -o %<"
		exec "!time ./%<"
	elseif &filetype == 'cpp'
		set splitbelow
		exec "!g++ -pthread -mavx2 -O3 -std=c++17 % -Wall -o %<"
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
" Plug 'theniceboy/eleline.vim'   " another statusline
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
Plug 'liuchengxu/vista.vim'
" Plug 'Xuyuanp/nerdtree-git-plugin'

Plug 'neoclide/coc.nvim', {'branch': 'release'} " Auto Complete
Plug 'mbbill/undotree' " Undo Tree
Plug 'mhinz/vim-startify' " welcom page

Plug 'rbgrouleff/bclose.vim' " buffer close
Plug 'honza/vim-snippets'
Plug 'skywind3000/vim-terminal-help'
" Git
Plug 'mhinz/vim-signify'
Plug 'gisphm/vim-gitignore', { 'for': ['gitignore', 'vim-plug'] }
Plug 'fszymanski/fzf-gitignore', { 'do': ':UpdateRemotePlugins' }
Plug 'tpope/vim-fugitive' " gv dependency
Plug 'junegunn/gv.vim' " gv (normal) to show git log
Plug 'junegunn/fzf', {'do': { -> fzf#install() }}
Plug 'Junegunn/fzf.vim'

Plug 'reedes/vim-wordy' "spelling check
Plug 'ron89/thesaurus_query.vim' " 同义词替换
Plug 'easymotion/vim-easymotion'

" Other useful utilities
Plug 'terryma/vim-multiple-cursors'
Plug 'tpope/vim-surround' " type ysks' to wrap the word with '' or type cs'` to change 'word' to `word`
Plug 'godlygeek/tabular' " alignment tool ;Tabularize /= to align the = 
Plug 'junegunn/vim-easy-align'
Plug 'scrooloose/nerdcommenter' " in <space>cc to comment a line
Plug 'tmhedberg/SimpylFold'     " zo to fold
Plug 'AndrewRadev/switch.vim'   " gs to switch
Plug 'ryanoasis/vim-devicons'
Plug 'chrisbra/Colorizer' " Show colors with :ColorHighlight
Plug 'airblade/vim-rooter'
Plug 'tpope/vim-eunuch' " do stuff like :SudoWrite
Plug 'itchyny/calendar.vim'
" Plug 'kien/rainbow_parentheses.vim'

" lsp base highlight for c++
Plug 'jackguo380/vim-lsp-cxx-highlight' " highlight based on ccls
" Plug 'frazrepo/vim-rainbow'

" cpp-mode
Plug 'chxuan/cpp-mode' " generate definition from declaration
Plug 'tpope/vim-commentary' " comment out

call plug#end()


"------------------------------------------------------------------------------
" 
let g:colorizer_syntax = 1


" === Dress up my vim
set termguicolors	" enable true colors support
let $NVIM_TUI_ENABLE_TRUE_COLOR=1
set background=dark
let ayucolor="mirage"
let g:oceanic_next_terminal_bold = 1
let g:oceanic_next_terminal_italic = 1
let g:one_allow_italics = 1

set list
"set listchars=eol:$,tab:>-,trail:~,extends:>,precedes:<
set listchars=tab:\|\ ,

"color ayu 
"color dracula
"color one
color deus


hi NonText ctermfg=gray guifg=grey10
"hi SpecialKey ctermfg=blue guifg=grey70

hi Normal ctermbg=NONE guibg=NONE " set background transparent
hi LineNr ctermbg=NONE guibg=NONE
hi SignColumn ctermbg=NONE guibg=NONE


" ===================== Start of Plugin Settings =====================

" ===
" === Airline
" ===
let g:airline#extensions#tabline#enabled=1
let g:airline#extensions#tabline#buffer_nr_show=1
let g:airline#extensions#tabline#formatter ='unique_tail'
" if !exists('g:airline_symbols')
" let g:airline_symbols = {}
" endif
" let g:airline_left_sep = '▶'
" let g:airline_left_alt_sep = '❯'
" let g:airline_right_sep = '◀'
" let g:airline_right_alt_sep = '❮'
" let g:airline_symbols.linenr = '¶'
" let g:airline_symbols.branch = '⎇'

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
let g:python3_host_prog='/home/i512993/anaconda3/bin/python'
" === highlight
" ===vim-lsp-cxx-highlight
" let g:lsp_cxx_hl_use_text_props=1
let g:lsp_cxx_hl_syntax_priority=1

"------------------------------------------------------------------------------
" vim-rainbow 
"------------------------------------------------------------------------------
" let g:rainbow_active = 1
"------------------------------------------------------------------------------
" coc
"------------------------------------------------------------------------------
let g:coc_global_extensions = ['coc-python', 'coc-vimlsp', 
    \'coc-json', 'coc-marketplace', 'coc-snippets', 'coc-yank', 
    \'coc-highlight', 'coc-pairs', 'coc-lists', 'coc-gitignore',
    \'coc-omnisharp', 'coc-explorer', 'coc-tabnine', 'coc-translator',
    \'coc-cmake', 'coc-explorer', 'coc-floaterm' ]

" Using CocList
nnoremap <silent> <leader>me :<C-u>CocList extensions<cr> " Manage extensions
nnoremap <silent> <leader>mc :<C-u>CocList commands<cr>   " Show commands
nnoremap <silent> <leader>mk :<C-u>CocList marketplace<cr>" Marketplace

"-----------------------------------------------------------------------------
" search tools
nnoremap <silent> <leader>fs :<C-u>CocList -A outline<cr>   " Find symbol in file
nnoremap <silent> <leader>fw :<C-u>CocList -A words<cr>     " Find word in file
nnoremap <silent> <m-l>      :<C-u>CocList buffers<cr>      " List buffers
nnoremap <silent> <m-w>      :<C-u>CocList -I grep<cr>      " grep word

nnoremap <silent> <m-p>      :<C-u>CocList -A files<cr>     " Find files
nmap     <silent> <c-p>      :GFiles<CR>
nnoremap <silent> <leader>ps :<C-u>CocList  symbols<cr>" Find sym in project
nnoremap <silent> <leader>pe :<C-u>CocList -A diagnostics<cr> " Show diagnostics
nnoremap <silent> <leader>pg :<C-u>CocList -A grep<cr> " Show diagnostics

"-----------------------------------------------------------------------------
" git tools
nnoremap <silent> <leader>gs :<C-u>CocList gstatus<cr>
nnoremap <silent> <leader>gh :<C-u>CocList commits<cr>
nnoremap <silent> <leader>gH :GV<CR>                    " project hist
nnoremap <silent> <leader>gf :<C-u>CocList bcommits<cr> " buffer  hist
nnoremap <silent> <leader>gb :<C-u>CocList branches<cr>
nnoremap <silent> <leader>gv :<C-u>CocList gfiles<cr>

nnoremap <silent> <leader>n  :<C-u>CocNext<CR> " Default action for next item. 
" nnoremap <silent> <leader>p  :<C-u>CocPrev<CR> " Default action for prev item.
nnoremap <silent> <leader>rr :<C-u>CocListResume<CR> " Resume latest coc list

" bases
nn <silent> <leader>xb :call CocLocations('ccls','$ccls/inheritance')<cr>
" bases of up to 3 levels
nn <silent> <leader>xB :call CocLocations('ccls','$ccls/inheritance',{'levels':3})<cr>
" derived
nn <silent> <leader>xd :call CocLocations('ccls','$ccls/inheritance',{'derived':v:true})<cr>
" derived of up to 3 levels
nn <silent> <leader>xD :call CocLocations('ccls','$ccls/inheritance',{'derived':v:true,'levels':3})<cr>

" caller
nn <silent> <leader>xc :call CocLocations('ccls','$ccls/call')<cr>
" callee
nn <silent> <leader>xC :call CocLocations('ccls','$ccls/call',{'callee':v:true})<cr>"

"-----------------------------------------------------------------------------
" coc-translator
nmap  <leader>t :<C-u>CocCommand translator.popup<cr>


"------------------------------------------------------------------------------
" list 
" nmap <silent> <leader>ll :<C-u>CocList<CR> " CocList 
" nmap <silent> <leader>b :<C-u>CocList --normal buffers<CR> "List buffers
nnoremap <silent> <leader>mu :<C-u>CocList mru<CR> " most recent used
nnoremap <silent> <leader>y	 :<C-u>CocList -A --normal yank<cr>

nnoremap <silent> <leader>c :CopyCode<CR>
nnoremap <silent> <leader>p :PasteCode<CR>

"------------------------------------------------------------------------------
" gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <silent> <leader>rn <Plug>(coc-rename)

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
" inoremap <silent><expr> <TAB>
"     \ pumvisible() ? "\<C-n>" :
"     \ <SID>check_back_space() ? "\<TAB>" :
"     \ coc#refresh()
" " inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
" inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"

" function! s:check_back_space() abort
"     let col = col('.') - 1
"     return !col || getline('.')[col - 1]  =~# '\s'
" endfunction

inoremap <silent><expr> <c-space> coc#refresh()	" force autocomplete
" inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
" inoremap <silent> <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
inoremap <silent><expr> <cr> "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

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

" coc-snippets
inoremap <silent><expr> <TAB>
      \ pumvisible() ? coc#_select_confirm() :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

function! s:check_back_space() abort
      let col = col('.') - 1
        return !col || getline('.')[col - 1]  =~# '\s'
    endfunction
let g:coc_snippet_next = '<tab>'

" vista
function! NearestMethodOrFunction() abort
  return get(b:, 'vista_nearest_method_or_function', '')
  endfunction

set statusline+=%{NearestMethodOrFunction()}

" By default vista.vim never run if you don't call it explicitly.
"
" If you want to show the nearest function in your statusline automatically,
" you can add the following line to your vimrc 
autocmd VimEnter * call vista#RunForNearestMethodOrFunction()
let g:vista_icon_indent = ["╰▸ ", "├▸ "]
let g:vista_default_executive = 'coc'
let g:vista#renderer#enable_icon = 1
noremap T :Vista!!<CR>











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

