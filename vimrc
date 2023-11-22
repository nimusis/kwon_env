set runtimepath=~/.kwon_env/vim,$VIMRUNTIME

call plug#begin('~/.kwon_env/vim/plugged')

" Make sure you use single quotes

" SYNTAX HIGHLIGHT
Plug 'sheerun/vim-polyglot'

" COLOR SCHEME
Plug 'nimusis/Tomorrow-Night-Eighties.vim'

" FILE FINDER
Plug 'scrooloose/nerdtree'
"
" INTERFACE
Plug 'vim-airline/vim-airline' " airline
Plug 'vim-airline/vim-airline-themes'

" GIT
Plug 'airblade/vim-gitgutter'

Plug 'frazrepo/vim-rainbow'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'machakann/vim-highlightedyank'

call plug#end()

syntax on
filetype plugin indent on

let g:plug_timeout = 10000

let g:rainbow_active = 1

let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_start_level = 2
let g:indent_guides_guide_size = 1

let g:highlightedyank_highlight_duration = -1

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
"# 버퍼간 이동
"=====================================================================
"===  BUFFER : this concept is heavily inspired from
" http://bakyeono.net/post/2015-08-13-vim-tab-madness-translate.html
" 이 옵션은 버퍼를 수정한 직후 버퍼를 감춰지도록 한다.
" 이 방법으로 버퍼를 사용하려면 거의 필수다.
set hidden
" 버퍼 새로 열기
" 원래 이 단축키로 바인딩해 두었던 :tabnew를 대체한다.
nmap <leader>T :enew<cr>
" 다음 버퍼로 이동
nmap <tab> :bnext<CR>
" 이전 버퍼로 이동
nmap <leader><tab> :bprevious<CR>
" 현재 버퍼를 닫고 이전 버퍼로 이동
" 탭 닫기 단축키를 대체한다.
nmap <leader>bq :bp <BAR> bd #<CR>
" 모든 버퍼와 각 버퍼 상태 출력
nmap <leader>bl :ls<CR>

" Switch to File Buffer #
map ,1 :b!1<CR>
map ,2 :b!2<CR>
map ,3 :b!3<CR>
map ,4 :b!4<CR>
map ,5 :b!5<CR>
map ,6 :b!6<CR>
map ,7 :b!7<CR>
map ,8 :b!8<CR>
map ,9 :b!9<CR>
map ,0 :b!0<CR>

"=====================================================================
"# Function Key Map 설정
"=====================================================================

"=====  PageUP PageDown
map <PageUp> <C-U><C-U>
map <PageDowm> <C-D><C-D>

"===== Vim 내의 창 크기 조절
"nmap <s-h> <C-W><
"nmap <s-j> <C-W>-
"nmap <s-k> <C-W>+
"nmap <s-l> <C-W>>

"===== Vim 내에서 창 간 이동
nmap <c-h> <c-w>h
nmap <c-j> <c-w>j 
nmap <c-k> <c-w>k 
nmap <c-l> <c-w>l 

nnoremap <silent> <special> <F8> :NERDTreeToggle <Bar> if &filetype ==# 'nerdtree' <Bar> wincmd p <Bar> endif<CR>



"=====================================================================
"# Plugin airline 설정
"=====================================================================
let g:airline#extensions#tabline#enabled = 1              " vim-airline 버퍼 목록 켜기
let g:airline#extensions#tabline#fnamemod = ':t'          " vim-airline 버퍼 목록 파일명만 출력
let g:airline#extensions#tabline#buffer_nr_show = 1       " buffer number를 보여준다
let g:airline#extensions#tabline#buffer_idx_mode = 0      " 버퍼 index 는 숨김
let g:airline#extensions#tabline#buffer_nr_format = '%s:' " buffer number format

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
let g:NERDTreeQuitOnOpen=0 "파일 오픈하고 나면 닫히도록 설정.
let g:NERDTreeCaseSensitiveSort=1

" let g:NERDTreeShowFiles = 0 "0이면 파일을 보여주지 않고, 디렉토리만 보여줍니다.
" let g:NERDTreeWinPos = right "이렇게 설정하면 오른쪽에 NERDTree가 나타납니다.
" 이외에 더 자세한건 :help NERDTree
"nnoremap <Leader>d :NERDTreeToggle<CR>