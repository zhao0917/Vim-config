"-----------------------------------------------
" Plugin settings
"-----------------------------------------------

"-----------------------------------------------
" Programming languages
"-----------------------------------------------

"---------- S-expression ----------
" Rainbow parentheses for Lisp and variants. {{{
if My_Is_Plugin_load('rainbow_parentheses.vim')
    let g:rbpt_colorpairs = [
        \ ['brown',       'RoyalBlue3'],
        \ ['Darkblue',    'SeaGreen3'],
        \ ['darkgray',    'DarkOrchid3'],
        \ ['darkgreen',   'firebrick3'],
        \ ['darkcyan',    'RoyalBlue3'],
        \ ['darkred',     'SeaGreen3'],
        \ ['darkmagenta', 'DarkOrchid3'],
        \ ['brown',       'firebrick3'],
        \ ['gray',        'RoyalBlue3'],
        \ ['black',       'SeaGreen3'],
        \ ['darkmagenta', 'DarkOrchid3'],
        \ ['Darkblue',    'firebrick3'],
        \ ['darkgreen',   'RoyalBlue3'],
        \ ['darkcyan',    'SeaGreen3'],
        \ ['darkred',     'DarkOrchid3'],
        \ ['red',         'firebrick3'],
        \ ]
    let g:rbpt_max = 16
    " let g:rbpt_loadcmd_toggle = 0
    autocmd Syntax lisp,scheme,clojure,racket RainbowParenthesesToggle
                " \ | RainbowParenthesesActivate
                " \ | RainbowParenthesesLoadRound
endif "}}}

"-----------------------------------------------
" IDE features
"-----------------------------------------------

"---------- 文件浏览 ----------
" Nerdtree 树型目录浏览器 {{{
if My_Is_Plugin_load('nerdtree')
    let NERDChristmasTree=0
    let NERDTreeWinSize=30
    let NERDTreeChDirMode=2
    let NERDTreeIgnore=['\~$', '\.pyc$', '\.swp$']
    " let NERDTreeSortOrder=['^__\.py$', '\/$', '*', '\.swp$',  '\~$']
    let NERDTreeShowBookmarks=1
    let NERDTreeWinPos = "right"

    " nerdcommenter
    let NERDSpaceDelims=1
    " nmap <D-/> :NERDComToggleComment<cr>
    let NERDCompactSexyComs=1
    nmap <F6> :NERDTreeToggle<cr>
endif  "}}}

"---------- 代码导航 ----------
" Tagbar. {{{
if My_Is_Plugin_load('tagbar')
    noremap <F8> :TagbarToggle<cr>
    let g:tagbar_left=1
    let g:tagbar_width=30
    let g:tagbar_autofocus = 1
    let g:tagbar_sort = 0
    let g:tagbar_compact = 1
    " tag for coffee
    if executable('coffeetags')
      let g:tagbar_type_coffee = {
            \ 'ctagsbin' : 'coffeetags',
            \ 'ctagsargs' : '',
            \ 'kinds' : [
            \ 'f:functions',
            \ 'o:object',
            \ ],
            \ 'sro' : ".",
            \ 'kind2scope' : {
            \ 'f' : 'object',
            \ 'o' : 'object',
            \ }
            \ }

      let g:tagbar_type_markdown = {
        \ 'ctagstype' : 'markdown',
        \ 'sort' : 0,
        \ 'kinds' : [
            \ 'h:sections'
        \ ]
        \ }
    endif
endif  "}}}

