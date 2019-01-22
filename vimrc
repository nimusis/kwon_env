set runtimepath=~/.kwon_env/vim,$VIMRUNTIME

call plug#begin('~/.kwon_env/vim/plugged')

" Make sure you use single quotes

" SYNTAX HIGHLIGHT
Plug 'justinmk/vim-syntax-extra'
Plug 'kshenoy/vim-signature' "Show marks

" COLOR SCHEME
Plug 'nimusis/Tomorrow-Night-Eighties.vim'

" FILE FINDER
Plug 'scrooloose/nerdtree'
Plug 'wesleyche/SrcExpl'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'tpope/vim-obsession'
Plug 'dhruvasagar/vim-prosession'
Plug 'gikmx/ctrlp-obsession' "Session navigator using vim-obsession/vim-prosession
"
" INTERFACE
Plug 'majutsushi/tagbar'
Plug 'mhinz/vim-startify'
Plug 'vim-airline/vim-airline' " airline
Plug 'vim-airline/vim-airline-themes'

" GIT
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'

" OTHER FEATURES
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

set t_kb=

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
"nmap <leader>; :bprevious<CR>
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
" 탭 이동
"map <tab> gt<CR>

"Tlist 실행
map <silent> <F9> :TagbarToggle<CR>

"=====  PageUP PageDown
map <PageUp> <C-U><C-U>
map <PageDowm> <C-D><C-D>

"===== Vim 내의 창 크기 조절
nmap <s-h> <C-W><
nmap <s-j> <C-W>-
nmap <s-k> <C-W>+
nmap <s-l> <C-W>>

"===== Vim 내에서 창 간 이동
nmap <c-h> <c-w>h
nmap <c-j> <c-w>j 
nmap <c-k> <c-w>k 
nmap <c-l> <c-w>l 

nnoremap <silent> <special> <F8> :NERDTreeToggle <Bar> if &filetype ==# 'nerdtree' <Bar> wincmd p <Bar> endif<CR>

"=====================================================================
"# ShowMarks 설정
"=====================================================================
nnoremap <leader>m :SignatureToggle<CR>
highlight SignatureMarkText guifg=White ctermfg=White


"=====================================================================
"# Plugin airline 설정
"=====================================================================
let g:airline#extensions#tabline#enabled = 1 "buffer list
let g:airline#extensions#tabline#fnamemod = ':t' "buffer file name print only
let g:airline_powerline_fonts = 1 "able powerline font. disable if font breaks. Or install powerline-patch

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
let g:NERDTreeQuitOnOpen=0 "파일 오픈하고 나면 닫히도록 설정.
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
  \ 'file': '\v\.(exe|so|dll|a|o|class|png|jpg)$'
\ }
let g:ctrlp_show_hidden = 0
let g:ctrlp_map = '<c-p>'
" 가장 가까운 .git 디렉토리를 cwd(현재 작업 디렉토리)로 사용
" 버전 관리를 사용하는 프로젝트를 할 때 꽤 적절하다.
" .svn, .hg, .bzr도 지원한다.
let g:ctrlp_working_path_mode = 'r'
" Too slow ctrlp: https://stackoverflow.com/questions/21346068/slow-performance-on-ctrlp-it-doesnt-work-to-ignore-some-folders
let g:ctrlp_cache_dir = $HOME . '/.cache/ctrlp'
if executable('ag')
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
endif
let g:ctrlp_clear_cache_on_exit = 0

" 단축키를 리더 키로 대체
nmap <leader>p :CtrlP<cr>
" 여러 모드를 위한 단축키
nmap <leader>bb :CtrlPBuffer<cr>
nmap <leader>bm :CtrlPMixed<cr>
nmap <leader>bs :CtrlPMRU<cr>

"====================================================
"= Source Explorer config
"====================================================
nnoremap <F5> :SrcExplToggle<CR>

" // Set the height of Source Explorer window
let g:SrcExpl_winHeight = 8
" // Set 100 ms for refreshing the Source Explorer
let g:SrcExpl_refreshTime = 100
" // Set "Enter" key to jump into the exact definition context
let g:SrcExpl_jumpKey = "<ENTER>"
" // Set "Space" key for back from the definition context
let g:SrcExpl_gobackKey = "<SPACE>"

" // In order to avoid conflicts, the Source Explorer should know what plugins
" // except itself are using buffers. And you need add their buffer names into
" // below listaccording to the command ":buffers!"
let g:SrcExpl_pluginList = [
				\ "__Tag_List__",
				\ "NERD_tree_1",
				\ "Source_Explorer",
				\ "[BufExplorer]"
				\ ]

" // Enable/Disable the local definition searching, and note that this is not
" // guaranteed to work, the Source Explorer doesn't check the syntax for now.
" // It only searches for a match with the keyword according to command 'gd'
let g:SrcExpl_searchLocalDef = 1
" // Do not let the Source Explorer update the tags file when opening
let g:SrcExpl_isUpdateTags = 0
" // Use 'Exuberant Ctags' with '--sort=foldcase -R .' or '-L cscope.files' to
" // create/update the tags file
let g:SrcExpl_updateTagsCmd = "ctags --sort=foldcase -R ."
" // Set "<F6>" key for updating the tags file artificially
let g:SrcExpl_updateTagsKey = "<F6>"

" // Set "<F3>" key for displaying the previous definition in the jump list
let g:SrcExpl_prevDefKey = "<F3>"
" // Set "<F4>" key for displaying the next definition in the jump list
let g:SrcExpl_nextDefKey = "<F4>"

