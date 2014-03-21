---
layout: post
title: Vim目录插件 NerdTree
date: 2013-08-22 05:39:07
comments: true
categories: Vim
---
    [root@localhost .vim]# cat /etc/issue
    CentOS release 5.9 (Final)
    Kernel \r on an \m

CentOS release 5.9有安装vi但没有vim

vim安装

    [root@localhost tools]# wget ftp://ftp.vim.org/pub/vim/unix/vim-7.3.tar.bz2
    [root@localhost tools]# tar -xjf vim-7.3.tar.bz2
    [root@localhost tools]# cd vim73/
    [root@localhost tools]# ./configure --enable-netbeans --enable-multibyte --enable-fontset --with-vim-name=vi --with-features=huge 
    [root@localhost tools]# make
    [root@localhost tools]# make install
    [root@localhost tools]# vim --version
    VIM - Vi IMproved 7.0 (2006 May 7, compiled Jan  8 2013 23:52:09)

配置nerd_tree插件

    [root@localhost tools]# cd ~/.vim
    [root@localhost tools]# mkdir bundle
    [root@localhost tools]# cd bundle
    [root@localhost bundle]# git clone https://github.com/scrooloose/nerdtree.git
    [root@localhost bundle]# cd nerdtree/
    #再安装插件把plugin下文件拷到对应~/.vim/plugin下,其他文件夹也一样
    [root@localhost nerdtree]# cp -fr * ../../

配置vim
不同linux版本,vimrc位置不同，我的是`/etc/vimrc`而不是`~/.vim/vimrc`

    [root@localhost .vim]# vi /etc/vimrc
    
    if v:lang =~ "utf8$" || v:lang =~ "UTF-8$"
       set fileencodings=utf-8,latin1
    endif
    set nocompatible        " Use Vim defaults (much better!)
    syntax on               " 语法高亮
    set cursorline          " 突出显示当前行，当前行会有下划线
    set history=50          " keep 50 lines of command line history
    set ruler               " show the cursor position all the time
    set number              " 显示行号
    set autoindent          " 自动缩进
    set smartindent         " 开启新行时使用智能自动缩进
    set shiftwidth=2        " 使用>> <<整理代码时,平移空格数
    set nowrapscan          " 禁止在搜索到文件两端时重新搜索
    set incsearch           " 输入搜索内容时就显示搜索结果
    set hlsearch            " 搜索时高亮显示被找到的文本
    set laststatus=2        " 显示状态栏 (默认值为 1, 无法显示状态栏)
    set statusline=\ %<%F[%1*%M%*%n%R%H]%=\ %y\ %0(%{&fileformat}\ %{&encoding}\ %c:%l/%L%)\
                            " 设置在状态行显示的信息
    filetype plugin indent on
                            " 依文件类型设置自动缩进
    set backspace=indent,eol,start
                            " 在Insert模式下退格键何时可以删除光标之前的字符，否则backspace无法删除
    map <F2> :NERDTreeToggle<CR>
                            " 映射F2为开户关闭NERDTreeToggle命令+回车
    map <C-p> :tabp<CR>     " 映射ctrl+p向前切换tab
    map <C-n> :tabn<CR>     " 映射ctrl+n向后切换tab
    map <C-w> :tabc<CR>     " 映射ctrl+w关闭当前tab

NerdTree与Tab命令搭配比较舒服：

    :tabnew [++opt选项] ［＋cmd］ 文件            建立对指定文件新的tab
    :tabc       关闭当前的tab
    :tabo       关闭所有其他的tab
    :tabs       查看所有打开的tab
    :tabp      前一个
    :tabn      后一个
    标准模式下：
    gt , gT 可以直接在tab之间切换。
