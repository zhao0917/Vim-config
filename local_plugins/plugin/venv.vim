"  @file venv.vim
"  @brief 提供 vim 使用 anaconda3/miniconda3 创建的虚拟环境的支持。
"  @author ZhaoYouxiao,z_hao0917@126.com
"  @version 0.1.0
"  @date 2020-05-11
"  License:
"  Copyright © 2020 ZhaoYouxiao
"  
"  Permission is hereby granted, free of charge, to any person obtaining
"  a copy of this software and associated documentation files (the "Software"),
"  to deal in the Software without restriction, including without limitation
"  the rights to use, copy, modify, merge, publish, distribute, sublicense,
"  and/or sell copies of the Software, and to permit persons to whom the
"  Software is furnished to do so, subject to the following conditions:
"  
"  The above copyright notice and this permission notice shall be included
"  in all copies or substantial portions of the Software.
"  
"  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
"  EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
"  OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
"  IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM,
"  DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
"  TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE
"  OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
"  

" 用来处理vim使用python时候的虚拟环境的插件
" 通过修改sys.path实现


" 这两行是用来保证置位compatible选项后脚本可以顺利执行而不出错
let s:save_cpo = &cpo
set cpo&vim

if exists("g:venv_loaded")
    finish
else
    let g:venv_loaded = 1
endif

" vim python支持检测
" 仅仅支持python3
if !has('python3')
    finish
endif

py3 import vim, sys, os, re, platform

" 检查是否使用了conda
function! s:Venv_is_conda_installed()
    silent let l:conda_ver =  system('conda --version')

    if match(l:conda_ver, "\\Mconda \\(\\d\\+.\\)\\{2}\\d")  == -1
        return v:false
    else
        return v:true
    endif
endfunction


" 如何判断conda已经启用，以及conda中envs信息
" 通过conda info -e 获取conda的envs信息，然后根据$PATH确认某个env是否被激活
function! s:Venv_get_envs()
    let l:conda_info_cmd = "conda info -e"
    let l:conda_info = system(l:conda_info_cmd)->split('\n')
    let l:conda_envs={"*current*":""}

    let l:index=0
    while l:index < len(l:conda_info)
        let l:item = l:conda_info[l:index]
        if l:item =~ "^#" || len(l:item) == 0
            call remove(l:conda_info,l:index)
        else
            let l:conda_info[l:index] = substitute(l:item,"\\s\\+",' ','g')
            let l:index+=1
        endif
    endwhile

    for l:row in l:conda_info
        " 当前激活的env
        if match(l:row,"*") != -1
            " 去除带'*'号行中的'*'和多余空白字符
            let l:row = substitute(row,"\\(\\s\\|\\*\\)\\+"," ",'g')
            let l:conda_envs["*current*"]=l:row->split()[0]
        else
            let l:temp_list=l:row->split()
            " 这里拆分后有错误，单个字符串无法拆为两个元素，要用try
            if len(l:temp_list) == 2
                let l:conda_envs[l:temp_list[0]]=l:temp_list[1]
            endif
        endif
    endfor
    return l:conda_envs
endfunction


function! s:Venv_get_vim_py_major_ver()
    " 获取vim使用的python的版本信息
    " py3 import sys
    return py3eval("'.'.join(sys.version.split()[0].split('.')[:-1])")   
endfunction


" 取得python version的命令后缀
let s:python_version_options = " --version"
function! s:Venv_get_env_py_major_ver(python_exe)
" 获取venv中python版本号
    silent let l:python_version = system(a:python_exe .
                \ s:python_version_options)->split()[1]
    return l:python_version->split("\\.")[:-2]->join('.')
endfunction

" 取得conda虚拟环境信息
if !s:Venv_is_conda_installed()
    echom "Anaconda3 or miniconda3 is not installed yet, please ensure one of them is" .
                \ "installed and conda is in your system path"
    finish
else
    let s:conda_envs = s:Venv_get_envs()
endif
" 取得vim使用的python版本信息，前体是vim中已经可以使用python
let s:vim_py_ver = s:Venv_get_vim_py_major_ver()


