" File              : init.vim
" Author            : WangZi
" Date              : 14.04.2020
" Last Modified Date: 16.04.2020
" Last Modified By  : WangZi
"  __  __        __     _____ __  __ ____   ____
" |  \/  |_   _  \ \   / /_ _|  \/  |  _ \ / ___|
" | |\/| | | | |  \ \ / / | || |\/| | |_) | |
" | |  | | |_| |   \ V /  | || |  | |  _ <| |___
" |_|  |_|\__, |    \_/  |___|_|  |_|_| \_\\____|
"         |___/

" Todos
" - pylint reports error when doing `vim ~/Github/vim-calc/build-up/calc.py`
"   instead of doing `cd ~/Github/vim-calc/build-up` and then do `vim calc.py`
" - hotkey to switch between light theme and dark theme (in progress, still
"   some bugs
"
"
"   Testing
"fnew
"call nvim_win_float_set_pos(0,5,10,20,5)
"hi Floating guibg=#00044
"set withhl=Normal:Floating


" ===
" === Auto load for first time uses
" ===
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/willer94/vim-plug/master/plug.vim
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
"set autochdir
set noautochdir

set encoding=UTF-8

" ===
" === Editor behavior
" ===
" -------------line and cursor -------------
" set line number 
set number
" set relative line number 
set relativenumber
" set cursor line
set cursorline

" -------------tab and space-----------
" set tab to n (softtabstop) space
set expandtab
" tabstop only change view width
set tabstop=4
" autoindent width
set shiftwidth=4
set softtabstop=4

"--------------hidden characters----------
" show hidden characters
set list " set nolist
" set tab and trail characters
set listchars=tab:▸\ ,trail:▫

" cursor and buffer distance keep 5 line
set scrolloff=5

"------------time delay------------
" key code delays
set ttimeoutlen=0
" mapping delays, default is 1000
set timeoutlen=300

" recover states of last time open
set viewoptions=cursor,folds,slash,unix
" auto line breaks when exceed screen
set wrap " nowrap
" set testwidth
set tw=0
" no indent by expression
set indentexpr=

"-------------fold-----------
set foldmethod=indent "manual indent expr mark syntax
set foldlevel=99

" add comment prefix when o/O on command line and
" open new line in insert mode
set formatoptions-=tc

" open new buffer on right and below
set splitright
set splitbelow
" open mouse or set mouse-=a
set mouse=a

"-----------show ------------
set noshowmode
set showcmd

" set wildignore=log/**,node_modules/**,target/**,tmp/**,*.rbc
" 增强模式中的命令行自动完成操作
set wildmenu

"-----------search----------
" no highlight when open a new file
exec "nohlsearch"
" case
set ignorecase
set smartcase

" don't give |ins-completion-menu| messages.
set shortmess+=c

" "nosplit": Shows the effects of a command incrementally, as you type.
" "split"	 : Also shows partial off-screen results in a preview window.
set inccommand=split
set ttyfast "should make scrolling faster

" 不要在宏的中间重绘屏幕。使它们更快完成
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
"tnoremap <C-N> <C-\><C-N>:q<CR>


" ===
" === Basic Mappings
" ===
" Set <LEADER> as <SPACE>, ; as :
let mapleader=" "
"map ; :

" Save & quit
map Q :q<CR>
map S :w<CR>

" change workdir to pwd
nnoremap <silent> <LEADER>. : cd %:p:h<CR>

" Open the vimrc file anytime
map <LEADER>rc :e ~/.config/nvim/init.vim<CR>

" Open Startify
map <LEADER>st :Startify<CR>

" Undo operations

" Undo in Insert mode
inoremap <C-l> <C-u>

" 大写JKHL重复五次执行
"noremap J 5j
"noremap K 5k
"noremap H 5h
"noremap L 5l

" Copy to system clipboard
vnoremap Y :w !xclip -i -sel c<CR>

" Joining lines
"noremap H J

" Indentation
nnoremap < <<
nnoremap > >>

" Search
map <LEADER><CR> :nohlsearch<CR>
noremap = nzz
noremap - Nzz

" Adjacent duplicate words
map <LEADER>dw /\(\<\w\+\>\)\_s*\1

" Folding
map <silent> <LEADER>o za


" ===
" === Cursor Movement
" Use <space> + new arrow keys for moving the cursor around windows
map <LEADER>w <C-w>w
map <LEADER>k <C-w>k
map <LEADER>j <C-w>j
map <LEADER>h <C-w>h
map <LEADER>l <C-w>l
map <LEADER>wo <C-w>o

