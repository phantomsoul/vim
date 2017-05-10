source $VIMRUNTIME/vimrc_example.vim
source $VIMRUNTIME/mswin.vim
behave mswin

colorscheme candystripe

set diffexpr=MyDiff()
function MyDiff()
  let opt = '-a --binary '
  if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
  if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
  let arg1 = v:fname_in
  if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
  let arg2 = v:fname_new
  if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
  let arg3 = v:fname_out
  if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
  if $VIMRUNTIME =~ ' '
    if &sh =~ '\<cmd'
      if empty(&shellxquote)
        let l:shxq_sav = ''
        set shellxquote&
      endif
      let cmd = '"' . $VIMRUNTIME . '\diff"'
    else
      let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
    endif
  else
    let cmd = $VIMRUNTIME . '\diff'
  endif
  silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3
  if exists('l:shxq_sav')
    let &shellxquote=l:shxq_sav
  endif
endfunction

" -------------------------------------------------------以上为原有配置end----------------------------------------------------------
" -------------------------------------------------------Vundle管理插件----------------------------------------------------------
set nocompatible              " be iMproved  
filetype off                  " required!  
  
set rtp+=~/.vim/bundle/vundle/  
call vundle#rc()  
  
" let Vundle manage Vundle  
" required!   
Bundle 'gmarik/vundle'  
  
" 可以通过以下四种方式指定插件的来源  
" a) 指定Github中vim-scripts仓库中的插件，直接指定插件名称即可，插件明中的空格使用“-”代替。  
Bundle 'L9'  
  
" b) 指定Github中其他用户仓库的插件，使用“用户名/插件名称”的方式指定  
Bundle 'tpope/vim-fugitive'  
Bundle 'Lokaltog/vim-easymotion'  
Bundle 'rstacruz/sparkup', {'rtp': 'vim/'}  
Bundle 'tpope/vim-rails.git'  
  
" c) 指定非Github的Git仓库的插件，需要使用git地址  
"Bundle 'git://git.wincent.com/command-t.git'  
  
" d) 指定本地Git仓库中的插件  
"Bundle 'file:///Users/gmarik/path/to/plugin'  
  
filetype plugin indent on     " required! 
" -------------------------------------------------------END----------------------------------------------------------

" -------------------------------------------------------VIM基本配置----------------------------------------------------------

set guifont=Monaco:h10             " 设置字体和加粗
set cul                            " 高亮光标所在行
set go=                            " 不要图形按钮
set ruler                          " 显示标尺
set showcmd                        " 输入的命令显示出来，看的清楚些
set scrolloff=3                    " 光标移动到buffer的顶部和底部时保持3行距离
set laststatus=2                   " 启动显示状态行(1),总是显示状态行(2)
set foldenable                     " 允许折叠
set foldmethod=manual              " 手动折叠
set tabstop=4                      " Tab键的宽度
set softtabstop=4                  " 统一缩进为2
set shiftwidth=4                   " 统一缩进为2
set expandtab                      " 使用空格代替制表符
set smarttab			   " 在行和段开始处使用制表符
set number                         " 显示行号
set history=1000                   " 历史记录数
set noeb                           " 这样当错误发生的时候将不会发出 bi 的一声
set vb                             " 命令（其中 vb 是 visualbell 的缩写），代替 bell 的将是屏幕的闪烁。
set confirm                        " 在处理未保存或只读文件的时候，弹出确认
set wildmenu                       " 增强模式中的命令行自动完成操作
set backspace=2                    " 使回格键（backspace）正常处理indent, eol, start等
set report=0                       " 通过使用: commands命令，告诉我们文件的哪一行被改变过
set showmatch                      " 高亮显示匹配的括号
set matchtime=5                    " 匹配括号高亮的时间（单位是十分之一秒

