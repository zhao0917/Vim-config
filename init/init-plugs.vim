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
" if g:os_windows
"   设置plug插件从github下载时候的url地址形式
    " let g:plug_url_format = 'https://github.com/%s.git'
    " let g:plug_url_format = 'git@github.com:%s.git'
" endif
call plug#begin(s:PlugInstalldir)
" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
" plugin from http://vim-scripts.org/vim/scripts.html
" Plug 'L9'
" Install L9 and avoid a Naming conflict if you've already installed a
" different version somewhere else.
" Plug 'ascenator/L9', {'name': 'newL9'}
" let g:plug_url_format = 'git@github.com:%s.git'
" All of your Plugs must be added before the following line
"------------------
" Code Completions
"------------------

"--- Language Server Client ---现在补全的主流是
"language server protocol

" LanguageClient-neovim 异步，python写的lsp
" 支持deoplete 和ncm2两个补全框架
" Plug 'autozimu/LanguageClient-neovim'

" vim-lsp是纯vimscript写的lsp，
" asyncomplete, deoplete和ncm2三个补全框架
" Plug 'prabirshrestha/vim-lsp'

" 补全框架有:可以参考这里
" https://www.zhihu.com/question/23590572
" deoplete.nvim
" ncm2
" asyncomplete
" coc.nvim

" coc是2018年的黑马，nodejs后端，目的就是实现类似
" vsc的补全，支持自身的补全框架
" 需要安装nodejs如果没有的话

"-----------------
" coc
"-----------------
Plug 'neoclide/coc.nvim', {'branch': 'release'}



" deoplete 是继neocomplete 后Shougo 又开发的补全插件，{{{
" 速度很快,需要安装 pynvim。 相对于YCM来说，安装很简单
" if has('nvim')
  " Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
" else
  " Plug 'Shougo/deoplete.nvim'
  " Plug 'roxma/nvim-yarp'
  " Plug 'roxma/vim-hug-neovim-rpc'
" 糢糊搜索插件
" Plug 'Shougo/denite.nvim'

" endif   "}}}

Plug 'ervandew/supertab'

"-----------------
" Fast navigation
"-----------------
Plug 'myusuf3/numbers.vim'
Plug 'easymotion/vim-easymotion'
Plug 'haya14busa/incsearch.vim'
Plug 'haya14busa/incsearch-easymotion.vim'
Plug 'haya14busa/incsearch-fuzzy.vim'
Plug 'tpope/vim-repeat'

"--------------
" Fast editting
"--------------
Plug 'spf13/vim-autoclose'
Plug 'tpope/vim-surround'
" 注释插件scrooloose git上已经无法找到
" vim-commentary没怎么用过
" Plug 'scrooloose/nerdcommenter'
" Plug 'tpope/vim-commentary'
Plug 'preservim/nerdcommenter'
Plug 'vim-scripts/DoxygenToolkit.vim'
Plug 'sjl/gundo.vim'
" tabular 通用格式化代码，对齐代码.
"  下面是别人做tabular使用和设置脚程
" http://vimcasts.org/episodes/aligning-text-with-tabular-vim/
Plug 'godlygeek/tabular'


"--------------
" IDE features
"--------------
Plug 'fholgado/minibufexpl.vim'
Plug 'scrooloose/nerdtree'
Plug 'majutsushi/tagbar'
" vdebug python似乎不能用，需要下载的插件无法安装
" Plug 'vim-vdebug/vdebug'

"--------------
" 搜索工具类
"--------------
" ag 的vim插件，需要安装ag程序，windows下载exe，linux一般源
" 里面都有了，apt install即可
Plug 'rking/ag.vim'

" Rg的vim插件
" Plug 'jremmen/vim-ripgrep'

" vim搜索插件，据说支持grep ag rg sift等
" Plug 'mhinz/vim-grepper'

" ferret是一个增强的多文件搜索工具，主要是对ag rg和ack的封装
" Plug 'wincent/ferret'

Plug 'mileszs/ack.vim'

" 高效 糢糊搜索插件，1.2k Stars
if  g:os_linux
    Plug 'Yggdroot/LeaderF', { 'do': './install.sh' }
elseif g:os_windows
    Plug 'Yggdroot/LeaderF', { 'do': '.\install.bat' }
endif

"Plug 'kien/ctrlp.vim'

" 搜索工具fzf
" windows下fzf要自己下载exe文件
if g:os_linux 
    Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
elseif g:os_windows
    Plug 'junegunn/fzf'
endif
Plug 'junegunn/fzf.vim'

" 功能增强类

" 这个是在 vim 中使用 git 的插件
Plug 'tpope/vim-fugitive'

Plug 'nathanaelkane/vim-indent-guides'
Plug 'Raimondi/delimitMate'

" snippets
Plug 'SirVer/ultisnips'
" vim-snippets 是模板,ultisnips vim-snipmate 等是
" 引擎，ultisnips 需要python支持，对模板支持最好
Plug 'honza/vim-snippets'

"------ snipmate dependencies -------
"Plug 'garbas/vim-snipmate'
"Plug 'MarcWeber/vim-addon-mw-utils'
"Plug 'tomtom/tlib_vim'

"Plug 'Lokaltog/vim-powerline'
" --- 语法检查 ---
Plug 'dense-analysis/ale'
" java语法检查，但是windows下似乎有问题
" if g:os_linux
    " Plug 'eclipse/eclipse.jdt.ls',{'do':'./mvnw clean verify'}
" elseif g:os_windows
    " Plug 'eclipse/eclipse.jdt.ls',{'do':'./mvnw.cmd clean verify'}
" endif
" Plug 'scrooloose/syntastic'

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
" 其他一些辅助工具
"-------------
" 输入法切换，windos下需要下载im-select并
" 设置路径
Plug 'zhao0917/smartim'

"-------------
"source code format
"-------------
" 一个支持多语言的通用格式化引擎，需要安装对应语言的
" 格式化工具采用使用，暂时不配置，不使用
" Plug 'chiel92/vim-autoformat'

"-------------
" Other Utils
"-------------
" Plug 'humiaozuzu/fcitx-status'
Plug 'nvie/vim-togglemouse'

"----------------------------------------
" Syntax/Indent for language enhancement
"----------------------------------------
"------- web backend ---------
" Plug '2072/PHP-Indenting-for-VIm'
"Plug 'tpope/vim-rails'
" Plug 'lepture/vim-jinja'
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
Plug 'jceb/vim-orgmode'
"Plug 'vim-scripts/speeddating.vim'
"Plug 'vim-scripts/NrrwRgn'
"Plug 'vim-scripts/SyntaxRange'
" Plug 'timcharper/textile.vim'

" tex & latex
Plug 'lervag/vimtex'  "Plug for latex

"------- Ruby --------
" Plug 'tpope/vim-endwise'


"------- C & C++ --------
Plug 'justmao945/vim-clang'

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
" jedi 和python-mode冲突

" autopep8 windows下和linux下不一样
if g:os_linux 
    Plug 'tell-k/vim-autopep8'
endif

"jedi-vim 不知为何不能正确运行
Plug 'davidhalter/jedi-vim'

" 貌似jedi安装时候的卡顿是因为没有安装curl
" 导致更新时候出错还是什么的
" Plug 'deoplete-plugins/deoplete-jedi'
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

" 编程语言备忘录
Plug 'LeCoupa/awesome-cheatsheets'
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