" Disabling the default s key
noremap s <nop>

" split the screens to up (horizontal), down (horizontal), left (vertical), right (vertical)
map sk :set nosplitbelow<CR>:split<CR>:set splitbelow<CR>
map sj :set splitbelow<CR>:split<CR>
map sh :set nosplitright<CR>:vsplit<CR>:set splitright<CR>
map sl :set splitright<CR>:vsplit<CR>

" Resize splits with arrow keys
map <up> :res +5<CR>
map <down> :res -5<CR>
map <left> :vertical resize-5<CR>
map <right> :vertical resize+5<CR>

" Place the two screens up and down
noremap sb <C-w>t<C-w>K
" Place the two screens side by side
noremap sv <C-w>t<C-w>H

" Rotate screens
noremap ssb <C-w>b<C-w>K
noremap ssv <C-w>b<C-w>H


" ===
" === Tab management
" ===
" Create a new tab with tu
map tu :tabe<CR>
" Move around tabs with tn and ti
map th :-tabnext<CR>
map tl :+tabnext<CR>
map td :tabclose<CR>
" Move the tabs with tmn and tmi
map tmn :-tabmove<CR>
map tmi :+tabmove<CR>


" ===
" === Bufer management
" ===
map <LEADER>bc :new<CR>
map <LEADER>bb :bp<CR>
map <LEADER>bn :bn<CR>
map <LEADER>bf :bfirst<CR>
map <LEADER>bl :blast<CR>
map <LEADER>bd :bdelete<CR>

command! BcloseOthers call <SID>BufCloseOthers()
function! <SID>BufCloseOthers()
   let l:currentBufNum   = bufnr("%")
   let l:alternateBufNum = bufnr("#")
   for i in range(1,bufnr("$"))
     if buflisted(i)
       if i!=l:currentBufNum
         execute("bdelete ".i)
       endif
     endif
   endfor
endfunction
map <LEADER>bdd :BcloseOthers<cr>


" sudo vim
map <LEADER>sudo :w !sudo tee %


" ===
" === My Snippets
" ===
source ~/.config/nvim/snippits.vim


" ===
" === Other useful stuff
" ===

" Opening a terminal window
map <LEADER>/ :set splitbelow<CR>:sp<CR>:term<CR>

" Press space twice to jump to the next '<++>' and edit it
map <LEADER><LEADER> <Esc>/<++><CR>:nohlsearch<CR>c4i

" Spelling Check with <space>sc
map <LEADER>sc :set spell!<CR>
noremap <C-s> ea<C-x>s
inoremap <C-s> <Esc>ea<C-x>s

" Press ` to change case (instead of ~)
"map ` ~

imap <C-c> <Esc>zza
nmap <C-c> zz

" Auto change directory to current dir
"autocmd BufEnter * silent! lcd %:p:h

" Call figlet
map tx :r !figlet

" Compile function
map <LEADER>r :call CompileRunGcc()<CR>
func! CompileRunGcc()
  exec "w"
  if &filetype == 'c'
    exec "!g++ % -o %<"
    exec "!time ./%<"
  elseif &filetype == 'cpp'
    exec "!g++ % -o %<"
    exec "!time ./%<"
elseif &filetype == 'java' 
    exec "!javac %" 
    exec "!java %<"
  elseif &filetype == 'sh'
    :!time bash %
  elseif &filetype == 'python'
    set splitright
    ":vsp
    ":vertical resize-10
    :sp
    :term python3 %
  elseif &filetype == 'html'
    exec "!chromium % &"
  elseif &filetype == 'markdown'
    exec "MarkdownPreview"
  endif
endfunc

" working on it...
map R :call CompileBuildrrr()<CR>
func! CompileBuildrrr()
  exec "w"
  if &filetype == 'vim'
    exec "source $MYVIMRC"
  elseif &filetype == 'markdown'
    exec "echo"
  endif
endfunc


" ===
" === Install Plugins with Vim-Plug
" ===

call plug#begin('~/.config/nvim/plugged')

" Pretty Dress
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'bling/vim-bufferline'
Plug 'liuchengxu/space-vim-theme'
Plug 'tomasr/molokai'
Plug 'ryanoasis/vim-devicons'

" File navigation
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'Xuyuanp/nerdtree-git-plugin'
"Plug 'ctrlpvim/ctrlp.vim', { 'on': 'CtrlP' }
"Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'francoiscabrol/ranger.vim'
Plug 'rbgrouleff/bclose.vim'

" Taglist
Plug 'majutsushi/tagbar', { 'on': 'TagbarOpenAutoClose' }