set fileencodings=ucs-bom,utf-8,gbk,cp936,gb2312,big5,euc-jp,euc-kr,latin1                                      "gvim打开支持编码的文件
set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [POS=%l,%v][%p%%]\ %{strftime(\"%d/%m/%y\ -\ %H:%M\")}   "状态行显示的内容

" set nocursorline                 " 不高亮当前行
" set linespace=5                  " 设置行间距
" set shortmess=atI                " 启动的时候不显示那个援助乌干达儿童的提示
" set whichwrap+=<,>,h,l           " 允许backspace和光标键跨越行边界(不建议)
" set ignorecase                   " 搜索忽略大小写

" ====显示中文帮助====
if version >= 603
set helplang=cn
set encoding=utf-8
endif
" ====================
" ====自动缩进====
set autoindent
set cindent
" ====================
" ===搜索逐字符高亮
set hlsearch
set incsearch

let mapleader=',' "设置默认leader为，

"禁止生成临时文件
set nobackup
set noswapfile

" -------------------------------------------------------END----------------------------------------------------------

" -------------------------------------------------------PHP配置------------------------------------------------------
" PHP函数提示 
au FileType php call PHPFuncList()
function PHPFuncList()
    set dictionary-=~/.vim/php_funclist.txt dictionary+=~/.vim/php_funclist.txt
    set complete-=k complete+=k
endfunction
function! PhpSyntaxOverride()
  hi! def link phpDocTags  phpDefine
  hi! def link phpDocParam phpType
endfunction

augroup phpSyntaxOverride
  autocmd!
  autocmd FileType php call PhpSyntaxOverride()
augroup END

" -------------------------------------------------------END----------------------------------------------------------

" -------------------------------------------------------插件安装包---------------------------------------------------

" #########侧边目录树插件####
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
map <leader>t :NERDTreeToggle<CR>
Plugin 'scrooloose/nerdtree'                      " 侧边目录树插件
" 关闭NERDTree快捷键
" map <leader>t :NERDTreeToggle<CR>
map <C-n> :NERDTreeToggle<CR>

" 显示行号
let NERDTreeShowLineNumbers=1
let NERDTreeAutoCenter=1
" 是否显示隐藏文件
let NERDTreeShowHidden=1
" 设置宽度
let NERDTreeWinSize=30
" 在终端启动vim时，共享NERDTree
let g:nerdtree_tabs_open_on_console_startup=1
" 忽略一下文件的显示
let NERDTreeIgnore=['\.pyc','\~$','\.swp']
" 显示书签列表
let NERDTreeShowBookmarks=1

Plugin 'Xuyuanp/nerdtree-git-plugin'              " 侧边目录树显示git信息插件

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

" #########END################

Plugin 'kien/ctrlp.vim'                           "快速搜索文件+导航

" let g:ctrlp_map = '<leader>p'
let g:ctrlp_cmd = 'CtrlP'
map <leader>f :CtrlPMRU<CR>
let g:ctrlp_custom_ignore = {
    \ 'dir':  '\v[\/]\.(git|hg|svn|rvm)$',
    \ 'file': '\v\.(exe|so|dll|zip|tar|tar.gz|pyc)$',
    \ }
let g:ctrlp_working_path_mode=0
let g:ctrlp_match_window_bottom=1
let g:ctrlp_max_height=15
let g:ctrlp_match_window_reversed=0
let g:ctrlp_mruf_max=500
let g:ctrlp_follow_symlinks=1
" #########END################

Plugin 'ggVGc/vim-fuzzysearch'                   "模糊查找功能

Plugin 'bling/vim-airline'                       "状态栏美化
"这个是安装字体后 必须设置此项" 
let g:airline_powerline_fonts = 1   

 "打开tabline功能,方便查看Buffer和切换，这个功能比较不错"
 "我还省去了minibufexpl插件，因为我习惯在1个Tab下用多个buffer"
 let g:airline#extensions#tabline#enabled = 1
 let g:airline#extensions#tabline#buffer_nr_show = 1

 "设置切换Buffer快捷键"
 nnoremap <C-N> :bn<CR>
 nnoremap <C-P> :bp<CR>

 " 关闭状态显示空白符号计数,这个对我用处不大"
 let g:airline#extensions#whitespace#enabled = 0
 let g:airline#extensions#whitespace#symbol = '!'
" #########END################
Plugin 'gorodinskiy/vim-coloresque'              "高亮显示文档中颜色代码

Plugin 'Valloric/MatchTagAlways'                 "高亮显示匹配标签

Plugin 'alvan/vim-closetag'                      "自动关闭html， xml标签
" filenames like *.xml, *.html, *.xhtml, ...
let g:closetag_filenames = "*.html,*.xhtml,*.phtml"

Plugin 'dyng/ctrlsf.vim'                         "仿sublime全局查找
let g:ctrlsf_auto_close = 0
let g:ctrlsf_case_sensitive = 'no'
let g:ctrlsf_context = '-B 5 -A 3'
let g:ctrlsf_default_root = 'project'
let g:ctrlsf_default_view_mode = 'compact'
let g:ctrlsf_extra_backend_args = {
    \ 'pt': '--home-ptignore'
    \ }
let g:ctrlsf_mapping = {
    \ "next": "n",
    \ "prev": "N",
    \ }
let g:ctrlsf_populate_qflist = 1
let g:ctrlsf_regex_pattern = 1
let g:ctrlsf_position = 'bottom'
let g:ctrlsf_winsize = '30%'
" or
let g:ctrlsf_winsize = '100'

Plugin 'Raimondi/delimitMate'            "自动关闭' “ { <

Plugin 'mattn/emmet-vim'                 "快速编写html

Plugin 'tmhedberg/matchit'               " html标签对跳转 %跳

Plugin 'Yggdroot/indentLine'             " 缩进对其插件

Plugin 'honza/vim-snippets'              "代码段提示

Plugin 'terryma/vim-multiple-cursors'    ",n  开始选择
let g:multi_cursor_use_default_mapping=0
" Default mapping
let g:multi_cursor_next_key='<C-m>'
let g:multi_cursor_prev_key='<C-p>'
let g:multi_cursor_skip_key='<C-x>'
let g:multi_cursor_quit_key='<Esc>'
let g:multi_cursor_start_key='<C-n>'
let g:multi_cursor_start_word_key='g<C-n>'

Plugin 'editorconfig/editorconfig-vim'   "统一的代码格式

"VIM快速注释工具
let g:DoxygenToolkit_commentType="C++" 
let g:DoxygenToolkit_briefTag_pre="@Synopsis  " 
let g:DoxygenToolkit_paramTag_pre="@Param " 
let g:DoxygenToolkit_returnTag="@Returns   " 
let g:DoxygenToolkit_blockHeader="--------------------------------------------------------------------------" 
let g:DoxygenToolkit_blockFooter="----------------------------------------------------------------------------" 
let g:DoxygenToolkit_authorName="Mathias Lorente" 
let g:DoxygenToolkit_licenseTag="My own license"


" -------------------------------------------------------END----------------------------------------------------------

" ---------------------------------------------------normal模式下配置快捷键-------------------------------------------

:nmap <silent> <F9> <ESC>:Tlist<RETURN>
" shift tab pages
map <S-Left> :tabp<CR>
map <S-Right> :tabn<CR>
map! <C-Z> <Esc>zzi
map <C-A> ggVG$"+y
map <F12> gg=G
map <C-w> <C-w>w
imap <C-t> <C-q><TAB>
" 选中状态下 Ctrl+c 复制
imap <C-v> <Esc>"*pa
imap <leader>a <Esc>^i
imap <leader>e <Esc>$a
imap [[ {<cr><Esc>O<TAB>
vmap <C-c> "+y
"set clipboard=unnamed
"去空行  
nnoremap <F2> :g/^\s*$/d<CR> 
nmap <M-j> mz:m+<cr>`z
nmap <M-k> mz:m-2<cr>`z
vmap <M-j> :m'>+<cr>`<my`>mzgv`yo`z
vmap <M-k> :m'<-2<cr>`>my`<mzgv`yo`z
"这段代码实现的效果是在普通模式 或可视模式下选择一段代码，同时按[Alt]+[j] 或[Alt]+[k] 可控制代码向上、向下移。

"---------------------------------------------------------------END------------------------------------------------

"-----------------------------------insert模式下快捷键操作-----------------------
inoremap <C-b> <Left>
inoremap <C-j> <Down>
inoremap <C-k> <Up>
inoremap <C-l> <Right>
"------------------------------------------END------------------------------------

"-----------------------------------输入自动补全----------------------------------

:inoremap ( ()<ESC>i
:inoremap ) <c-r>=ClosePair(')')<CR>
:inoremap { {<CR>}<ESC>O
:inoremap } <c-r>=ClosePair('}')<CR>
:inoremap [ []<ESC>i
:inoremap ] <c-r>=ClosePair(']')<CR>
:inoremap " ""<ESC>i
:inoremap ' ''<ESC>i
function! ClosePair(char)
if getline('.')[col('.') - 1] == a:char
return "\<Right>"
else
return a:char
endif
endfunction
filetype plugin indent on 
"打开文件类型检测, 加了这句才可以用智能补全
set completeopt=longest,menu

"---------------------------------------END--------------------------------------

