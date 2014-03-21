---
layout: post
title: CentOS -bash - make -command not found
date: 2013-08-24 16:47:30
comments: true
categories: 
---
## 起因

公司新在`阿里云`租了新服务器,安装配置`Ruby`时报错`-bash: make:command not found`，感叹系统太干净了吧。

    checking for if make is GNU make... ./configure: line 16019: make: command not found
    no
    config.status: creating Makefile
    ./config.status: line 1076: make: command not found
    
    [root@AY130809151541558e92Z ruby-1.9.2-p180]# make
    -bash: make: command not found
    [root@AY130809151541558e92Z ruby-1.9.2-p180]# which make
    /usr/bin/which: no make in (/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin:/root/bin)

## 解决方法

CentOS系统中安装`make`的命令:

    yum -y install gcc automake autoconf libtool make

## 参考

+ [草窟设计](http://www.yaoin.net/2011/05/25/bash-makecommand-not-found/)
