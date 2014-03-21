---
layout: post
title: gem error - mongrel 安装失败
date: 2013-12-01 12:09:30
comments: true
categories: Gem,Ruby
---

## 概念

### Rack

1. A Rack application is an Ruby object (not a class) that responds to **call**. It takes exactly one argument, the environment and returns an Array of exactly three values: **The status**, **the headers**, and **the body**. 
2. Rack is a framework to roll your own ruby framework.
3. Rack provides an interface between different web servers and your framework/application. Making it very simple for your framework/application to be compatible with any webserver that supports Rack – Phusion Passenger, Litespeed, Mongrel, Thin, Ebb, Webrick to name a few.
4. Rack cuts your chase. You get request, response, cookies, params & sessions for free.
5. Makes it possible to use multiple frameworks for the same application, provided there is no class collision. Rails and sinatra integration is a good example of this.

### Mongrel

1. 是一种快速的针对Ruby的Http 服务器，专门为部署发布rails应用而产生的。
2. 可以替代mod_ruby/fastcgi,可以用于生产部属环境。支持集群，扩展性强。
3. 有各种丰富插件和功能扩展。
4. 它是纯Ruby写的Http 服务器，同时支持多种框架（Ruby On Rails, Camping,Og+Nitro, Iowa）。
5. Mongrel相比Rails自带的纯Ruby服务器Webrick速度快很多并支持并发访问，有望成为Ruby的Tomcat

## 安装失败

在学习Ruby On Rack时候,根据里面的实例代码是使用Mongrel启动的，但服务器上没有安装，使用gem安装Mongrel时出了错误：

    [root@allentest rb]# gem install mongrel
    Building native extensions.  This could take a while...
    ERROR:  Error installing mongrel:
            ERROR: Failed to build gem native extension.
    
            /root/.rbenv/versions/1.9.2-p180/bin/ruby extconf.rb
    checking for main() in -lc... yes
    creating Makefile
    
    make
    /usr/bin/gcc -I. -I/root/.rbenv/versions/1.9.2-p180/include/ruby-1.9.1/i686-linux -I/root/.rbenv/versions/1.9.2-p180/include/ruby-1.9.1/ruby/backward -I/root/.rbenv/versions/1.9.2-p180/include/ruby-1.9.1 -I. -I'/root/.rbenv/versions/1.9.2-p180/include'  -D_FILE_OFFSET_BITS=64  -fPIC -O3 -ggdb -Wextra -Wno-unused-parameter -Wno-parentheses -Wpointer-arith -Wwrite-strings -Wno-missing-field-initializers -Wno-long-long  -o http11.o -c http11.c
    http11.c: In function ‘http_field’:
    http11.c:77: 错误：‘struct RString’ 没有名为 ‘ptr’ 的成员
    http11.c:77: 错误：‘struct RString’ 没有名为 ‘len’ 的成员
    http11.c:77: 警告：逗号表达式的左操作数不起作用
    http11.c: In function ‘header_done’:
    http11.c:172: 错误：‘struct RString’ 没有名为 ‘ptr’ 的成员
    http11.c:172: 错误：‘struct RString’ 没有名为 ‘ptr’ 的成员
    http11.c:172: 错误：‘struct RString’ 没有名为 ‘ptr’ 的成员
    http11.c:174: 错误：‘struct RString’ 没有名为 ‘ptr’ 的成员
    http11.c:176: 错误：‘struct RString’ 没有名为 ‘ptr’ 的成员
    http11.c:177: 错误：‘struct RString’ 没有名为 ‘len’ 的成员
    http11.c: In function ‘HttpParser_execute’:
    http11.c:298: 错误：‘struct RString’ 没有名为 ‘ptr’ 的成员
    http11.c:299: 错误：‘struct RString’ 没有名为 ‘len’ 的成员
    make: *** [http11.o] 错误 1
    
    
    Gem files will remain installed in /root/.rbenv/versions/1.9.2-p180/lib/ruby/gems/1.9.1/gems/mongrel-1.1.5 for inspection.
    Results logged to /root/.rbenv/versions/1.9.2-p180/lib/ruby/gems/1.9.1/gems/mongrel-1.1.5/ext/http11/gem_make.out


## 解决方案

查了资源后发现，与我服务器上安装的`Ruby 1.9.2`版本有关，只安装预编译过的Mongrel版本，使用命令`gem install mongrel --pre`安装成功。

    [root@allentest rb]# gem install mongrel --pre
    Fetching: daemons-1.0.10.gem (100%)
    Fetching: mongrel-1.2.0.pre2.gem (100%)
    Building native extensions.  This could take a while...
    Successfully installed daemons-1.0.10
    Successfully installed mongrel-1.2.0.pre2
    2 gems installed
    Installing ri documentation for daemons-1.0.10...
    Building YARD (yri) index for daemons-1.0.10...
    Installing ri documentation for mongrel-1.2.0.pre2...
    Building YARD (yri) index for mongrel-1.2.0.pre2...
    Installing RDoc documentation for daemons-1.0.10...
    Installing RDoc documentation for mongrel-1.2.0.pre2...


## 参考

[Using Mongrel with Ruby 1.9.2](http://kevin.h-pk-ns.com/2011/08/11/using-mongrel-on-ruby-1-9-2/)
