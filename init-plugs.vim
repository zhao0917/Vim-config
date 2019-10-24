set nocompatible              " be iMproved, required
filetype off                  " required

"vim 插件安装位置设置{{{
"注意不要包含vim默认的自动加载目录plugin autoload之类的文件名
"定义插件安装目录的局部变量，以使用于windows linux 和vim nvim
if g:os_windows
    if has('nvim')
        let s:PlugInstalldir='$VIM/pluged'
    else
        let s:PlugInstalldir='$VIM/vimfiles/pluged'
    endif
elseif g:os_linux
    if has('nvim')
        let s:PlugInstalldir='$HOME/nvim/pluged'
    else
        let s:PlugInstalldir='$HOME/.vim/pluged'
    endif
endif   "}}}

" 一个简单的判断插件是否安装的函数. {{{
function! My_Is_Plugin_load(plug)
"   返回1 如果插件目录在rtp中，否则返回0
"   和插件管理器一起使用，参数不区分大小写

    if (&rtp =~? a:plug)
        return 1
    else
        return 0
    endif
endfunction "}}}

" set the runtime path to include Vundle and initialize
call plug#begin(s:PlugInstalldir)
" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
" plugin from http://vim-scripts.org/vim/scripts.html
" Plug 'L9'
" Install L9 and avoid a Naming conflict if you've already installed a
" different version somewhere else.
" Plug 'ascenator/L9', {'name': 'newL9'}

"一个基于Ruby和C扩展实现的快速文件浏览的插件
" windows 下一直没配置好，所以就禁用了吧
if !g:os_windows
    Plug 'wincent/command-t'
endif

" All of your Plugs must be added before the following line
"------------------
" Code Completions
"------------------

" deoplete 是继neocomplete 后Shougo 又开发的补全插件，{{{
" 速度很快,需要安装 pynvim。 相对于YCM来说，安装很简单
if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif   "}}}

Plug 'Raimondi/delimitMate'
Plug 'ervandew/supertab'

" snippets
Plug 'garbas/vim-snipmate'
Plug 'honza/vim-snippets'
Plug 'justmao945/vim-clang'
"------ snipmate dependencies -------
Plug 'MarcWeber/vim-addon-mw-utils'
Plug 'tomtom/tlib_vim'

"-----------------
" Fast navigation
"-----------------
Plug 'myusuf3/numbers.vim'
Plug 'spf13/vim-autoclose'
Plug 'easymotion/vim-easymotion'
Plug 'haya14busa/incsearch.vim'
Plug 'haya14busa/incsearch-easymotion.vim'
Plug 'haya14busa/incsearch-fuzzy.vim'
Plug 'tpope/vim-repeat'

"--------------
" Fast editing
"--------------
Plug 'tpope/vim-surround'
Plug 'scrooloose/nerdcommenter'
Plug 'sjl/gundo.vim'
Plug 'godlygeek/tabular'
Plug 'nathanaelkane/vim-indent-guides'

"--------------
" IDE features
"--------------
Plug 'scrooloose/nerdtree'
Plug 'majutsushi/tagbar'
Plug 'mileszs/ack.vim'
"Plug 'kien/ctrlp.vim'
Plug 'ntpeters/vim-better-whitespace'
" 搜索工具fzf
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" 这个是在 vim 中使用 git 的插件
Plug 'tpope/vim-fugitive'


"Plug 'Lokaltog/vim-powerline'
Plug 'scrooloose/syntastic'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" 一个tag管理工具
Plug 'ludovicchabant/vim-gutentags'
Plug 'skywind3000/gutentags_plus'

