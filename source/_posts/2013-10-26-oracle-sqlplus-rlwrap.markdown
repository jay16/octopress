---
layout: post
title: oracle sqlplus - rlwrap
date: 2013-10-26 18:14:27
comments: true
categories: [bash,bi,oracle,centos,linux,vim]
---
## 事情起因

linux上通过sqlplus操作oracle很不方便，主要就是退格键还有上下键不可用,代码输入错误就需要再输入一遍！^~^

原因: **由于oracle的sqlplus不使用GNU的readline库造成的.**

## 解决方法

> rlwrap is a wrapper that uses the GNU readline library to allow the editing of keyboard input for any other command

## 安装rlwrap

系统版本

    [root@allentest solife]# lsb_release -a
    Distributor ID: CentOS
    Description:    CentOS release 5.6 (Final)
    Release:        5.6
    Codename:       Final

安装readline组件

    [root@oracle11g rlwrap-0.37]# rpm -qa|grep readline
    readline-5.1-3.el5
    [root@oracle11g rlwrap-0.37]# yum install readline-devel

安装 rlwrap

    [root@oracle11g tools]# wget utopia.knoware.nl/~hlub/uck/rlwrap/rlwrap-0.37.tar.gz
    [root@oracle11g tools]# tar -xzvf rlwrap-0.37.tar.gz 
    [root@oracle11g tools]# cd rlwrap-0.37
    [root@oracle11g rlwrap-0.37]# ./configure 
    [root@oracle11g rlwrap-0.37]# make 
    [root@oracle11g rlwrap-0.37]# make check
    [root@oracle11g rlwrap-0.37]# make install
    [root@oracle11g rlwrap-0.37]# whereis rlwrap
    rlwrap: /usr/local/bin/rlwrap
    [root@oracle11g rlwrap-0.37]# which rlwrap
    /usr/local/bin/rlwrap


设别名并加入到oracle用户的环境变量中(/home/oracle为$ORACLE_BASE)

    [root@oraclehost ~]# su oracle
    [oracle@oraclehost root]$ vi ~/.bashrc 
    #添加内容 
    alias sqlplus='rlwrap sqlplus'
    #使变量生效
    [oracle@oraclehost root]$ source ~/.bashrc 
    #查看别名列表
    [oracle@oraclehost root]$ alias
    alias sqlplus='rlwrap sqlplus'
    alias vi='vim'

现在再使用`sqlplus`写`sql`代码时就可以使用退格键清除代码了。
