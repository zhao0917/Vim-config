"-----------------------------------------------
" Plugin settings
"-----------------------------------------------
"-----------------------------------------------
" IDE features
"-----------------------------------------------

"{{{ Minibufexplorer
if My_Is_Plugin_load('minibufexpl.vim')
  map <Leader>mbe :MBEOpen<cr>
  map <Leader>mbc :MBEClose<cr>
  map <Leader>mbt :MBEToggle<cr>
endif
"}}}

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

" ctrlp . {{{ 文件内容搜索类
if My_Is_Plugin_load('ctrlp.vim')
    set wildignore+=*/tmp/*,*.so,*.o,*.a,*.obj,*.swp,*.zip,*.pyc,*.pyo,*.class,.DS_Store  " MacOSX/Linux
    let g:ctrlp_custom_ignore = '\.git$\|\.hg$\|\.svn$'
endif   "}}}

"{{{ vim-better_whitespace_enabled  多余空格处理
if My_Is_Plugin_load('vim-better-whitespace')
    let g:better_whitespace_enabled=1  "全局启用
    let g:strip_whitespace_on_save=1  "保存时候去除多余空格

    " <Leader>s 是本插件提供的快捷键，可以在下面修改
    " 和syntastic冲突，而且设定保存时候自动运行，基本也不需要
    " 手动运行了，所以移除快捷键设置
    let g:better_whitespace_operator=''

    " 取消保存时候的确认提示
    let g:strip_whitespace_confirm=0

    " 有些相要保留空格的文件，加入下面列表中
    "let g:better_whitespace_filetypes_blacklist=['','']
endif
"}}}

" Ack 快捷键 "{{{
if My_Is_Plugin_load('ack.vim')
    " 使用ag作为ack搜索引擎
    let g:ackprg = "ag --vimgrep"
    nnoremap <Leader>ack :Ack!<Space>
    inoremap <Leader>ack <esc>:Ack!<Space>
endif
"}}}

"{{{ Ag 配置
if My_Is_Plugin_load('ag.vim')
    " 设置搜索目录为当前目录
    let g:ag_working_path_mode="r"
endif
"}}}

"{{{  LeaderF 
if My_Is_Plugin_load('LeaderF')
    " don't show the help in normal mode
    let g:Lf_HideHelp = 1
    let g:Lf_UseCache = 0
    let g:Lf_UseVersionControlTool = 0
    let g:Lf_IgnoreCurrentBufferName = 1
    " popup mode
    let g:Lf_WindowPosition = 'popup'
    let g:Lf_PreviewInPopup = 1
    " let g:Lf_StlSeparator = { 'left': "\ue0b0", 'right': "\ue0b2", 'font':
    "DejaVu Sans Mono for Powerline" }
    let g:Lf_PreviewResult = {'Function': 0, 'BufTag': 0 }
    let g:Lf_WindowHeight = 0.3 " 窗口高度，百分比

    let g:Lf_ShortcutF = "<leader>ff" " 默认快捷键跟easymotion冲突了，修改下

    noremap <leader>fb :<C-U><C-R>=printf("Leaderf buffer %s", "")<CR><CR>
    noremap <leader>fm :<C-U><C-R>=printf("Leaderf mru %s", "")<CR><CR>
    noremap <leader>ft :<C-U><C-R>=printf("Leaderf bufTag %s", "")<CR><CR>
    noremap <leader>fl :<C-U><C-R>=printf("Leaderf line %s", "")<CR><CR>

    " noremap <C-B> :<C-U><C-R>=printf("Leaderf! rg --current-buffer -e %s ", expand("<cword>"))<CR>
    " noremap <C-F> :<C-U><C-R>=printf("Leaderf! rg -e %s ", expand("<cword>"))<CR>
    " search visually selected text literally
    " xnoremap gf :<C-U><C-R>=printf("Leaderf! rg -F -e %s ",
    " leaderf#Rg#visual())<CR>
    " noremap go :<C-U>Leaderf! rg --recall<CR>
    
    " " should use `Leaderf gtags --update` first
    let g:Lf_GtagsAutoGenerate = 0
    let g:Lf_Gtagslabel = 'native-pygments'
    noremap <leader>fr :<C-U><C-R>=printf("Leaderf! gtags -r %s --auto-jump", expand("<cword>"))<CR><CR>
    noremap <leader>fd :<C-U><C-R>=printf("Leaderf! gtags -d %s --auto-jump", expand("<cword>"))<CR><CR>
    noremap <leader>fo :<C-U><C-R>=printf("Leaderf! gtags --recall %s", "")<CR><CR>
    noremap <leader>fn :<C-U><C-R>=printf("Leaderf gtags --next %s", "")<CR><CR>
    noremap <leader>fp :<C-U><C-R>=printf("Leaderf gtags --previous %s", "")<CR><CR>
endif"}}}

" nerdcommenter C 风格的注释插件 "{{{
if My_Is_Plugin_load('nerdcommenter')
    let NERDSpaceDelims=1
    " nmap <D-/> :NERDComToggleComment<cr>
    let NERDCompactSexyComs=1
endif "}}}

" powerline {{{
"let g:Powerline_symbols = 'fancy' }}}

" VimAirline {{{
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'

  " 关闭状态显示空白符号计数,这个对我用处不大"
  "  let g:airline#extensions#whitespace#enabled = 0
  "   let g:airline#extensions#whitespace#symbol = '!'
"}}}

"{{{  coc.nvim
if My_Is_Plugin_load('coc.nvim')
    " 插件设置
    call coc#add_extension('coc-json','coc-python','coc-jedi',
                \ 'coc-clangd', 'coc-cmake', 'coc-snippets')
    " TextEdit might fail if hidden is not set.
    set hidden

    " Some servers have issues with backup files, see #649.
    set nobackup
    set nowritebackup

    " Give more space for displaying messages.
    set cmdheight=2

    " Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
    " delays and poor user experience.
    set updatetime=300

    " Don't pass messages to |ins-completion-menu|.
    set shortmess+=c

    " Always show the signcolumn, otherwise it would shift the text each time
    " diagnostics appear/become resolved.
    set signcolumn=yes
    " Use tab for trigger completion with characters ahead and navigate.
    " NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
    " other plugin before putting this into your config.
    " inoremap <silent><expr> <TAB>
          " \ pumvisible() ? "\<C-n>" :
          " \ <SID>check_back_space() ? "\<TAB>" :
          " \ coc#refresh()
     " inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
    function! s:check_back_space() abort
      let col = col('.') - 1
      return !col || getline('.')[col - 1]  =~# '\s'
    endfunction

    " Use <c-space> to trigger completion.
    inoremap <silent><expr> <c-space> coc#refresh()

    " Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
    " position. Coc only does snippet and additional edit on confirm.
    if has('patch8.1.1068')
      " Use `complete_info` if your (Neo)Vim version supports it.
      inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
    else
      imap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
    endif

    " Use `[g` and `]g` to navigate diagnostics
    nmap <silent> [g <Plug>(coc-diagnostic-prev)
    nmap <silent> ]g <Plug>(coc-diagnostic-next)

    " GoTo code navigation.
    nmap <silent> gd <Plug>(coc-definition)
    nmap <silent> gy <Plug>(coc-type-definition)
    nmap <silent> gi <Plug>(coc-implementation)
    nmap <silent> gr <Plug>(coc-references)

    " Use K to show documentation in preview window.
    nnoremap <silent> K :call <SID>show_documentation()<CR>

    function! s:show_documentation()
      if (index(['vim','help'], &filetype) >= 0)
        execute 'h '.expand('<cword>')
      else
        call CocAction('doHover')
      endif
    endfunction
    " Highlight the symbol and its references when holding the cursor.
    autocmd CursorHold * silent call CocActionAsync('highlight')

    " Symbol renaming.
    nmap <leader>rn <Plug>(coc-rename)

    " Add (Neo)Vim's native statusline support.
    " NOTE: Please see `:h coc-status` for integrations with external plugins that
    " provide custom statusline: lightline.vim, vim-airline.
    set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}
endif
"}}}

"{{{ ale
if My_Is_Plugin_load('ale')
    " 什么时候启动语法检查
    " Never check buffers on changes
    let g:ale_lint_on_text_changed=0
    " 退除insert模式不检查
    let g:ale_lint_on_insert_leave=0
    " BufWinEnter事件不检查
    let g:ale_lint_on_enter=0
    " 文件类型改变时候不检查
    let g:ale_lint_on_filetype_changed = 0

    " 语法检查器的设置，注意这是一个字典，会和默认的
    " 字典进行合并，所以，禁用某种语言的检查器，将
    " 对应语言的检查器设置为[]即可。如果你要设置多个
    " 语言的检查器，请写在一个字典里面
    " 一个语言可以写多个检查器，在方括号用逗号隔开
    " ['flake8','pyflakes']
    let g:ale_linters = {'javascript': ['eslint'],
                \'python':['flake8']}
    " Only run linters named in ale_linters settings.
    let g:ale_linters_explicit = 1

    " 显示ale状态栏
    let g:ale_sign_column_always=1

    " 关闭高亮
    let g:ale_set_highlights=0

    " 警告和错误标志

    " java设置或许可以在linux上设置，windows还是用eclipse等ide吧
    " let g:ale_java_google_java_format_executable = 
                " \'D:\\Program Files\\Java\\jdk-14\\lib\\google-java-format-1.7'
    " let g:ale_java_google_java_format_use_global = 1 
    " 代码修复工具
    " 第一行是针对所有代码的
    let g:ale_fixers = {
                \   '*': ['remove_trailing_lines', 'trim_whitespace'],
                \   'javascript': ['eslint'],
                \   'python' : ['autopep8'],
                \   'c':['clangd'],
                \   'c++':['clangd']
                \}
endif
"}}}

" SuperTab {{{
if My_Is_Plugin_load('SuperTab')
    " let g:SuperTabDefultCompletionType='context'
    let g:SuperTabDefaultCompletionType = '<C-n>'
    let g:SuperTabContextDefaultCompletionType = '<c-n>'
    let g:SuperTabRetainCompletionType=2
endif   "}}}

" syntastic 语法检查器 {{{
if My_Is_Plugin_load('syntastic')

    set statusline+=%#warningmsg#
    set statusline+=%{SyntasticStatuslineFlag()}
    set statusline+=%*

    let g:syntastic_error_symbol='>>'
    let g:syntastic_warning_symbol='>'
    let g:syntastic_check_on_open=1
    let g:syntastic_check_on_wq=0
    let g:syntastic_enable_highlighting=1

    " 使用pyflakes,速度比pylint快
    let g:syntastic_python_checkers=['flake8'] 
    " flake8参数设置
    let g:syntastic_python_flake8_args="--ignore=E121,E123,E126,E226,E24,E704,W503,W504,F401"
    "let g:syntastic_python_checkers=['pyflakes'] " 使用pyflakes,速度比pylint快

    " let g:syntastic_javascript_checkers = ['jsl', 'jshint']
    " let g:syntastic_html_checkers=['tidy', 'jshint']
    
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

endif
" }}}

" deoplete.nvim "{{{  代码补全
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

"{{{ vim indent guides 缩进显示
if My_Is_Plugin_load('vim-indent-guides')
    nnoremap <F4> :IndentGuidesToggle<cr>
endif
"}}}

"{{{ vim-gutentags tag管理工具
if My_Is_Plugin_load('vim-gutentags')

    " enable gtags module
    let g:gutentags_modules = ['ctags', 'gtags_cscope']

    " config project root markers.
    let g:gutentags_project_root = ['.root', '.svn', '.git', '.project']

    " 所生成的数据文件的名称 "
    " let g:gutentags_ctags_tagfile = '.tags'

    " generate datebases in my cache directory, prevent gtags files polluting my project
    let g:gutentags_cache_dir = expand('~/.cache/tags')

    " change focus to quickfix window after search (optional).
    let g:gutentags_plus_switch = 1

    " 停用默认的按键设置，因为会和很多的注释插件冲突
    let g:gutentags_plus_nomap = 1
    noremap <silent> <leader>gs :GscopeFind s <C-R><C-W><cr>
    noremap <silent> <leader>gg :GscopeFind g <C-R><C-W><cr>
    noremap <silent> <leader>gc :GscopeFind c <C-R><C-W><cr>
    noremap <silent> <leader>gt :GscopeFind t <C-R><C-W><cr>
    noremap <silent> <leader>ge :GscopeFind e <C-R><C-W><cr>
    noremap <silent> <leader>gf :GscopeFind f <C-R>=expand("<cfile>")<cr><cr>
    noremap <silent> <leader>gi :GscopeFind i <C-R>=expand("<cfile>")<cr><cr>
    noremap <silent> <leader>gd :GscopeFind d <C-R><C-W><cr>
    noremap <silent> <leader>ga :GscopeFind a <C-R><C-W><cr>

endif
"}}}

"{{{ ultisnips 快速代码片断
if My_Is_Plugin_load('ultisnips')

    " Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
    " let g:UltiSnipsExpandTrigger="<tab>"
    let g:UltiSnipsJumpForwardTrigger="<c-b>"
    let g:UltiSnipsJumpBackwardTrigger="<c-z>"

    " If you want :UltiSnipsEdit to split your window.
    "let g:UltiSnipsEditSplit="vertical"

endif
"}}}

"-----------------
" Fast navigation
"-----------------

"{{{ numbers.vim  相对行号
if My_Is_Plugin_load('numbers.vim')
    "  指定不使用相对行号的插件窗口
    let g:numbers_exclude = [
                \'tagbar',
                \'gundo',
                \'minibufexpl',
                \ 'unite',
                \ 'startify',
                \ 'vimshell',
                \'nerdtree']
endif
"}}}

" ---------- easymotion ---------- {{{
if My_Is_Plugin_load('vim-easymotion')
    " Disable default mappings
    " 禁用以后所有快捷键都需要重设
    " let g:EasyMotion_do_mapping = 0

    ""使用一个<Leader>作为前缀
    " map <Leader> <Plug>(easymotion-prefix)

    " 这里我们使用仍然使用双leader键，但是修改
    " 常用的的快捷键

    " easymotion 功能做的十份的强悍，里面的函数有很多，
    " 具体可以:help easymoiton 看帮助

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
    " map  / <Plug>(easymotion-sn)
    " omap / <Plug>(easymotion-tn)
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
    " 设置为1时候，会导致在 ,w 等模式下，输入小写变为大写，导致
    " 不能正确识别，从而不能正确跳转
    let g:EasyMotion_use_upper = 0
    " Smartsign (type `3` and match `3`&`#`)
    let g:EasyMotion_use_smartsign_us = 1
endif  "}}}

"---------- intergration with incsearch ----------{{{
if My_Is_Plugin_load('incsearch.vim') &&
    \ My_Is_Plugin_load('incsearch-easymotion.vim')

    " You can use other keymappings like <C-l> instead of <CR> if you want to
    " use these mappings as default search and somtimes want to move cursor with
    " EasyMotion.

    " 搜索后自动关闭高亮
    set hlsearch
    let g:incsearch#auto_nohlsearch = 1

    " map n  <Plug>(incsearch-nohl-n)
    " map N  <Plug>(incsearch-nohl-N)
    map *  <Plug>(incsearch-nohl-*)
    map #  <Plug>(incsearch-nohl-#)
    map g* <Plug>(incsearch-nohl-g*)
    map g# <Plug>(incsearch-nohl-g#)

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
" 糢糊搜索
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

    " 同时使用fuzzy和fuzzyspell特性
    function! s:config_fuzzyall(...) abort
      return extend(copy({
      \   'converters': [
      \     incsearch#config#fuzzy#converter(),
      \     incsearch#config#fuzzyspell#converter()
      \   ],
      \ }), get(a:, 1, {}))
    endfunction

    noremap <silent><expr> z/ incsearch#go(<SID>config_fuzzyall())
    noremap <silent><expr> z? incsearch#go(<SID>config_fuzzyall({'command': '?'}))
    noremap <silent><expr> zg? incsearch#go(<SID>config_fuzzyall({'is_stay': 1}))
endif "}}}


"-----------------------------------------------
" Fast editting
"-----------------------------------------------

"{{{ nerdcommenter 快速注释工具
" 似乎没有什么要设置的，如果又按键冲突再说
"}}}

"{{{ DoxygenToolkit
if My_Is_Plugin_load('DoxygenToolkit.vim')

    let g:DoxygenToolkit_blockHeader="--------------------------------------------------------------------------"
    let g:DoxygenToolkit_blockFooter="----------------------------------------------------------------------------"

    " 作者和邮箱
    let g:DoxygenToolkit_authorName="ZhaoYouxiao,z_hao0917@126.com" 

    " 拼接出License，原脚本也是这么干的
    let s:licenseTag = "\<enter>" 
    let s:licenseTag = s:licenseTag . "Call Center On Demand Product Series\<enter>" 
    let s:licenseTag = s:licenseTag . "Copyright (C) 2015 ChannelSoft(Beijing.) Technology Ltd., Co.\<enter>" 
    let s:licenseTag = s:licenseTag . "All right reserved\<enter>" 
    let s:licenseTag = s:licenseTag . "\<enter>" 
    let s:licenseTag = s:licenseTag . "$$\<enter>" 
    let s:licenseTag = s:licenseTag . "TODO:\<enter>" 
    let s:licenseTag = s:licenseTag . "\<enter>" 
    let s:licenseTag = s:licenseTag . g:DoxygenToolkit_blockFooter
    let g:DoxygenToolkit_licenseTag =  s:licenseTag 

    " 函数注释
    let g:DoxygenToolkit_paramTag_pre="@Param "
    let g:DoxygenToolkit_returnTag="@Returns   "

    " let g:DoxygenToolkit_briefTag_funcName="no" 
    " let g:doxygen_enhanced_color=1 
    " 使用C++的 ///注释
    " let g:DoxygenToolkit_commentType="C++" 
    let g:DoxygenToolkit_classTag = "@class "
endif
"}}}

"{{{ tabular 对齐和格式化工具 使用正则表达式
" 原理是每个匹配的符号处，以符号为中心，将字符分为3部分
" a , b 如果使用逗号为分割符号
"   1   2   3
"   a   ,   b
"   :Tab /,/[[l,r,c][count],...]
" 比如 :Tab /,/r1c2l0 :
" 首先分隔符号 2 对齐;
" 左边第1部分采用r右对齐；并在第1部分和第二部分之间加1个空格；
" 然后c2是对2和3之间加2个空格；
" l0是第3部分采用左对齐，并在后面添加0空格
" \zs 选项会使得分隔符不会对齐，虽然你写了c2，但作用只是在
" 分割符后面加了2个空格，也就是r1 c2 l0 对应了分割符的左边；
" 分隔符本身和分隔符右边
" 我们一般用下面映射，来对公式和冒号进行格式化
if My_Is_Plugin_load('tabular')
  nmap <Leader>a= :Tabularize /=<CR>
  vmap <Leader>a= :Tabularize /=<CR>
  nmap <Leader>a: :Tabularize /:\zs<CR>
  vmap <Leader>a: :Tabularize /:\zs<CR>
endif
" 还有一个方便我们写markdown中表格的设置在
" http://vimcasts.org/episodes/aligning-text-with-tabular-vim/
" 当你每次插入 | 时候，会自动调用实现自动对齐
" 如果你需要的话反注释下面代码段即可

"inoremap <silent> <Bar>   <Bar><Esc>:call <SID>align()<CR>a
"
"function! s:align()
"  let p = '^\s*|\s.*\s|\s*$'
"  if exists(':Tabularize') && getline('.') =~# '^\s*|' && (getline(line('.')-1) =~# p || getline(line('.')+1) =~# p)
"    let column = strlen(substitute(getline('.')[0:col('.')],'[^|]','','g'))
"    let position = strlen(matchstr(getline('.')[0:col('.')],'.*|\s*\zs.*'))
"    Tabularize/|/l1
"    normal! 0
"    call search(repeat('[^|]*|',column).'\s\{-\}'.repeat('.',position),'ce',line('.'))
"  endif
"endfunction
"}}}

let g:smartim_im_select_path = "C:\\gnu\\bin\\im-select"
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


"-----------------------------------------------
" Programming languages
"-----------------------------------------------

"---------- Pyhton 环境设置 ---------- 
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

"{{{ jedi 补全和静态检查
if My_Is_Plugin_load('jedi-vim')
    let python_highlight_all=1

    " Disabled do some vim configuration
    " let g:jedi#auto_vim_configuration = 0

    " 弹出时候不选择条目
    let g:jedi#popup_select_first = 0
    let g:jedi#use_splits_not_buffers = "top"
    " 使用deoplete-jedi 禁用jedi资深的补全
    let g:jedi#completions_enabled = 0

    " Disabled Command <Leader>g
    let g:jedi#goto_assignments_command = ""
    " let g:jedi#completions_command = "<C-N>"
endif
"}}}

    let g:autopep8_disable_show_diff=1
    let g:autopep8_on_save = 1
"{{{ Autopep8 
if My_Is_Plugin_load('vim-Autopep8')
    " let g:autopep8_ignore="E501,W293"

    " Disable show diff window
    let g:autopep8_disable_show_diff=1
    let g:autopep8_on_save = 1

    " 如果你使用"="来使用autopep8
    " autocmd FileType python set equalprg=autopep8\ -
endif
"}}}

"css html等 "{{{
au BufNewFile,BufRead *.js, *.html, *.css
            \   set tabstop=2
            \ | set softtabstop=2
            \ | set shiftwidth=2
"}}}

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
