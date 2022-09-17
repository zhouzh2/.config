" angryangus's VIMRC file
" Filename: .vimrc
" GitHub repository: https://github.com/zhouzh2/shelldotfiles
" Maintainer: Angus Chou

" OSX defaults {{{
set modelines=1 " just for convenience, use 0 for safer behavior CVE-2007-2438
set nocompatible " Use Vim defaults instead of 100% vi compatibility
set backspace=2 " more powerful backspacing

" Don't write backup file if vim is being called by "crontab -e"
au BufWrite /private/tmp/crontab._ set nowritebackup nobackup
" Don't write backup file if vim is being called by "chpass"
au BufWrite /private/etc/pw._ set nowritebackup nobackup

let skip_defaults_vim=1
" }}}

" VIMRC {{{
set exrc " look for custom .vimrc on each folder
set viminfo+=n~/.local/state/vim/viminfo
set directory=.,~/.cache/vim/swap// 
set backupdir=.,~/.local/share/vim/backup//
" if a directory ends in two path separators "//" 
" the swap file name will be built from the complete path to the file
" with all path separators replaced by percent '%' signs
set runtimepath+=~/.config/vim,~/.config/vim/after
set packpath+=~/.config/vim,~/.config/vim/after
" }}}

" Plugins {{{
" Automatic vim-plug installation -> Place the following code in your .vimrc before plug#begin() call
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.config/vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Call Plugins
call plug#begin('~/.config/vim/plugged')
Plug 'sheerun/vim-polyglot'
Plug 'vim-airline/vim-airline'
Plug 'ghifarit53/tokyonight-vim'
call plug#end()
" }}}

" Colors {{{
syntax on " 语法高亮
set termguicolors
let g:tokyonight_style = 'night' " available: night, storm
let g:tokyonight_enable_italic = 1
let g:airline_theme = "tokyonight"
colorscheme tokyonight " 设置颜色主题
"set guifont=Menlo:h16:cANSI " 设置字体
" }}}

" Tabs & Spaces {{{
set tabstop=4 " Tab 键的宽度
set softtabstop=4
set shiftwidth=4 " 统一缩进为 4
set noexpandtab " 不要用空格代替制表符
set smartindent " 智能对齐
set autoindent " 自动对齐
" }}}

" File & find {{{
set confirm " 在处理未保存或只读文件的时候，弹出确认
set path+=** " 启用模糊搜索文件
set hidden " 允许已修改buffer隐藏到内存
" set autowrite " 在切换 buffer 时自动保存当前文件
" }}}

" UI {{{
set guicursor=n-c-v:block-nCursor
set guicursor=i-ci:ver30-iCursor-blinkwait300-blinkon200-blinkoff150
highlight Cursor gui=reverse guifg=NONE guibg=NONE
autocmd InsertLeave _ se nocul
autocmd InsertEnter _ se cul
" 用浅色高亮当前行
set cursorline
" customize cursor
set nowrap " 关闭自动换行
set number relativenumber " 显示行号 显示相对行号
set history=50 " 历史纪录数
set hlsearch incsearch " 搜索逐字符高亮 逐字搜索
set cmdheight=2 " 命令行（在状态行）的高度，默认为 1,这里是 2
set colorcolumn=80 " 凸显80列
set signcolumn=yes " 显示debug断点栏，
set laststatus=2 " 总是显示状态行
set ruler " 在编辑过程中，在右下角显示光标位置的状态行
set showcmd " 在状态行显示目前所执行的命令，未完成的指令片段亦会显示出来
set showmatch " 高亮显示对应的括号
set matchtime=5 " 对应括号高亮的时间（单位是十分之一秒）
set linespace=2 " 字符间插入的像素行数目
set scrolloff=3 " 光标移动到 buffer 的顶部和底部时保持 3 行距离
" }}}

" Searching {{{
set ignorecase
set smartcase
" This setting makes search case-insensitive when all characters in the string
" being searched are lowercase. However, the search becomes case-sensitive if
" it contains any capital letters. This makes searching more convenient.
" }}}

" Folding {{{
set foldenable
set foldmethod=syntax
set foldcolumn=1
set foldlevelstart=10
set foldnestmax=10
" }}}

" Commands {{{
filetype plugin indent on
" 分为三部分命令：file on, file plugin on, file indent on.分别表示自动识别文件类型，用文件类型脚本，使用缩进定义文件。

set mouse+=a
" Enable mouse support. You should avoid relying on this too much, but it can
" sometimes be convenient.

set whichwrap=b,s,<,>,[,]
" 开启 Normal 或 Visual 模式下 Backspace 键，空格键，左方向键，右方向键，Insert 或 replace 模式下左方向键，右方向键跳行的功能。
set gdefault " 行内替换
set encoding=utf-8
set fileencodings=utf-8,ucs-bom,shift-jis,gb18030,gbk,gb2312,cp936,utf-16,big5,euc-jp,latin1
" 编码设置
set langmenu=zn_CN.UTF-8
set helplang=cn " 语言设置
set undodir=~/.local/state/vim/undodir
set undofile " 非易失性undo
set wildmenu " 增强模式中的命令行自动完成操作
set wildmode=longest,list,full " 启用自动完成 ctrl+n
" }}}

" Airline {{{
let g:airline#extensions#tabline#enabled = 1
" }}}

" 自定义的键映射 {{{
vnoremap $1 <esc>`>a)<esc>`<i(<esc>
vnoremap $2 <esc>`>a]<esc>`<i[<esc>
vnoremap $3 <esc>`>a}<esc>`<i{<esc>
vnoremap $$ <esc>`>a"<esc>`<i"<esc>
vnoremap $q <esc>`>a'<esc>`<i'<esc>
vnoremap $e <esc>`>a"<esc>`<i"<esc>
" 括号自动生成

nnoremap S :%s//g<Left><Left>

" 自定义短语 {{{
nnoremap ,html :-1read $HOME/.config/vim/snippets/examples.html<CR>3jwf>a
" }}}
" }}}

" 自定义自动化 {{{
autocmd VimEnter * silent exec "! echo -ne '\e[1 q'"
autocmd VimLeave * silent exec "! echo -ne '\e[5 q'"  " 修复zsh vim模式下vim不显示块光标的问题
" }}}

" vim:foldmethod=marker:foldlevel=0
