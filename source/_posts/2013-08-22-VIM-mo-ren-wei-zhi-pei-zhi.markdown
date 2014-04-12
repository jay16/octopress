---
layout: post
title: VIM 默认位置配置
date: 2013-08-22 05:39:07
comments: true
categories: [vim]
---
自动启动的命令写在`$HOME/.exrc `(如果是vi)或者`$HOME/.vimrc`(如果是vim)

    [root@emd work]# echo $HOME
    /root
    [root@emd work]# vi /root/.exrc 
    :syntax on
    :set si
    :set ff=unix
    :set showmatch

> vi set用法:

    set autoindent     
    在插入模式下，对每行按与上行同样的标准进行缩进，与shiftwidth选项结合使用
    set list   
    把制表符显示为^I ,用$标示行尾（使用list分辨尾部的字符是tab还是空格）
    set number/nonumber  num/nonum
    显示行号
    set shiftwidth
    反向制表符中的空格数目
    set showmatch/noshowmatch
    在vi中输入），}时，光标会暂时的回到相匹配的（，{   （如果没有相匹配的就发出错误信息的铃声），编程时很有用
    set tabstop
    指定tab缩进的字符数目
    set wrapscan
    授索在文件的两端绕回
    set readonly
    文件只读，除非使用！可写
    set ai / noai
    让vi自动对齐.
    set tabstop=4 shiftwidth=4
    设置制表停止位(tabstop)的长度:当使用移动(shift)命令时移动的字符数
    set encoding=utf-8 
    设置编码格式
    set ff=unix 
    将文件格式转为unix格式
    set list 
    在每行的行末显示美元符号，并用Ctrl+I表示制表符 
    set window=value
    定义屏幕上显示的文本行的行数 
    set wrapmargin=value
    设置显示器的右页边。当输入进入所设置的页边时，编辑器自动回车换行 
