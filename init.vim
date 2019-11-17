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

set autochdir "auto switch dirs


" ===
" === Editor behavior
" ===
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

set list
set listchars=tab:▸\ ,trail:▫
set scrolloff=4
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
" Set <LEADER> as <SPACE>
let mapleader=" "

" Save & quit
noremap Q :q<CR>
noremap S :w<CR>

" Open the vimrc file anytime
noremap <LEADER>rc :e ~/.config/nvim/init.vim<CR>

" Open Startify
noremap <LEADER>st :Startify<CR>

" Map jj to ESC
inoremap jj <ESC>

" Search  stop highlighting search result
" type /<CR> to stop highlighting
noremap <LEADER><CR> :nohlsearch<CR>

" Folding
noremap <silent> <LEADER>o za

" ===
" === Window management
" ===
" Use <space> + new arrow keys for moving the cursor around windows
noremap <LEADER>w <C-w>w
noremap <LEADER>k <C-w>k
noremap <LEADER>j <C-w>j
noremap <LEADER>h <C-w>h
noremap <LEADER>l <C-w>l

" Disabling the default s key
noremap s <nop>

" split the screens to up (horizontal), down (horizontal), left (vertical), right (vertical)
noremap sk :set nosplitbelow<CR>:split<CR>:set splitbelow<CR>
noremap sj :set splitbelow<CR>:split<CR>
noremap sh :set nosplitright<CR>:vsplit<CR>:set splitright<CR>
noremap sl :set splitright<CR>:vsplit<CR>
" Place the two screens up and down
noremap sh <C-w>t<C-w>K
" Place the two screens side by side
noremap sv <C-w>t<C-w>H

" Resize splits with arrow keys
noremap <up> :res +5<CR>
noremap <down> :res -5<CR>
noremap <left> :vertical resize-5<CR>
noremap <right> :vertical resize+5<CR>

" Rotate screens
noremap srh <C-w>b<C-w>K
noremap srv <C-w>b<C-w>H

" ===
" === Tab management
" ===
" Create a new tab with tn
noremap tn :tabe<CR>

" close tab
noremap tc :tabc<CR>
noremap to :tabo<CR>

" Move around tabs 
noremap tl :+tabnext<CR>
noremap th :+tabnext<CR>

" ===
" === Buffer management
" ===
" Move around buffers
noremap <C-L> :bn<CR>
noremap <C-H> :bp<CR>
noremap <C-C> :Bclose<CR>

" ===
" === Markdown Settings
" ===
" Snippets
source ~/.config/nvim/snippits.vim
" auto spell
autocmd BufRead,BufNewFile *.md setlocal spell

" ===
" === Other useful stuff
" ===
" Opening a terminal window
noremap <LEADER>/ :set splitbelow<CR>:sp<CR>:term<CR>

" Press space twice to jump to the next '<++>' and edit it
noremap <LEADER><LEADER> <Esc>/<++><CR>:nohlsearch<CR>c4i

" Spelling Check with <space>sc
noremap <LEADER>sc :set spell!<CR>
noremap <C-x> ea<C-x>s
inoremap <C-x> <Esc>ea<C-x>s

" Auto change directory to current dir
autocmd BufEnter * silent! lcd %:p:h

" using setting after save
" autocmd BufWritePost $MYVIMRC source $MYVIMRC

" Compile function
noremap <LEADER>r :call CompileRunGcc()<CR>
func! CompileRunGcc()
	exec "w"
	if &filetype == 'c'
		exec "!g++ % -o %<"
		exec "!time ./%<"
	elseif &filetype == 'cpp'
		set splitbelow
		exec "!g++ -std=c++17 % -Wall -o %<"
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
Plug 'vim-airline/vim-airline'
Plug 'theniceboy/eleline.vim'
Plug 'vim-airline/vim-airline-themes'
Plug 'bling/vim-bufferline'
"Plug 'liuchengxu/space-vim-theme'
"Plug 'morhetz/gruvbox'
"Plug 'ayu-theme/ayu-vim'
"Plug 'rakr/vim-one'
"Plug 'mhartington/oceanic-next'
"Plug 'kristijanhusak/vim-hybrid-material'
Plug 'ajmwagar/vim-deus'

" File navigation
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
" Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'junegunn/fzf.vim'
"Plug 'junegunn/fzf', {'dir': '~/.fzf', 'do': './install --all'}
Plug 'junegunn/fzf'
Plug 'francoiscabrol/ranger.vim'

" Taglist
Plug 'liuchengxu/vista.vim'

" Error checking
"Plug 'w0rp/ale'

" Auto Complete
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Snippets
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

" Undo Tree
Plug 'mbbill/undotree'

" Other visual enhancement
"Plug 'tmhedberg/SimpylFold'
Plug 'mhinz/vim-startify'

" Git
Plug 'mhinz/vim-signify'
Plug 'gisphm/vim-gitignore', { 'for': ['gitignore', 'vim-plug'] }
Plug 'fszymanski/fzf-gitignore', { 'do': ':UpdateRemotePlugins' }
Plug 'tpope/vim-fugitive' " gv dependency
Plug 'junegunn/gv.vim' " gv (normal) to show git log

