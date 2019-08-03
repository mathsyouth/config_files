"修改缩进宽度为4个空格
set shiftwidth=4

"每次点击 Tab 键，增加的缩进将被转化为4个空格
set tabstop=4
set softtabstop=4
"用来控制是否将 Tab 键转化为空格
set expandtab

set nu

"highlight all search matches
set hlsearch

"自动语法高亮
syntax on

"不与 Vi 兼容
set nocompatible

"在底部显示，当前处于命令模式还是插入模式
set showmode

"命令模式下，在底部显示，当前键入的指令
set showcmd

"使用 utf-8 编码
set encoding=utf-8

"启用256色
set t_Co=256

"光标所在的当前行高亮
set cursorline

"设置行宽，即一行显示多少个字符
set textwidth=80

"自动折行，即太长的行分成几行显示
set wrap

"光标遇到圆括号、方括号、大括号时，自动高亮对应的另一个圆括号、方括号和大括号
set showmatch

"输入搜索模式时，每输入一个字符，就自动跳到第一个匹配的结果
set incsearch

"Vim 需要记住多少次历史操作
set history=1000

"如果行尾有多余的空格（包括 Tab 键），该配置将让这些空格显示成可见的小方块
set listchars=trail:■

"enable folding
set foldenable

"每次打开vim就可以直接使用cscope
if filereadable("cscope.out")
    cs add cscope.out
endif

"利用相应的快捷键进行不同的查找
if has("cscope")
    set cscopetag   "使支持用 Ctrl+]  和 Ctrl+t 快捷键在代码间跳来跳去
    "check cscope for definition of a symbol before checking ctags:
    "set to 1 if you want the reverse search order.
    set csto=1

    "add any cscope database in current directory
    if filereadable("cscope.out")
        cs add cscope.out
    "else add the database pointed to by environment variable
    elseif $CSCOPE_DB !=""
        cs add $CSCOPE_DB
    endif

    "show msg when any other cscope db added
    set cscopeverbose

    nmap <C-/>s :cs find s <C-R>=expand("<cword>")<CR><CR>
    nmap <C-/>g :cs find g <C-R>=expand("<cword>")<CR><CR>
    nmap <C-/>c :cs find c <C-R>=expand("<cword>")<CR><CR>
    nmap <C-/>t :cs find t <C-R>=expand("<cword>")<CR><CR>
    nmap <C-/>e :cs find e <C-R>=expand("<cword>")<CR><CR>
    nmap <C-/>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
    nmap <C-/>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
    nmap <C-/>d :cs find d <C-R>=expand("<cword>")<CR><CR>
endif
