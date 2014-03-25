---
layout: post
title: Ruby 命令开关
date: 2013-08-22 05:39:08
comments: true
categories: [ruby,oracle]
---
**Ruby**表示**语言**,**ruby**表示**解释器。**

Ruby命令开关:

  命令行       | 描述                                    | 例子
---------------|:---------------------------------------|:----------------  
   -c          | 不执行程序,只检查语法是否正确             | ruby -c learn.rb
   -w          | 执行过程中给出warning信息                | ruby -w learn.rb
   -e          | 执行在命令行中引号内的代码                | ruby -e 'puts "hello world"'
   -v          | 显示Ruby版本信息,在verbose模式下执行程序  | ruby -v
   -l          | line模式,若没有换行则在每行输出后输出换行  | ruby -l -e 'print "hello world"'
   -r name      | 加载指定扩展(require)                  | ruby -r name
   --version   | 显示Ruby版本信息                        | ruby --version 

###### 检查rb语法是否正确

    [root@oracle11g work]# ruby -cw dd.rb       
    Syntax OK
