"=========================================================
" File:        python_autopep8.vim
" Author:      tell-k <ffk2005[at]gmail.com>
" Last Change: 3-Jun-2018.
" Version:     1.2.0
" WebPage:     https://github.com/tell-k/vim-autopep8
" License:     MIT Licence
"==========================================================
" see also README.rst

" Only do this when not done yet for this buffer
if exists("b:loaded_autopep8_ftplugin")
    finish
endif
let b:loaded_autopep8_ftplugin=1
" let b:autopep8_current_cursor = [0, 1, 1, 0]

" 使用vim的python接口直接调用autopep8

py3 import vim,autopep8,re
func! Autopep8_fix_current_buffer(args)
" 从autopep8 中的main函数定义可以知道，对于文件修复，
" 应该使用autopep8.fix_multiple_files()函数。当文件名为 '-'
" 时候表示对流或者内存进行处理，应该使用fix_code()，autopep8
" 提供的是对stdin等标准输入输出的处理。当然你也可以将文件重
" 定向到stdin stdout不过需要实现它们可能会被使用的方法，比如：
" stdin.read() stdout.write()。
"
" 由于vim提供的对于python接口可以直接访问缓冲区(buffer)，而且
" 返回的是一个list，所以看fix_code()函数，发现调用的是
" fix_lines()，所以这里直接用了fix_lines()函数，它的第一个参数
" 是一个list，没个元素都是一行代码，第二个参数是一个对象，用
" 的是python提供的 argparse模块，主要是解析命令行参数的，毕竟
" autopep8主要是作为一个可执行文件(linux下就是一个命令)来用的
" 所以要处理命令行参数。而在autopep8中直接用这个构造出来的对象
" 来传递解析后的参数。
"
" 这些我们都可以在vim中执行python来搞定，但是为了处理autopep8选项
" 就必须要传递参数了，所以用了vim.bindeval()这可以直接访问vim脚本
" 中的变量，特别是带前缀的变量，不过对字符串，返回的是bytes，要
" 用str 函数转换。转换以后还要处理多余的空格，命令行参数也是先处理
" 多余空格，然后用一个列表传递进来的argv在python就是list。所以处理
" 好空格还要拆分为一个list交给parse_args()处理得到options，此时
" 我们就能用fix_lines(buff,options)来修复我们缓冲区的python源文件了。
" 不过返回的是一个str，我们以换行符为界线进行拆分为list，每行加上一个
" 换行符写入buff然后保存就OK了。
"
python3 << EOF
buff = vim.current.buffer
autopep8_args = str(vim.bindeval("a:args"),'utf-8')
autopep8_args = re.sub(r'\s+',' ',autopep8_args)
options = autopep8.parse_args(autopep8_args.split())
fixed_source = autopep8.fix_lines(buff, options)
original_newline = (
    autopep8.CRLF if autopep8.CRLF in fixed_source else autopep8.LF)
buff[:] = [
    line + original_newline for line in fixed_source.split(original_newline)[:-1]]
EOF
endfunc

function! Autopep8(...) range

    let l:args = get(a:, 1, '')

    if exists("g:autopep8_ignore")
        let autopep8_ignores=" --ignore=".g:autopep8_ignore
    else
        let autopep8_ignores=""
    endif

    if exists("g:autopep8_select")
        let autopep8_selects=" --select=".g:autopep8_select
    else
        let autopep8_selects=""
    endif

    if exists("g:autopep8_pep8_passes")
        let autopep8_pep8_passes=" --pep8-passes=".g:autopep8_pep8_passes
    else
        let autopep8_pep8_passes=""
    endif

    if exists("g:autopep8_max_line_length")
        let autopep8_max_line_length=" --max-line-length=".g:autopep8_max_line_length
    else
        let autopep8_max_line_length=""
    endif

    let autopep8_range = ""
    " let current_cursor = b:autopep8_current_cursor
    if l:args != ""
        let autopep8_range = " ".l:args
        let current_cursor = getpos(".")
    elseif a:firstline == a:lastline
        let autopep8_range = ""
        let current_cursor = [0, a:firstline, 1, 0]
    elseif a:firstline != 1 || a:lastline != line('$')
        let autopep8_range = " --range ".a:firstline." ".a:lastline
        let current_cursor = [0, a:firstline, 1, 0]
    endif

    if exists("g:autopep8_aggressive")
        if g:autopep8_aggressive == 2
           let autopep8_aggressive=" --aggressive --aggressive "
        else
           let autopep8_aggressive=" --aggressive "
        endif
    else
        let autopep8_aggressive=""
    endif

    if exists("g:autopep8_indent_size")
        let autopep8_indent_size=" --indent-size=".g:autopep8_indent_size
    else
        let autopep8_indent_size=""
    endif

    if exists("g:autopep8_diff_type") && g:autopep8_diff_type == "vertical"
        let autopep8_diff_type="vertical"
    else
        let autopep8_diff_type="horizontal"
    endif

    let autopep8_args=autopep8_pep8_passes.autopep8_selects.autopep8_ignores.autopep8_max_line_length.autopep8_aggressive.autopep8_indent_size.autopep8_range

    " current cursor
    " show diff if not explicitly disabled
    if !exists("g:autopep8_disable_show_diff")
        let tmpfile = tempname()
        try
           " write buffer contents to tmpfile because autopep8 --diff
           " does not work with standard input
           silent execute "0,$w! " . tmpfile
           let diff_cmd = execmdline . " --diff \"" . tmpfile . "\""
           let diff_output = system(diff_cmd)
        finally
           " file close
           if filewritable(tmpfile)
             call delete(tmpfile)
           endif
        endtry
    endif
    
    " execute autopep8 passing buffer contents as standard input
    call Autopep8_fix_current_buffer(autopep8_args . " -")
    " call Autopep8_fix_current_buffer("-")
    
    " restore cursor
    call setpos('.', current_cursor)

    " show diff
    if !exists("g:autopep8_disable_show_diff")
      if autopep8_diff_type == "vertical"
        vertical botright new autopep8
      else
        botright new autopep8
      endif
      setlocal buftype=nofile bufhidden=wipe nobuflisted noswapfile nowrap
      silent execute ':put =diff_output'
      setlocal nomodifiable
      setlocal nu
      setlocal filetype=diff
    endif

    hi Green ctermfg=green
    echohl Green
    echon "Fixed with autopep8 this file."
    echohl

endfunction


" This function saves the current window state, and executes Autopep8() with
" the user's existing options. After Autopep8 call, the initial window
" settings are restored. Undo recording is also paused during Autopep8 call
function! s:autopep8_on_save()
  if get(g:, "autopep8_on_save", 0)

    " Save cursor position and many other things.
    let l:curw = winsaveview()

    " stop undo recording
    try | silent undojoin | catch | endtry

    call Autopep8()

    " Restore our cursor/windows positions.
    call winrestview(l:curw)

  endif
endfunction

" During every save, also reformat the file with respect to the existing
" autopep8 settings.
augroup vim-python-autopep8
   autocmd!
   autocmd BufWritePre *.py call s:autopep8_on_save()
augroup END