"---------- 文件内容搜索类 ----------
" ctrlp . {{{
if My_Is_Plugin_load('ctrlp.vim')
    set wildignore+=*/tmp/*,*.so,*.o,*.a,*.obj,*.swp,*.zip,*.pyc,*.pyo,*.class,.DS_Store  " MacOSX/Linux
    let g:ctrlp_custom_ignore = '\.git$\|\.hg$\|\.svn$'
endif   "}}}

"---------- 多余空格处理 对python 特别有用 ----------
"{{{
if My_Is_Plugin_load('vim-better-whitespace')
    let g:better_whitespace_enabled=1  "全局启用
    let g:strip_whitespace_on_save=1  "保存时候去除多余空格
endif
"}}}

" Ack 快捷键 "{{{
nnoremap <Leader>ack :Ack!<Space>
inoremap <Leader>ack <esc>:Ack!<Space>
"}}}

" nerdcommenter C 风格的注释插件 "{{{
if My_Is_Plugin_load('nerdcommenter')
    let NERDSpaceDelims=1
    " nmap <D-/> :NERDComToggleComment<cr>
    let NERDCompactSexyComs=1
endif "}}}

" powerline {{{
"let g:Powerline_symbols = 'fancy' }}}

" SuperTab {{{
if My_Is_Plugin_load('SuperTab')
    " let g:SuperTabDefultCompletionType='context'
    let g:SuperTabDefaultCompletionType = '<C-n>'
    let g:SuperTabContextDefaultCompletionType = '<c-n>'
    let g:SuperTabRetainCompletionType=2
endif   "}}}

" deoplete.nvim "{{{
if My_Is_Plugin_load('deoplete.nvim')
" 现在版本基本上都是python3了，甚至有些vim 默认不支持python2,除非你自己编译
" 这个版本的官网源里面预编译版本，已经不支持python2了 <CR>'
    if g:os_linux
        " 加载虚拟环境，如果你不用虚拟环境，请注释掉
        " 否则根据你的路径自行修改
        "let g:python3_host_prog = '~youx/py37/bin/python'
        "set pyxversion=3

    elseif g:os_windows
        let g:python3_host_prog = 'D:/Program Files/Python37/python'
    endif
    let g:deoplete#enable_at_startup = 1
endif "}}}

" Enable omni completion.  {{{
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType c setlocal omnifunc=ccomplete#Complete
autocmd FileType vb set omnifunc=ccomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
"}}}

" ---------- easymotion ---------- {{{
if My_Is_Plugin_load('vim-easymotion')
    let g:EasyMotion_do_mapping = 0 " Disable default mappings
    " <Leader>f{char} to move to {char}
    map  <Leader>f <Plug>(easymotion-bd-f)
    nmap <Leader>f <Plug>(easymotion-overwin-f)
    "
    " " s{char}{char} to move to {char}{char}
     nmap s <Plug>(easymotion-overwin-f2)

    " Move to line
    map <Leader>L <Plug>(easymotion-bd-jk)
    nmap <Leader>L <Plug>(easymotion-overwin-line)

    " Move to word
    map  <Leader>w <Plug>(easymotion-bd-w)
    nmap <Leader>w <Plug>(easymotion-overwin-w)

    " 2-character search motion
    nmap s <Plug>(easymotion-s2)
    nmap t <Plug>(easymotion-t2)

    " 取代默认的搜索键
    map  / <Plug>(easymotion-sn)
    omap / <Plug>(easymotion-tn)
    " These `n` & `N` mappings are options. You do not have to map `n` & `N` to EasyMotion.
    " Without these mappings, `n` & `N` works fine. (These mappings just provide
    " different highlight method and have some other features )
    map  n <Plug>(easymotion-next)
    map  N <Plug>(easymotion-prev)

    " hjkl motion
    map <Leader>l <Plug>(easymotion-lineforward)
    map <Leader>j <Plug>(easymotion-j)
    map <Leader>k <Plug>(easymotion-k)
    map <Leader>h <Plug>(easymotion-linebackward)

    let g:EasyMotion_startofline = 0 " keep cursor column when JK motion
    "This setting makes EasyMotion work similarly to Vim's smartcase
    "option for global searches
    let g:EasyMotion_smartcase = 1
    "With this option set, v will match both v and V, but V will match V only.Default: 0"
    let g:EasyMotion_use_smartsign_us = 1 " US layout
    " Use uppercase target labels and type as a lower case
    let g:EasyMotion_use_upper = 1
    " Smartsign (type `3` and match `3`&`#`)
    let g:EasyMotion_use_smartsign_us = 1
endif  "}}}

"---------- intergration with incsearch ----------{{{
if My_Is_Plugin_load('incsearch.vim') &&
    \ My_Is_Plugin_load('incsearch-easymotion.vim')

    " You can use other keymappings like <C-l> instead of <CR> if you want to
    " use these mappings as default search and somtimes want to move cursor with
    " EasyMotion.
    function! s:incsearch_config(...) abort
      return incsearch#util#deepextend(deepcopy({
      \   'modules': [incsearch#config#easymotion#module({'overwin': 1})],
      \   'keymap': {
      \     "\<CR>": '<Over>(easymotion)'
      \   },
      \   'is_expr': 0
      \ }), get(a:, 1, {}))
    endfunction

    noremap <silent><expr> /  incsearch#go(<SID>incsearch_config())
    noremap <silent><expr> ?  incsearch#go(<SID>incsearch_config({'command': '?'}))
    noremap <silent><expr> g/ incsearch#go(<SID>incsearch_config({'is_stay': 1}))
endif  "}}}

"---------- incsearch fuzzy ----------{{{
if My_Is_Plugin_load('incsearch-fuzzy.vim')
    function! s:config_easyfuzzymotion(...) abort
      return extend(copy({
      \   'converters': [incsearch#config#fuzzyword#converter()],
      \   'modules': [incsearch#config#easymotion#module({'overwin': 1})],
      \   'keymap': {"\<CR>": '<Over>(easymotion)'},
      \   'is_expr': 0,
      \   'is_stay': 1
      \ }), get(a:, 1, {}))
    endfunction

    noremap <silent><expr> <Space>/ incsearch#go(<SID>config_easyfuzzymotion())
endif "}}}

" Keybindings for plugin toggle
nmap <F3> :GundoToggle<cr>
nmap <F4> :IndentGuidesToggle<cr>


" When editing a file, always jump to the last cursor position{{{
autocmd BufReadPost *
      \ if ! exists("g:leave_my_cursor_position_alone") |
      \     if line("'\"") > 0 && line ("'\"") <= line("$") |
      \         exe "normal g'\"" |
      \     endif |
      \ endif  "}}}

" syntastic 语法检查器 {{{
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_error_symbol='>>'
let g:syntastic_warning_symbol='>'
let g:syntastic_check_on_open=1
let g:syntastic_check_on_wq=0
let g:syntastic_enable_highlighting=1
let g:syntastic_python_checkers=['flake8'] " 使用pyflakes,速度比pylint快
"let g:syntastic_python_checkers=['pyflakes'] " 使用pyflakes,速度比pylint快
let g:syntastic_javascript_checkers = ['jsl', 'jshint']
let g:syntastic_html_checkers=['tidy', 'jshint']
" 修改高亮的背景色, 适应主题
highlight SyntasticErrorSign guifg=white guibg=black

" to see error location list
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_loc_list_height = 5
function! ToggleErrors()
    let old_last_winnr = winnr('$')
    lclose
    if old_last_winnr == winnr('$')
        " Nothing was closed, open syntastic error location panel
        Errors
    endif
endfunction
nnoremap <Leader>s :call ToggleErrors()<cr>
" nnoremap <Leader>sn :lnext<cr>
" nnoremap <Leader>sp :lprevious<cr>
" }}}

" VimAirline {{{
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'

  " 关闭状态显示空白符号计数,这个对我用处不大"
  "  let g:airline#extensions#whitespace#enabled = 0
  "   let g:airline#extensions#whitespace#symbol = '!'
"}}}

"------------
"AutoFormat
"------------
"path to formatter
"let g:formatterpath = ['/some/path/to/a/folder', '/home/superman/formatters']
"noremap <F3> :Autoformat<CR> "快捷键<F3>
"To disable the fallback to vim's indent file,
"retabbing and removing trailing whitespace, set the following variables to 0.
"let g:autoformat_autoindent = 0
"let g:autoformat_retab = 0
"let g:autoformat_remove_trailing_spaces = 0

"To disable or re-enable these option for specific buffers,
"use the buffer local variants: b:autoformat_autoindent,
"b:autoformat_retab and b:autoformat_remove_trailing_spaces.
"So to disable autoindent for filetypes that have incompetent indent files, use

autocmd FileType vim,tex,text,txt let b:autoformat_autoindent=0
autocmd FileType tex,text,txt set tw=100

"------------ VimWiki ---------- {{{
let g:vimwiki_use_mouse = 1
let g:vimwiki_list = [{'path': 'E:/VimWiki/',
            \ 'path_html': 'E:/VimWiki/html/',
            \ 'html_header': 'E:/VimWiki/Public/template/header.htm',}]
            "\'html_footer': 'E:/VimWiki/Public/template/footer.htm',
            "\'diary_link_count': 5,}]
" 对中文用户来说，我们并不怎么需要驼峰英文成为维基词条
let g:vimwiki_camel_case = 0
" 标记为完成的 checklist 项目会有特别的颜色
let g:vimwiki_hl_cb_checked = 1
" 我的 vim 是没有菜单的，加一个 vimwiki 菜单项也没有意义
let g:vimwiki_menu = ''
" 是否在计算字串长度时用特别考虑中文字符
let g:vimwiki_CJK_length = 1 "}}}


"---------- Pyhton 环境设置 ---------- {{{
" python 模式的缩进和tab 设置 "{{{
au BufNewFile,BufRead *.py
    \ set tabstop=4
    \ |  set softtabstop=4
    \ |  set shiftwidth=4
    \ |  set textwidth=79
    \ |  set expandtab
    \ |  set autoindent
    \ |  set fileformat=unix
    \ |  set foldmethod=indent
    \ |  set foldlevel=99
    \ |  let g:indent_guides_enable_on_vim_startup = 1
"}}}

"let g:pymode_python = 'python3'
"设置SimpylFold 的折叠可以看到文档字符串
let g:SimpylFold_docstring_preview=1
let python_highlight_all=1
let g:autopep8_on_save = 1
"let g:jedi#completions_command = "<C-N>"
"}}}

"css html等 "{{{
au BufNewFile,BufRead *.js, *.html, *.css
            \   set tabstop=2
            \ | set softtabstop=2
            \ | set shiftwidth=2
"}}}