" Error checking
"Plug 'w0rp/ale'

" Auto Complete
"Plug 'Valloric/YouCompleteMe'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
"Plug 'neoclide/coc.nvim', {'do': 'yarn install --frozen-lockfile'}
" Plug 'davidhalter/jedi-vim'
"Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
"Plug 'ncm2/ncm2'
"Plug 'ncm2/ncm2-jedi'
"Plug 'ncm2/ncm2-github'
"Plug 'ncm2/ncm2-bufword'
"Plug 'ncm2/ncm2-path'
"Plug 'ncm2/ncm2-match-highlight'
"Plug 'ncm2/ncm2-markdown-su bscope'

" Undo Tree
Plug 'mbbill/undotree/'

" Other visual enhancement
Plug 'nathanaelkane/vim-indent-guides'
"Plug 'itchyny/vim-cursorword'
Plug 'tmhedberg/SimpylFold'
Plug 'Yggdroot/indentLine'
Plug 'mhinz/vim-startify'

" Git
"Plug 'rhysd/conflict-marker.vim'
"Plug 'tpope/vim-fugitive'
Plug 'mhinz/vim-signify'
Plug 'gisphm/vim-gitignore', { 'for': ['gitignore', 'vim-plug'] }

" HTML, CSS, JavaScript, PHP, JSON, etc.
Plug 'elzr/vim-json'
Plug 'hail2u/vim-css3-syntax'
Plug 'spf13/PIV', { 'for' :['php', 'vim-plug'] }
Plug 'gko/vim-coloresque', { 'for': ['vim-plug', 'php', 'html', 'javascript', 'css', 'less'] }
Plug 'pangloss/vim-javascript', { 'for' :['javascript', 'vim-plug'] }
Plug 'mattn/emmet-vim'

" Python
Plug 'vim-scripts/indentpython.vim', { 'for' :['python', 'vim-plug'] }
Plug 'numirias/semshi', { 'do': ':UpdateRemotePlugins' }
"Plug 'plytophogy/vim-virtualenv', { 'for' :['python', 'vim-plug'] }

" Markdown
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install_sync() }, 'for' :['markdown', 'vim-plug'] }
Plug 'tamlok/vim-markdown'
Plug 'joker1007/vim-markdown-quote-syntax'
Plug 'dhruvasagar/vim-table-mode', { 'on': 'TableModeToggle' }
Plug 'dkarter/bullets.vim', { 'for' :['markdown', 'vim-plug'] }

" For general writing
Plug 'reedes/vim-wordy'
Plug 'ron89/thesaurus_query.vim'

" Bookmarks
Plug 'kshenoy/vim-signature'

" Other useful utilities
Plug 'jiangmiao/auto-pairs'
Plug 'terryma/vim-multiple-cursors'
Plug 'tpope/vim-surround' " type ysks' to wrap the word with '' or type cs'` to change 'word' to `word`
Plug 'godlygeek/tabular' " type ;Tabularize /= to align the =
Plug 'gcmt/wildfire.vim' " in Visual mode, type i' to select all text in '', or type i) i] i} ip
Plug 'scrooloose/nerdcommenter' " in <space>cc to comment a line
Plug 'brooth/far.vim', { 'on': ['F', 'Far', 'Fardo'] }
Plug 'tmhedberg/SimpylFold'
"Plug 'vim-scripts/restore_view.vim'
Plug 'AndrewRadev/switch.vim' " gs to switch
Plug 'ryanoasis/vim-devicons'
Plug 'skywind3000/vim-terminal-help'
" header
Plug 'alpertuna/vim-header'

" Dependencies
Plug 'MarcWeber/vim-addon-mw-utils'
Plug 'kana/vim-textobj-user'
Plug 'roxma/nvim-yarp'

" sublime multi line cursors
Plug 'terryma/vim-multiple-cursors'

" latex
Plug 'vim-latex/vim-latex'
"Plug 'lervag/vimtex'
call plug#end()

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
set termguicolors     " enable true colors support
let g:space_vim_transp_bg = 1
"set background=dark
"colorscheme space_vim_theme
colorscheme molokai
let g:rehash256 = 1

" ===================== Start of Plugin Settings =====================

