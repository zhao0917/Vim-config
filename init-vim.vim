"""-------------------------------------------------------
"这是vim 一些特性的设置和 按键绑定的设置
""-------------------------------------------------------

""-------------------------------------------------------
"在vim中 “$”——访问环境变量；
"“&”——访问 Vim 选项,也就是内部变量;
"“@”——访问寄存器。
":reg name  查看寄存器的内容 name省略则查看所有寄存器

"$HOME是环境变量中的home，$vim和$VIMRUNTIME是vim提供的
"可以在vim neovim中通过 ：echo $home 这样的方式来看它们的值
"在vim中 通过 :ver 查看开启的特性和 环境变量预设值
"也可以在 vim中使用  :echo has('python3') 之类查看开启的特性，
"结果为1表示开启特性，
""-------------------------------------------------------
let mapleader=","

"gui "{{{
if has('gui_running')
    set go=aAce  " remove toolbar
    "set transparency=30
    ""set guifont=Monaco:h12:cANSI
    set guifont=Consolas:h14:cANSI
    set guifontwide=YaHei_Mono:h13
    set showtabline=2
    set columns=140
    set lines=40
endif "}}}

""""""""""""""""""""""
""下面是一些自定义的设置

"粘贴模式--插入时候是否有缩进<F9>
set pastetoggle=<F9>

" colorscheme. {{{
syntax enable
set background=dark
if g:os_windows
    colo solarized8
elseif g:os_linux
		if &term == "screen"
		set t_Co=256
		" colo molokai
		colo solarized
	else
		set termguicolors
		colo solarized8
	endif
endif "}}}


