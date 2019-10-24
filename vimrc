"根据平台加载插件
"Neovim已经移除了vi兼容模式，nocompatible会被忽略，设置compatible会产生错误
"vim 许多插件 都不兼容vi
set nocompatible

let g:os_windows=has('win32') || has('win64')
let g:os_linux=has('linux')
let g:os_mac=has('osx')

if g:os_windows
    if has('nvim')  "是否是nvim
        source $HOME/AppData/Local/nvim/init-plugs.vim
        source $HOME/AppData/Local/nvim/init-plugs-conf.vim
        source $HOME/AppData/Local/nvim/init-vim.vim
        "手动下载的插件的安装目录
        "注意rtp+= 的等号后面不能有空格，否则会把空格也当作一个字符
        set rtp+=$VIM/Plugs/
    else
        source $VIMRUNTIME/vimrc_example.vim
        source $VIMRUNTIME/mswin.vim
        behave mswin
        source $VIM/init-plugs.vim
        source $VIM/init-plugs-conf.vim
        source $VIM/init-vim.vim

		"let $VIMFILES = $VIM.'/vimfiles'

		set rtp+=$VIMFILES/Plugs/
    endif

elseif g:os_linux
    if has('nvim')
        source $HOME/nvim/init-plugs.vim
        source $HOME/nvim/init-plugs-conf.vim
        source $HOME/nvim/init-vim.vim
        set runtimepath+=$HOME/nvim/Plugs
    else
        source $HOME/.vim/init-plugs.vim
        " 这里要先加载 init-vim 的配置，后加载插件的配置文件
        " 因为colo 的配置在 init-vim.vim 中了。否则就导致一个
        " 问题，lisp的括号颜色，不对。应该是配色插件重新修改了
        " 括号的配色导致的。 所以这里先加载 配色方案，再加载
        " 具体的应用的配色
        source $HOME/.vim/init-vim.vim
        source $HOME/.vim/init-plugs-conf.vim
        "let $VIMFILES = $HOME.'/.vim'
        set runtimepath+=$HOME/.vim/Plugs
    endif
endif