" ===
" === Airline
" ===
"let g:airline_theme='dracula'
let g:airline_theme='molokai'
let g:airline#extensions#coc#enabled = 0
let g:airline#extensions#branch#enabled = 0
let g:airline#extensions#tabline#enabled = 0
let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#show_buffers = 0
let g:airline_left_sep = ''
let g:airline_right_sep = ''
let g:airline_mode_map = {
      \ '__' : '-',
      \ 'n'  : 'Nor',
      \ 'i'  : 'Ins',
      \ 'R'  : 'Rpl',
      \ 'c'  : 'Cmd',
      \ 'v'  : 'Vis',
      \ 'V'  : 'Vli',
      \ '' : 'Vbl',
      \ 's'  : 'S',
      \ 'S'  : 'S',
      \ '' : 'S',
      \ }


" ===
" === NERDTree
" ===
map tt :NERDTreeToggle<CR>
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
let g:NERDTreeIndicatorMapCustom = {
    \ "Modified"  : "✹",
    \ "Staged"    : "✚",
    \ "Untracked" : "✭",
    \ "Renamed"   : "➜",
    \ "Unmerged"  : "═",
    \ "Deleted"   : "✖",
    \ "Dirty"     : "✗",
    \ "Clean"     : "✔︎",
    \ "Unknown"   : "?"
    \ }


" ===
" === NCM2
" ===
"inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
"inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
"inoremap <expr> <CR> (pumvisible() ? "\<c-y>\<cr>": "\<CR>")
"autocmd BufEnter * call ncm2#enable_for_buffer()
"set completeopt=noinsert,menuone,noselect
"let ncm2#popup_delay = 5
"let g:ncm2#matcher = "substrfuzzy"
"let g:ncm2_jedi#python_version = 3
"let g:ncm2#match_highlight = 'bold'
"let g:jedi#auto_initialization = 1
""let g:jedi#completion_enabled = 0
""let g:jedi#auto_vim_configuration = 0
""let g:jedi#smart_auto_mapping = 0
"let g:jedi#popup_on_dot = 1
"let g:jedi#completion_command = ""
"let g:jedi#show_call_signatures = "1"


" ===
" === coc
" ===
" fix the most annoying bug that coc has
"autocmd WinEnter * call timer_start(1000, { tid -> execute('unmap if')})
"silent! autocmd BufEnter * silent! call silent! timer_start(600, { tid -> execute('unmap if')})
"silent! autocmd WinEnter * silent! call silent! timer_start(600, { tid -> execute('unmap if')})
silent! au BufEnter * silent! unmap if
"au TextChangedI * GitGutter
" Installing plugins
let g:coc_global_extensions = ['coc-python', 'coc-vimlsp', 'coc-snippets', 'coc-pyright', 'coc-html', 'coc-json',
                             \ 'coc-css', 'coc-tsserver', 'coc-yank', 'coc-lists', 'coc-gitignore', 'coc-ccls', 
                             \ 'coc-cmake', 'coc-marketplace', 'coc-project']
" use <tab> for trigger completion and navigate to the next complete item
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction
inoremap <silent><expr> <Tab>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
" Useful commands
nnoremap <silent> <space>y  :<C-u>CocList -A --normal yank<cr>
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <LEADER>rn <Plug>(coc-rename)

"< Mappings using CoCList:
" Show Files
nnoremap <silent> <LEADER>lf  :<C-u>CocList files<cr>
" Show all diagnostics.
nnoremap <silent> <LEADER>la  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent> <LEADER>le  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent> <LEADER>lc  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent> <LEADER>lo  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent> <LEADER>ls  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <LEADER>lj  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <LEADER>lk  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent> <LEADER>lp  :<C-u>CocListResume<CR>

" ===
" === indentLine
" ===
let g:indentLine_char = '│'
let g:indentLine_color_term = 238
let g:indentLine_color_gui = '#333333'
let g:indentLine_fileTypeExclude = ['markdown', 'tex']
silent! unmap <LEADER>ig
autocmd WinEnter * silent! unmap <LEADER>ig


" ===
" === some error checking
" ===
" I ain't need no ale!


" ===
" === MarkdownPreview
" ===
let g:mkdp_auto_start = 0
let g:mkdp_auto_close = 1
let g:mkdp_refresh_slow = 0
let g:mkdp_command_for_global = 0
let g:mkdp_open_to_the_world = 0
let g:mkdp_open_ip = ''
let g:mkdp_browser = 'chromium'
let g:mkdp_echo_preview_url = 0
let g:mkdp_browserfunc = ''
let g:mkdp_preview_options = {
    \ 'mkit': {},
    \ 'katex': {},
    \ 'uml': {},
    \ 'maid': {},
    \ 'disable_sync_scroll': 0,
    \ 'sync_scroll_type': 'middle',
    \ 'hide_yaml_meta': 1
    \ }