function! Venv_set_venv()
    " 设置python的sys.path 使得vim运行在正确的python环境下

    for [l:key,l:value] in items(s:conda_envs)
        if l:key ==# "*current*" && len(l:value) > 0
            let l:py_exe = 'python'
        else
            if g:os_linux
                let l:py_exe = l:value . '/bin/python'
            elseif g:os_windows
                let l:py_exe = l:value . '\\python'
            endif
        endif

        let l:conda_env_py_ver = s:Venv_get_env_py_major_ver(l:py_exe)


        if l:conda_env_py_ver == s:vim_py_ver
            if l:py_exe == 'python'
                " 当前conda环境根vim 使用的python版本一致
                return 0
            else
                " 在sys.path中设置虚拟的环境变量
                if len(s:conda_envs["*current*"]) == 0
                    " windows下conda不随cmd启动，因为vim会频繁调用cmd，如果conda
                    " 随cmd启动会导致速度很慢，vim 里面的plug等很多插件都会调用cmd
                    if g:os_windows
                        let l:is_replace = v:true
                    elseif g:os_linux
                        let l:is_replace = v:false
                    endif
                else
                    let l:is_replace = v:true
                endif
                

                call s:Venv_set_python_venv(l:value, s:vim_py_ver, l:is_replace)
                return 0
            endif
        endif

    endfor

    " 说明conda的虚拟环境没有和vim 的python版本一致的，提示并
    echom "No conda venv matches vim's python version! The vim python version is:" .   s:vim_py_ver
endfunction

"
" 得到正确的版本，从而设置正确的路径
function! s:Venv_set_python_venv(venv_base, py_ver, is_replace)
python3<<EOF

# 需要注意特殊字符转换时候是否会发生变化
venv_base = str(vim.bindeval("a:venv_base"),'utf-8')
py_ver = str(vim.bindeval("a:py_ver"),'utf-8')
is_replace = vim.bindeval("a:is_replace")

os_platform=platform.system().lower()

venv_paths=[]

#    平台不同，目录结构不一样
if os_platform == 'linux':
    venv_base = os.path.join(venv_base, 'lib')

    # */lib/pythonxx.zip
    venv_paths.append(os.path.join(venv_base, 'python' + "".join(py_ver.split('.')) + '.zip'))

    venv_base = os.path.join(venv_base, 'python' + py_ver)
    # */lib/pythonx.x
    venv_paths.append(venv_base)

    # */lib/pythonx.x/lib-dynload
    venv_paths.append(os.path.join(venv_base, 'lib-dynload'))
    # */lib/pythonx.x/site-packages
    venv_paths.append(os.path.join(venv_base, 'site-packages'))

elif os_platform == 'windows':
    
    venv_paths.append(venv_base)
    #    */Library/bin
    venv_paths.append(os.path.join(venv_base, 'Library', 'bin'))

    #    */Scripts
    venv_paths.append(os.path.join(venv_base, 'Scripts'))

    #    */lib/site-packages
    venv_paths.append(os.path.join(venv_base, 'lib', 'site-packages'))
else:
    pass

# 然后根据conda 虚拟环境是否启用来判断该替换 sys.path的前4项，还是插入4项
if is_replace:
    if os_platform == 'linux':
        for i in range(len(venv_paths)):
            sys.path[i] = venv_paths[i]
    elif os_platform == 'windows':
        i=0
        while i < len(sys.path) and i <10:
            if 'python' in sys.path[i]:
                del sys.path[i]
            else:
                i+=1

        for i in range(len(venv_paths)):
            sys.path.insert(0,venv_paths[i])
    else:
        # 其他平台暂不支持
        pass
else:
    for i in range(len(venv_paths)):
        sys.path.insert(0,venv_paths[i])

EOF
endfunction

if g:os_linux || g:os_windows
    call Venv_set_venv()
endif

" 这两行是用来保证置位compatible选项后脚本可以顺利执行而不出错
let &cpo = s:save_cpo
unlet s:save_cpo