"-------------- Text-objcet enhancement --------------{{{
"提供简单自定义Text-objects 的方法，
"textobj-between/anyblock/sentence都使用了本插件
Plug 'kana/vim-textobj-user'
"This plugin adds ic, ac, iC, and aC as text-objects. Use them in commands
"like vic, cic, and daC
Plug 'coderifous/textobj-word-column.vim'
Plug 'thinca/vim-textobj-between'
"This plugin adds ib and iB as text-objects
Plug 'rhysd/vim-textobj-anyblock'
" 增加对自然语言 文档类文本的语句识别
Plug 'reedes/vim-textobj-sentence'
" 增加vim对于 反引号'`' 的textobj 识别
Plug 'reedes/vim-textobj-quote'
" 将数字映射到按键，以快速实现行跳转
" 使用<space>作为模式启动键，比如<Space>jaf
" <Space>j 表示vertigo模式向下跳转，这个模式下
" 默认1234567890 被映射到asdfghjkl; 注意0对应的是逗号
" 所以<Space>jaf a对应1，f对应4就是向下跳转14行
" 如果单个数字，要使用shift，比如<Space>kF表示向上4行
" let g:Vertigo_homerow = 'aoeuidhtns' 来设置按键和数字对应关系
Plug 'prendradjaja/vim-vertigo' "}}}

"-------------
"source code format
"-------------
Plug 'chiel92/vim-autoformat'

"-------------
" Other Utils
"-------------
" Plug 'humiaozuzu/fcitx-status'
Plug 'nvie/vim-togglemouse'

"----------------------------------------
" Syntax/Indent for language enhancement
"----------------------------------------
"------- web backend ---------
Plug '2072/PHP-Indenting-for-VIm'
"Plug 'tpope/vim-rails'
Plug 'lepture/vim-jinja'
"Plug 'digitaltoad/vim-jade'

"------- web frontend ----------
"html css js and so on. {{{
"Plug 'othree/html5.vim'
" Plug 'tpope/vim-haml'
"Plug 'pangloss/vim-javascript'
"Plug 'kchmck/vim-coffee-script'
"Plug 'nono/jquery.vim'
" Plug 'groenewege/vim-less'
" Plug 'wavded/vim-stylus'
" Plug 'nono/vim-handlebars'

" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
"这是一个html的快速模板插件，比如输入div 扩展为<div></div>
"Plug 'rstacruz/sparkup', {'rtp': 'vim/'}

"Plug 'mattn/emmet-vim'
"}}}

"------- markup language -------
Plug 'plasticboy/vim-markdown'
"Plug 'jceb/vim-orgmode'
"Plug 'vim-scripts/speeddating.vim'
"Plug 'vim-scripts/NrrwRgn'
"Plug 'vim-scripts/SyntaxRange'
" Plug 'timcharper/textile.vim'

"------- Ruby --------
" Plug 'tpope/vim-endwise'

"------- Go ----------
"Plug 'fatih/vim-go'

"------- FPs ------
Plug 'kien/rainbow_parentheses.vim'
" Plug 'wlangstroth/vim-racket'
" Plug 'vim-scripts/VimClojure'
" Plug 'rosstimson/scala-vim-support'

"--------------
" Color Schemes
"--------------
"Plug 'rickharris/vim-blackboard'
"Plug 'altercation/vim-colors-solarized'
Plug 'rickharris/vim-monokai'
"Plug 'tpope/vim-vividchalk'
"Plug 'Lokaltog/vim-distinguished'
"Plug 'chriskempson/vim-tomorrow-theme'
"Plug 'fisadev/fisa-vim-colorscheme'
Plug 'lifepillar/vim-solarized8'
Plug 'brantb/solarized'
"Plug 'joshdick/onedark.vim'
Plug 'tomasr/molokai'
Plug 'altercation/vim-colors-solarized'
""一个插件的合集
"Plug 'flazz/vim-colorschemes'


"---------------
"python addins
"---------------
"Plug 'tell-k/vim-autopep8'
"jedi-vim 不知为何不能正确运行
"Plug 'davidhalter/jedi-vim'
" windows下的 python-mode 有问题
"Plug 'python-mode/python-mode'
"Plug 'tmhedberg/SimpylFold'
"flake8需要python的flake8包，pip install flake8
"Plug 'nvie/vim-flake8'

"---------------
"R support
"---------------
"Plug 'jalvesaq/Nvim-R'

"-------------------------------------------------
"vim 中文文档
"-------------------------------------------------
Plug 'yianwillis/vimcdoc'

"--------------
"download plugins from web manually
"--------------
"Plug '$vim/vimfiles/Plugs'


call plug#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PlugList       - lists configured plugins
" :PlugInstall    - installs plugins; append `!` to update or just :PlugUpdate
" :PlugSearch foo - searches for foo; append `!` to refresh local cache
" :PlugClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plug stuff after this line
