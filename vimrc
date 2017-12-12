set runtimepath=~/.kwon_env/vim,$VIMRUNTIME

call plug#begin('~/.kwon_env/vim/plugged')

" Make sure you use single quotes

" SYNTAX HIGHLIGHT
Plug 'justinmk/vim-syntax-extra'
Plug 'exvim/ex-showmarks'
"Plug 'vim-scripts/ShowMarks'

" COLOR SCHEME
Plug 'nimusis/Tomorrow-Night-Eighties.vim'

" FILE FINDER
Plug 'scrooloose/nerdtree'
Plug 'jistr/vim-nerdtree-tabs'
Plug 'ctrlpvim/ctrlp.vim'
"
" INTERFACE
Plug 'majutsushi/tagbar'
Plug 'itchyny/lightline.vim'
Plug 'mhinz/vim-startify'

" GIT
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'

" OTHER FEATURES
Plug 'scrooloose/nerdcommenter'
Plug 'terryma/vim-expand-region'
Plug 'farmergreg/vim-lastplace'

" DEV
Plug 'skammer/vim-css-color'

function! BuildYCM(info)
  " info is a dictionary with 3 fields
  " - name:   name of the plugin
  " - status: 'installed', 'updated', or 'unchanged'
  " - force:  set on PlugInstall! or PlugUpdate!
  if a:info.status == 'installed' || a:info.force
    !./install.py
  endif
endfunction
Plug 'Valloric/YouCompleteMe', { 'do': function('BuildYCM') }

call plug#end()

syntax on
filetype plugin indent on

let g:plug_timeout = 10000

"=====================================================================
"# 이것 저것 설정
"=====================================================================
set nocompatible

set bs=2        " allow backspacing over everything in insert mode
set viminfo='20,\"50    " read/write a .viminfo file, don't store more
            " than 50 lines of registers
set history=50      " keep 50 lines of command line history

"=====================================================================
"# 시스템 기본 설정
"=====================================================================
set scrolloff=10 "스크롤 OFF 기능
set nobackup "백업 파일을 만들지 않기
set nowrapscan "검색할 때 문서의 끝에서 다시 처음으로 돌아가지 않게 하기
set ruler       "화면 우측 하단에 현재 커서의 위치 표시

" UTF-8, euc-kr 한글문서 그냥 열기
"if v:lang =~ "^ko"
"    set encoding=cp949
"    set fileencodings=utf-8,cp949
"    set guifontset=-*-*-medium-r-normal--16-*-*-*-*-*-*-*
"else
"    set encoding=utf-8
"    set fileencodings=utf-8,cp949
"endif

"=====================================================================
"# GUI 설정
"=====================================================================
set showmatch "(), {} 에 대해서 일치하는 괄호 보여줌
set nu " 줄 번호 보기
"set showmode "mode 보여주기
set noshowmode
set laststatus=2


"=====================================================================
"# 편집 설정
"=====================================================================
set autoindent " Preserve current indent on new lines
set cindent " set C style indent
set noet " 탭 -> 공백 변환 기능 (expandtab )
set tabstop=4 "Tab 눌렀을 때 8칸 대신 4칸 이동
set sts=4 " 들여쓰기 탭 간격(softtabstop)
set shiftwidth=4 " 들여쓰기를 할때 4칸 들여쓰기
set shiftround " Indent/outdent to nearest tabstop
set backspace=indent,eol,start " 백스페이스 강화

"=====================================================================
"# 검색 관련 설정
"=====================================================================
set ignorecase "매칭(탐색)등의 경우 대소문자를 구분하지 않는다.
set smartcase "ignorecase 설정후 이옵션값을 주면 대문자 입력시 대문자로 탐색한다.
set hlsearch " Highlight search terms
set incsearch " Find as you type search
"set gdefault " turn on 'g' flag