" HTML, CSS, JavaScript, PHP, JSON, etc.
Plug 'elzr/vim-json'
"Plug 'hail2u/vim-css3-syntax'
"Plug 'spf13/PIV', { 'for' :['php', 'vim-plug'] }
"Plug 'gko/vim-coloresque', { 'for': ['vim-plug', 'php', 'html', 'javascript', 'css', 'less'] }
"Plug 'pangloss/vim-javascript' ", { 'for' :['javascript', 'vim-plug'] }
"Plug 'jelera/vim-javascript-syntax'

" For general writing
Plug 'reedes/vim-wordy'
Plug 'ron89/thesaurus_query.vim'

" Bookmarks
Plug 'kshenoy/vim-signature'

" Find & Replace
Plug 'wsdjeg/FlyGrep.vim' " Ctrl+f (normal) to find file content
Plug 'brooth/far.vim', { 'on': ['F', 'Far', 'Fardo'] }
" Plug 'osyo-manga/vim-anzu'

" Other useful utilities
Plug 'jiangmiao/auto-pairs'
Plug 'terryma/vim-multiple-cursors'
Plug 'tpope/vim-surround' " type ysks' to wrap the word with '' or type cs'` to change 'word' to `word`
Plug 'godlygeek/tabular' " type ;Tabularize /= to align the =
Plug 'gcmt/wildfire.vim' " in Visual mode, type i' to select all text in '', or type i) i] i} ip
Plug 'scrooloose/nerdcommenter' " in <space>cc to comment a line
Plug 'tmhedberg/SimpylFold'
"Plug 'vim-scripts/restore_view.vim'
Plug 'AndrewRadev/switch.vim' " gs to switch
Plug 'ryanoasis/vim-devicons'
Plug 'chrisbra/Colorizer' " Show colors with :ColorHighlight
Plug 'airblade/vim-rooter'
Plug 'tpope/vim-eunuch' " do stuff like :SudoWrite
Plug 'tpope/vim-capslock'	" Ctrl+L (insert) to toggle capslock
Plug 'KabbAmine/zeavim.vim' " <LEADER>z to find doc
Plug 'itchyny/calendar.vim'

" Dependencies
Plug 'MarcWeber/vim-addon-mw-utils'
Plug 'kana/vim-textobj-user'
Plug 'roxma/nvim-yarp'
Plug 'rbgrouleff/bclose.vim' " For ranger.vim

" lsp base highlight for c++
Plug 'arakashic/chromatica.nvim' " highlight based on clang
Plug 'jackguo380/vim-lsp-cxx-highlight' " highlight based on ccls

" cpp-mode
Plug 'chxuan/cpp-mode'
Plug 'chxuan/tagbar'
Plug 'tpope/vim-commentary'

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

set listchars=tab:\|\ ,

nnoremap \d :call ChangeDress()<CR>
func! ChangeDress()
	if g:ayucolor == "mirage"
		let g:ayucolor = "light"
		color ayu
	else
		let g:ayucolor = "mirage"
		color ayu
	endif
endfunc

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


" ==
" == NERDTree-git
" ==
" let g:NERDTreeIndicatorMapCustom = {
" 		\ "Modified"	: "M",
" 		\ "Staged"		: "S",
" 		\ "Untracked" : "U",
" 		\ "Renamed"	 : "R",
" 		\ "Unmerged"	: "═",
" 		\ "Deleted"	 : "D",
" 		\ "Dirty"		 : "CR",
" 		\ "Clean"		 : "C",
" 		\ "Unknown"	 : "?"
" 		\ }


" ===========================================================================
" python
let g:python3_host_prog='/usr/local/bin/python3.7'


" ===========================================================================
" === highlight
" === chromatica.nvim 
"let g:chromatica#libclang_path='/home/I512993/Downloads/clang/lib'
"let g:chromatica#enable_at_startup=1
"let g:chromatica#global_args=['-isystem/home/I512993/Downloads/clang/include']

" === highlight
" ===vim-lsp-cxx-highlight
let g:lsp_cxx_hl_use_text_props=1
" ===========================================================================
" === coc
" ===
	let g:coc_global_extensions = ['coc-python', 'coc-git', 'coc-vimlsp', 'coc-json', 
		 \ 'coc-yank', 'coc-highlight', 'coc-lists', 'coc-gitignore', 'coc-omnisharp']
" Useful commands
nmap <silent> <space>y	:<C-u>CocList -A --normal yank<cr>
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <leader>rn <Plug>(coc-rename)
inoremap <silent><expr> <c-space> coc#refresh()	" force autocomplete
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<CR>"
" use <tab> for trigger completion and navigate to the next complete item
 function! s:check_back_space() abort
   let col = col('.') - 1
     return !col || getline('.')[col - 1]  =~ '\s'
     endfunction

     inoremap <silent><expr> <Tab>
           \ pumvisible() ? "\<C-n>" :
                 \ <SID>check_back_space() ? "\<Tab>" :
                       \ coc#refresh()

