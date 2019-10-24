"根据平台加载插件
"Neovim已经移除了vi兼容模式，nocompatible会被忽略，设置compatible会产生错误
"vim 许多插件 都不兼容vi
set nocompatible

let g:os_windows=has('win32') || has('win64')
let g:os_linux=has('linux')
let g:os_mac=has('osx')

if g:os_windows
    " init-vim 先于init-plugs-conf 加载，因为leader键在init-vim中设置,
    " 有很多插件的配置都需要leader键。而且在linux下也出现过配色不对的
    " 情形，但是让init-vim 先于 init-plugs-conf加载可以解决这个问题，
    if has('nvim')  "是否是nvim
        source $HOME/AppData/Local/nvim/init-plugs.vim
        source $HOME/AppData/Local/nvim/init-vim.vim
        source $HOME/AppData/Local/nvim/init-plugs-conf.vim
        "手动下载的插件的安装目录
        "注意rtp+= 的等号后面不能有空格，否则会把空格也当作一个字符
        set rtp+=$VIM/Plugs/
    else
        source $VIMRUNTIME/vimrc_example.vim
        source $VIMRUNTIME/mswin.vim
        behave mswin
        source $VIM/init-plugs.vim
        source $VIM/init-vim.vim
        source $VIM/init-plugs-conf.vim

		"let $VIMFILES = $VIM.'/vimfiles'

		set rtp+=$VIMFILES/Plugs/
    endif

elseif g:os_linux
    if has('nvim')
        source $HOME/nvim/init-plugs.vim
        source $HOME/nvim/init-vim.vim
        source $HOME/nvim/init-plugs-conf.vim
        set runtimepath+=$HOME/nvim/Plugs
    else
        source $HOME/.vim/init-plugs.vim
        source $HOME/.vim/init-vim.vim
        source $HOME/.vim/init-plugs-conf.vim
        "let $VIMFILES = $HOME.'/.vim'
        set runtimepath+=$HOME/.vim/Plugs
    endif
endif