" Visual search mappings
function! s:VSetSearch()
    let temp=@@
    normal! gvy
    let @/='\V'.substitute(escape(@@, '\'), '\n', '\\n', 'g')
    let @@=temp
endfunction
vnoremap * :<C-U>call <SID>VSetSearch()<CR>//<CR>
vnoremap # :<C-U>call <SID>VSetSearch()<CR>??<CR>

" 하일라이트 on,off ,스페이스
nnoremap <Leader><Space> :set hlsearch!<CR>

"=====================================================================
"# 색깔, 폰트, 테마 등등
"=====================================================================
syntax on " Enable syntax
set background=dark " Set background
if !has('gui_running')
    set t_Co=256 " Use 256 colors
endif


" Unified color scheme (default: dark)
"let g:seoul256_background = 236
"colo seoul256
"colorscheme jellybeans
colorscheme Tomorrow-Night-Eighties

set cursorline " 현재 줄 색상
"
"" if has('multi_byte_ime') 
highlight Cursor guibg=green guifg=NONE " 영문 
highlight CursorIM guibg=Yellow guifg=NONE " 한글
" endif

"=====================================================================
"# Function Key Map 설정
"=====================================================================
" 탭 이동
map <tab> gt<CR>

"Tlist 실행
map <silent> <F9> :TagbarToggle<CR>

map <PageUp> <C-U><C-U>
map <PageDowm> <C-D><C-D>

nnoremap <F7> :NERDTreeFind<CR>
nnoremap <F8> :NERDTreeToggle<CR>

"=====================================================================
"# Plugin lightline 설정
"=====================================================================
"let g:lightline = { 'colorscheme': 'wombat', 'component': { 'readonly': '%{&readonly?"⭤":""}', } }
let g:lightline = {
\   'colorscheme': 'one',
\   'active': {
\     'left':[ [ 'mode', 'paste' ],
\              [ 'gitbranch', 'readonly', 'filename', 'modified' ]
\     ]
\   },
\   'component': {
\     'lineinfo': '¶ %3l:%-2v',
\   },
\   'component_function': {
\     'gitbranch': 'fugitive#head',
\   }
\ }
let g:lightline.separator = { 'left': '▶', 'right': '◀' }
"let g:lightline.subseparator = { 'left': " | ", 'right': " | " }
let g:lightline.subseparator = { 'left': " \uFE19", 'right': " \uFE19" }
let g:lightline.tabline = { 'left': [ ['tabs'] ], 'right': [ ['close'] ] }

"=====================================================================
"# Plugin ShowMarks 설정
"=====================================================================
let g:showmarks_enable = 1
let g:showmarks_include= "abcdefhijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
let g:showmarks_ignore_type= "hprmq"
let showmarks_hlline_lower = 1
let showmarks_hlline_upper = 0

"l : lowcase, u : upcase, o : other, m: multiple
"highlight ShowMarksHLl ctermfg=white ctermbg=blue
"highlight ShowMarksHLu ctermfg=white ctermbg=blue
"highlight ShowMarksHLo ctermfg=white ctermbg=blue
"highlight ShowMarksHLm ctermfg=white ctermbg=blue

" highlights 
" For marks a-z
hi clear ShowMarksHLl
hi ShowMarksHLl term=bold cterm=none ctermbg=LightBlue ctermfg=DarkBlue gui=none guibg=LightBlue
" For marks A-Z
hi clear ShowMarksHLu
hi ShowMarksHLu term=bold cterm=bold ctermbg=LightRed ctermfg=DarkRed gui=bold guibg=LightRed guifg=DarkRed
" For all other marks
hi clear ShowMarksHLo
hi ShowMarksHLo term=bold cterm=bold ctermbg=LightYellow ctermfg=DarkYellow gui=bold guibg=LightYellow guifg=DarkYellow
" For multiple marks on the same line.
hi clear ShowMarksHLm
hi ShowMarksHLm term=bold cterm=none ctermbg=LightBlue gui=none guibg=SlateBlue

"=====================================================================
"# Plugin TAGBAR 설정
"=====================================================================
let g:tagbar_left = 0 " 0이면 오른쪽, 1이면 왼쪽에 출력
let g:tagbar_width = 40 "기본폭은 40입니다. 모니터가 작으면 줄여야 겠죠 ㅠ
let g:tagbar_autoclose = 0 "선택하면 자동으로 닫히게 하려면 1을 할당해 주세요
let g:tagbar_autofocus = 1 "커서가 이동하면 자동으로 선언된 위치로 갑니다 (?)
let g:tagbar_foldlevel=2
let g:tagbar_autoshowtag=1
let g:tagbar_expand=1

"=====================================================================
"# Plugin NERDTREE 설정
"=====================================================================
let g:NERDChristmasTree = 1 "colorful 효과
let g:NERDTreeAutoCenter = 1 
let g:NERDTreeChDirMode = 1
let g:NERDTreeHighlightCursorline = 1 "현재 커서 위치를 하일라이팅합니다. 기본값은 1
let g:NERDTreeSortOrder=['Makefile', 'makefile', '\.c$', '\.h$', '*'] " *.c, *.h, 기타파일 순으로 정렬합니다.
let g:NERDTreeShowBookmarks=1
let g:NERDTreeBookmarksFile = '~/.NERDTreeBookmarks' "북마크 파일을 지정합니다. 이값은 디폴트 값이에요.
let g:NERDTreeIgnore = ['\.vim$', '\~$', '\.o$'] " *.vim파일과 끝이'~'로 끝나는 파일들은 보여주지 않습니다.
let g:lNERDTreeWinSize = 20 "NERDTree의 폭을 설정합니다.
let g:NERDTreeMinimalUI = 1 "NERDTree에서 (위에뜨는) help/bookmark 메세지를 보여주지 않습니다.
let g:NERDTreeShowHidden = 0 "숨김파일을 보여준다고 합니다.
let g:NERDTreeDirArrows=0
let g:NERDTreeShowLineNumbers=1 "라인을 보여줍니다
let g:NERDTreeQuitOnOpen=1 "파일 오픈하고 나면 닫히도록 설정.
let g:NERDTreeCaseSensitiveSort=1

" let g:NERDTreeShowFiles = 0 "0이면 파일을 보여주지 않고, 디렉토리만 보여줍니다.
" let g:NERDTreeWinPos = right "이렇게 설정하면 오른쪽에 NERDTree가 나타납니다.
" 이외에 더 자세한건 :help NERDTree
"nnoremap <Leader>d :NERDTreeToggle<CR>
"nnoremap <Leader>f :NERDTreeFind<CR>

"=====================================================================
"# Plugin YouCompleteMe 설정
"=====================================================================
let g:ycm_show_diagnostics_ui = 1
let g:ycm_enable_diagnostic_highlighting = 0
let g:ycm_min_num_of_chars_for_completion = 2
let g:ycm_auto_trigger = 1
let g:ycm_seed_identifiers_with_syntax = 1
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_confirm_extra_conf = 0
"let g:ycm_global_ycm_extra_conf = '~/.kwon_env/vim/.ycm_extra_conf.py'
"let g:ycm_confirm_extra_conf = 0
"To avoid conflict snippets
"let g:ycm_key_list_select_completion = ['<C-j>', '<Down>']
"let g:ycm_key_list_previous_completion = ['<C-k>', '<Up>']
"let g:ycm_autoclose_preview_window_after_completion = 1
"let g:ycm_warning_symbol = '>*'

"nnoremap <leader>g :YcmCompleter GoTo<CR>
"nnoremap <leader>gg :YcmCompleter GoToImprecise<CR>
"nnoremap <leader>d :YcmCompleter GoToDeclaration<CR>
"nnoremap <leader>t :YcmCompleter GetType<CR>
"nnoremap <leader>p :YcmCompleter GetParent<CR>

"let g:ycm_auto_trigger = 0    " 기본값은 1입니다. '.'이나 '->'을 받으면 자동으로 목록들을 출력해주죠.
"let g:ycm_collect_identifiers_from_tags_files = 1 " tags 파일을 사용합니다. 성능상 이익이 있는걸로 알고 있습니다. 
"let g:ycm_filetype_whitelist = { '*': 1 } " 화이트 리스트를 설정합니다. 
"let g:ycm_filetype_blacklist = { 'tagbar' : 1, 'qf' : 1, 'notes' : 1, } " 블랙 리스트를 설정합니다.

"=====================================================================
"# Plugin ctrlp 설정
"=====================================================================
"파일 인덱싱 속도를 느리게 하는 디렉토리 ignore
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\.git$\|public$\|log$\|tmp$\|vendor$',
  \ 'file': '\v\.(exe|so|dll|a|o|class)$'
\ }

