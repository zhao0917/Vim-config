"根据平台加载插件
" 目的是为了多平台通用，neovim和vim共用一份配置文件和插件
" 目录，对于neovim 和 vim 搜索初始化位置不同，可以用source指定配置文件
" 位置即可

"Neovim已经移除了vi兼容模式，nocompatible会被忽略，设置compatible会产生错误
"vim 许多插件 都不兼容vi
set nocompatible

" 定义几个全局变量，用来区分os
if !exists("g:os_windows")
    let g:os_windows=has('win32') || has('win64')
endif

if !exists("g:os_linux")
    let g:os_linux=has('linux')
endif
if !exists("g:os_max")
    let g:os_mac=has('osx')
endif

if g:os_windows
    " 如果设置了$home 环境变量,使用$home/.vim
    " 作为配置目录,否则使用$userprofile/AppData/Local/.vim作为插件安装目录
    " windows下vim要特别处理的东西
    if !has('nvim')
        source $VIMRUNTIME/vimrc_example.vim
        source $VIMRUNTIME/mswin.vim
        behave mswin
    else
        " nvim的python支持，可以识别虚拟环境，注意需要安装pynvim
        let g:python3_host_prog='D:/ProgramData/Anaconda3/envs/py38/python.exe'
    endif

    if $HOME !=# "" && $HOME !=# $USERPROFILE
        " init-vim 先于init-plugs-conf 加载，因为leader键在init-vim中设置,
        " 有很多插件的配置都需要leader键。而且在linux下也出现过配色不对的
        " 情形，但是让init-vim 先于 init-plugs-conf加载可以解决这个问题，
        source $HOME/.vim/init/utils.vim
        let g:vim_plug_install_dir='$HOME/.vim/plugged'
        source $HOME/.vim/init/plug.vim
        source $HOME/.vim/init/init-plugs.vim
        source $HOME/.vim/init/init-vim.vim
        source $HOME/.vim/init/init-plugs-conf.vim
        set rtp+=$HOME/.vim/local_plugins/
    else
        source $USERPROFILE/AppData/Local/.vim/init/utils.vim
        let g:vim_plug_install_dir='$USERPROFILE/AppData/Local/.vim/plugged'
        source $USERPROFILE/AppData/Local/.vim/init/plug.vim
        source $USERPROFILE/AppData/Local/.vim/init/init-plugs.vim
        source $USERPROFILE/AppData/Local/.vim/init/init-vim.vim
        source $USERPROFILE/AppData/Local/.vim/init/init-plugs-conf.vim
        set rtp+=$USERPROFILE/AppData/Local/.vim/local_plugins/
    endif
elseif g:os_linux
    if has('nvim')
        " let g:python3_host_prog='D:/ProgramData/Anaconda3/envs/py38/python.exe'
    endif
    source $HOME/.vim/init/utils.vim
    let g:vim_plug_install_dir='$HOME/.vim/plugged'
    source $HOME/.vim/init/plug.vim
    source $HOME/.vim/init/init-plugs.vim
    source $HOME/.vim/init/init-vim.vim
    source $HOME/.vim/init/init-plugs-conf.vim
    set runtimepath+=$HOME/.vim/local_plugins
elseif g:os_mac
    " mac下配置不清楚，所以暂时不处理
endif