" Use gh to show documentation in preview window
nnoremap <silent> gh :call <SID>show_documentation()<CR>
function! s:show_documentation()
	  if (index(['vim','help'], &filetype) >= 0)
			    execute 'h '.expand('<cword>')
					  else
							    call CocAction('doHover')
									  endif
									endfunction

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

" ===========================================================================
" cpp-mode
"nnoremap <leader>c :CopyCode<CR>
"nnoremap <leader>v :PasteCode<CR>
nnoremap <silent><m-o>     :Switch<CR>
"nnoremap ==        :FormatFunParam<CR>

" vim-commentary
autocmd FileType c,cpp,java setlocal commentstring=//\ %s

" tagbar
let g:tagbar_width = 30
nnoremap <silent> <leader>t :TagbarToggle<CR>
" inoremap <silent> <leader>t <esc> :TagbarToggle<CR>

" ===
" === indentLine
" ===
let g:indentLine_char = '│'
let g:indentLine_color_term = 238
let g:indentLine_color_gui = '#333333'
silent! unmap <LEADER>ig
autocmd WinEnter * silent! unmap <LEADER>ig
let g:indentLine_fileTypeExclude = ['tex', 'markdown']

" ===
" === vim-table-mode
" ===
noremap <LEADER>tm :TableModeToggle<CR>

" ===
" === vim-signature
" ===
let g:SignatureMap = {
				\ 'Leader'						 :	"m",
				\ 'PlaceNextMark'			:	"m,",
				\ 'ToggleMarkAtLine'	 :	"m.",
				\ 'PurgeMarksAtLine'	 :	"dm",
				\ 'DeleteMark'				 :	"",
				\ 'PurgeMarks'				 :	"",
				\ 'PurgeMarkers'			 :	"",
				\ 'GotoNextLineAlpha'	:	"m<LEADER>",
				\ 'GotoPrevLineAlpha'	:	"",
				\ 'GotoNextSpotAlpha'	:	"m<LEADER>",
				\ 'GotoPrevSpotAlpha'	:	"",
				\ 'GotoNextLineByPos'	:	"",
				\ 'GotoPrevLineByPos'	:	"",
				\ 'GotoNextSpotByPos'	:	"",
				\ 'GotoPrevSpotByPos'	:	"",
				\ 'GotoNextMarker'		 :	"",
				\ 'GotoPrevMarker'		 :	"",
				\ 'GotoNextMarkerAny'	:	"",
				\ 'GotoPrevMarkerAny'	:	"",
				\ 'ListLocalMarks'		 :	"m/",
				\ 'ListLocalMarkers'	 :	"m?"
				\ }


" ===
" === Undotree
" ===
noremap <leader>u :UndotreeToggle<CR>
let g:undotree_DiffAutoOpen = 1
let g:undotree_SetFocusWhenToggle = 1
let g:undotree_ShortIndicators = 1


" Startify
let g:startify_lists = [
			\ { 'type': 'files',		 'header': ['	 MRU']	},
			\ { 'type': 'bookmarks', 'header': ['	 Bookmarks']},
			\ { 'type': 'commands',	'header': ['	 Commands']	},
			\ ]

" ===
" === emmet
" ===
let g:user_emmet_leader_key='<c-]'


" ===
" === Bullets.vim
" ===
let g:bullets_set_mappings = 0

" ===
" === Vista.vim
" ===
noremap <silent> T :Vista!!<CR>
noremap <silent> <C-t> :Vista finder<CR>
function! NearestMethodOrFunction() abort
	return get(b:, 'vista_nearest_method_or_function', '')
endfunction

set statusline+=%{NearestMethodOrFunction()}
autocmd VimEnter * call vista#RunForNearestMethodOrFunction()

" e.g., more compact: ["▸ ", ""]
let g:vista_icon_indent = ["╰─▸ ", "├─▸ "]
let g:vista_default_executive = 'coc'
" To enable fzf's preview window set g:vista_fzf_preview.
" The elements of g:vista_fzf_preview will be passed as arguments to fzf#vim#with_preview()
" For example:
let g:vista_fzf_preview = ['right:50%']


" ===
" === Ranger.vim
" ===
nnoremap R :Ranger<CR>

" ===
" === Ultisnips
" ===
" let g:tex_flavor = "latex"
inoremap <c-n> <nop>
let g:UltiSnipsExpandTrigger="<c-e>"
let g:UltiSnipsJumpForwardTrigger="<c-e>"
let g:UltiSnipsJumpBackwardTrigger="<c-n>"

" ===
" === FlyGrep
" ===
nnoremap <c-f> :FlyGrep<CR>

" ===
" === GV
" ===
nnoremap <LEADER>gv :GV<CR>


" ===================== End of Plugin Settings =====================

" Open the _machine_specific.vim file if it has just been created
if has_machine_specific_file == 0
	exec "e ~/.config/nvim/_machine_specific.vim"
endif