let g:mkdp_markdown_css = ''
let g:mkdp_highlight_css = ''
let g:mkdp_port = ''
let g:mkdp_page_title = '「${name}」'


" ===
" === Python-syntax
" ===
let g:python_highlight_all = 1
" let g:python_slow_sync = 0
let g:semshi#self_to_attribute = 1

" ===
" === Taglist
" ===
map <silent> T :TagbarOpenAutoClose<CR>


" ===
" === vim-table-mode
" ===
map <LEADER>tm :TableModeToggle<CR>


" ===
" === FZF
" ===
map <LEADER>fz :FZF<CR>

" ===
" === ranger
" ===
let g:ranger_map_keys = 0
map <LEADER>ra :Ranger<CR>

" ===
" === vim-signature
" ===
let g:SignatureMap = {
        \ 'Leader'             :  "m",
        \ 'PlaceNextMark'      :  "m,",
        \ 'ToggleMarkAtLine'   :  "m.",
        \ 'PurgeMarksAtLine'   :  "dm-",
        \ 'DeleteMark'         :  "dm",
        \ 'PurgeMarks'         :  "dm/",
        \ 'PurgeMarkers'       :  "dm?",
        \ 'GotoNextLineAlpha'  :  "m<LEADER>",
        \ 'GotoPrevLineAlpha'  :  "",
        \ 'GotoNextSpotAlpha'  :  "m<LEADER>",
        \ 'GotoPrevSpotAlpha'  :  "",
        \ 'GotoNextLineByPos'  :  "",
        \ 'GotoPrevLineByPos'  :  "",
        \ 'GotoNextSpotByPos'  :  "mn",
        \ 'GotoPrevSpotByPos'  :  "mp",
        \ 'GotoNextMarker'     :  "",
        \ 'GotoPrevMarker'     :  "",
        \ 'GotoNextMarkerAny'  :  "",
        \ 'GotoPrevMarkerAny'  :  "",
        \ 'ListLocalMarks'     :  "m/",
        \ 'ListLocalMarkers'   :  "m?"
        \ }


" ===
" === Undotree
" ===
map L :UndotreeToggle<CR>
let g:undotree_DiffAutoOpen = 1
let g:undotree_SetFocusWhenToggle = 1
let g:undotree_ShortIndicators = 1


" ==
" == vim-multiple-cursor
" ==
let g:multi_cursor_use_default_mapping=0
let g:multi_cursor_start_word_key      = '<c-k>'
let g:multi_cursor_select_all_word_key = '<a-k>'
let g:multi_cursor_start_key           = 'g<c-k>'
let g:multi_cursor_select_all_key      = 'g<a-k>'
let g:multi_cursor_next_key            = '<c-k>'
let g:multi_cursor_prev_key            = '<c-p>'
let g:multi_cursor_skip_key            = '<c-x>'
let g:multi_cursor_quit_key            = '<Esc>'


" ==
" == thesaurus_query
" ==
map <LEADER>th :ThesaurusQueryLookupCurrentWord<CR>


" Startify
let g:startify_lists = [
      \ { 'type': 'files',     'header': ['   MRU']            },
      \ { 'type': 'bookmarks', 'header': ['   Bookmarks']      },
      \ { 'type': 'commands',  'header': ['   Commands']       },
      \ ]


" ===
" === Far.vim
" ===
nnoremap <silent> <LEADER>f :F  %<left><left>


" ===
" === emmet
" ===
let g:user_emmet_leader_key='<C-f>'


" ===
" === Bullets.vim
" ===
let g:bullets_set_mappings = 0


" ===
" === multi_cursor.vim
" ===
let g:multi_cursor_use_default_mapping=0

" Default mapping
let g:multi_cursor_start_word_key      = '<C-n>'
let g:multi_cursor_select_all_word_key = '<A-n>'
let g:multi_cursor_start_key           = 'g<C-n>'
let g:multi_cursor_select_all_key      = 'g<A-n>'
let g:multi_cursor_next_key            = '<C-n>'
let g:multi_cursor_prev_key            = '<C-p>'
let g:multi_cursor_skip_key            = '<C-x>'
let g:multi_cursor_quit_key            = '<Esc>'

" Header 
let g:header_auto_add_header = 0
let g:header_field_author = 'WangZi'
let g:header_field_author_email = 'wangzitju@163.com'
map <F4> :AddHeader<CR>

"" ===================== End of Plugin Settings =====================

" Open the _machine_specific.vim file if it has just been created
if has_machine_specific_file == 0
  exec "e ~/.config/nvim/_machine_specific.vim"
endif

"autocmd Filetype tex setlocal conceallevel=0