"菜单乱码 "{{{
if g:os_windows
    if (has('nvim') != 1)  "vim下使用，nvim下不启用
        source $VIMRUNTIME/delmenu.vim
        source $VIMRUNTIME/menu.vim
    endif
endif "}}}

set noimdisable
set showcmd "显示输入的命令
set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [POS=%l,%v][%p%%]\ %{strftime(\"%d/%m/%y\ -\ %H:%M\")}   "状态行显示的内容


" 设置编码 {{{
set encoding=utf-8
set laststatus=2
" 设置文件编码
set fenc=utf-8
" 设置文件编码检测类型及支持格式
set fencs=utf-8,ucs-bom,gb18030,gbk,gb2312,cp936 "}}}

"Nvim set to use clipboard of system {{{
"nvim不知道为何系统截切版不能用
"然后照着help clipboard 中格式设置了下
"设置如下，可以使用了，根据说明，剪切板貌似还支持函数，对vimscript 不熟悉
"就不尝试了,win32yank是nvim的在windows下的插件
"linux下根据help
"""-------------------------------------------------------
if has('nvim')
    if g:os_windows
        let g:clipbord = {
                \   'name': 'myClipboard',
                \   'copy':{
                \       '+': 'win32yank -i',
                \       '*': 'win32yank -i',
                \   },
                \   'paste': {
                \       '+': 'win32yank -o',
                \       '*': 'win32yank -o',
                \   },
                \   'cache_enabled':1,
                \ }
    endif
endif   "}}}

"set number "显示行号
"set rnu    "显示相对行号
set backspace=indent,eol,start

set hlsearch "高亮搜索结果
"取消搜索高亮
noremap <leader>/ :nohl<cr>
set ic "忽略大小写查找

" Tab 缩进空格数 {{{
set shiftwidth=4
set softtabstop=4
set tabstop=4
" 自动缩进
set autoindent
set cindent
set expandtab  "}}}


"折叠方式foldmethod "{{{
""set foldmethod=indent
" 打开文件默认不折叠
""set foldlevelstart=99
set foldenable	"允许折叠
set foldmethod=manual	"手动创建折叠
set fdm=marker
"如果没有设置 foldmethod=manual 请去掉下面两行的注释
"au BufWinLeave * silent mkview
"au BufWinEnter * silent loadview "}}}

" ---------- 自定义按键映射 ----------
" 编辑模式下快速移动 {{{
inoremap <leader>o <esc>o
inoremap <leader>O <esc>O

inoremap <leader>jj <esc>

inoremap <leader>I <esc>I
inoremap <leader>A <esc>A
""插入模式下删除上一行，并添加新行
inoremap <leader>do <esc>kddo
inoremap <leader>a <esc>la
"}}}

" 插入日期, 采用替换一行的方式 {{{
function! My_Insert_date()
    "插入日期的函数，如果不能正常使用请使用下面的方法
    if exists("*strftime")
        return setline(line('.'),strftime("%Y-%m-%d %H:%M:%S"))
    else
        return "Function Strftime is invalid!"
    endif
endfunction
"inoremap <leader>date :call My_Insert_date()<CR>
nnoremap <leader>date :call My_Insert_date()<CR>
"if g:os_windows
"    inoremap <leader>date <esc>:r!date/t<cr>
"    nnoremap <leader>date :r!date/t<cr>
"elseif g:os_linux
"    inoremap <leader>date <esc>:r!date "+\%F \%T"<cr>
"    nnoremap <leader>date :r!date "+\%F \%T"<cr>
"endif "}}}

"常规模式下用;来代替
"跟motion-repeat冲突
"noremap ; :

" 快速切换window {{{
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l
"}}}

" buffer 操作快捷键设置 {{{
nnoremap <C-N> :bn<CR>
nnoremap <C-P> :bp<CR>
nnoremap <C-F> :bf<CR>
":br == :bf 到第一个缓冲区
" C-r 和默认的redo快捷键冲突
"nnoremap <C-R> :br<CR>
nnoremap <Leader>bd :bdel<CR>
"}}}

" tab 操作快捷键设置 {{{
" tab 现在已经不流行了，注释掉不再使用,
" easymoiton t按键已经不再冲突，下列绑定可以使用,
" 不过似乎没有必要启用
"noremap <leader>tne :tabnew<cr>
"noremap <leader>te :tabedit<cr>
"noremap <leader>tc :tabclose<cr>
"noremap <leader>tm :tabmove
"noremap <Leader>tp :tabprevious<cr>
"noremap <Leader>tn :tabnext<cr>
"noremap <Leader>to :tabonly<cr>
"noremap <Leader>tf :tabfirst<cr>
"noremap <Leader>tl :tablast<cr>
    "}}}

" eggcache vim {{{
:command W w
:command WQ wq
:command Wq wq
:command Q q
:command Qa qa
:command QA qa
"}}}

"------gtags 代替ctags的支持
"set cscopetag " 使用 cscope 作为 tags 命令
"set cscopeprg='gtags-cscope' " 使用 gtags-cscope 代替 cscope
"" gtags.vim 设置项
"let GtagsCscope_Auto_Load = 1
"let CtagsCscope_Auto_Map = 1
"let GtagsCscope_Quiet = 1
"


"备份设置{{{
"set nobackup "不创建备份
"set noswapfile  "这个是系统崩溃，不正常退出的交换文件，一般要使用
"分别设置备份文件，交换文件和undotree的保存目录，因为默认和原始文件
"在一个目录，很难看，而且补全时候还容易混淆
"结尾的//表示生成的文件名加上绝对路径，保证不重名
"集中起来可以过一段时间删除一次
"
"设置vim备份目录的函数
"参数:type 表示操作类型，字符串。
    "值可以是'undo','backup','swp'
    "分别表示对undodir,backupdir和dir(swp文件)
    "的设置
"参数:local_path，全路径，使用expand扩展
    "如果目录不存在则会创建。如果没有权限，则函数
    "显示一条提示信息
"{{{
function! My_set_vim_tmp(type, local_path)
    try
        let l:path=expand(a:local_path)
    catch
        let l:path=a:local_path
    endtry

    let l:dir_exists=0
    "检验目录是否存在，不存在则创建，并
    "设置标志
    try
        if isdirectory(l:path)
            let l:dir_exists=1
        else
            try
                call mkdir(l:path, "p", 0755)
                let l:dir_exists=1
            catch
                echo "创建目录:\n" . l:path
                    \ . "\n出错，请检查权限和路径"
                    \ . "\n 参数local_path: "
                    \ . a:local_path
                return
            endtry
        endif
    endtry
    "根据type传入的参数，判断操作类型
    if l:dir_exists
        if a:type ==? 'backup'
            let l:opt='set backupdir='
        elseif a:type ==? 'swp'
            let l:opt='set directory='
        elseif a:type ==? 'undo'
            let l:opt = 'set undodir='
        else
            let l:opt = ""
        endif
        if l:opt != ""
            exe  l:opt . a:local_path . '/'
        endif
    endif
endfunction     "}}}

if g:os_windows
    "注意，路径最后一定要加'/'
    "比如'$VIM/backup/' 最后的'/'不能省略
    "也不能'$VIM/backup//'的形式，因为函数
    "会自动加上一个'/'在传入的参数最后
    call My_set_vim_tmp('backup', '$VIM/backup/')
    call My_set_vim_tmp('swp', '$VIM/swp/')
    call My_set_vim_tmp('undo', '$VIM/undo/')
elseif g:os_linux
    call My_set_vim_tmp('backup', '~/.vim/.backup/')
    call My_set_vim_tmp('swp', '~/.vim/.swp/')
    call My_set_vim_tmp('undo', '~/.vim/.undo/')
endif
"备份设置结束}}}

"自动转到文件目录，默认的是转到第一个打开文件的目录
set autochdir

set helplang=cn "中文帮助设置



"sdcv 的vim显示函数"{{{
"函数解释:
"    1. system执行外部命令-对当前光标处所在单词进行sdcv -n查询
"    2. windo部分是在每个窗口执行将%扩展，就是查看window的buff文件名
"       如果跟diCt-tmp崇重名，我们认为它是以前打开的字典缓冲，所以
"       删除以前内容，显示新的内容. 否则打开一个新的窗口显示
"    3. 25vsp vsp 是vs的别名，垂直方向，拆分25宽度的窗口，后面可以跟
"       buffer的名字
"    4. 设置buf属性，没有file也不能回写，没有交换文件，隐藏buff
"    5. 使用替换命令，将expl中的字符串替换到第一行 来显示
"    6. 最后的1 就是:1 跳到第一行
if g:os_linux
    function! Mydict()
        let l:expl=system('sdcv -n ' . expand("<cword>"))
        let l:print=0
        windo
            \ if expand("%")=="diCt-tmp" |
                \ exe 'norm ' . 'ggVG' |
                \ exe 'norm ' . '"_d' |
                \ 1s/^/\=l:expl/ |
                \ 1 |
                \ let l:print = 1 |
            \ endif

        if !l:print
            25vsp diCt-tmp
            setlocal buftype=nofile bufhidden=hide noswapfile
            1s/^/\=l:expl/
            1
        endif
    endfunction
    "noremap <C-K> :call Mydict()<CR>
    noremap <leader>kk :call Mydict()<CR>
endif   "}}}

" w!! to sudo & write a file
cmap w!! %!sudo tee >/dev/null %

" 快速打开配置文件快捷键 {{{
if g:os_windows
    nnoremap <silent> <leader>ep :e $VIM/init-plugs.vim<CR>
    nnoremap <silent> <leader>ec :e $VIM/init-plugs-conf.vim<CR>
    nnoremap <silent> <leader>ev :e $VIM/init-vim.vim<CR>
elseif g:os_linux
    nnoremap <silent> <leader>ep :e $HOME/.vim/init-plugs.vim<CR>
    nnoremap <silent> <leader>ec :e $HOME/.vim/init-plugs-conf.vim<CR>
    nnoremap <silent> <leader>ev :e $HOME/.vim/init-vim.vim<CR>
endif
nnoremap <leader>so :so %<CR>
"}}}

