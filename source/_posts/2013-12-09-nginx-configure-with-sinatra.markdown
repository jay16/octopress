---
layout: post
title: nginx 浏览器[连接重置]
date: 2013-12-09 10:03:16
comments: true
categories: [error,html,nginx]
---

## 上下文环境

使用sinatra搭了个简单的日志管理平台，由于在甲方公司网络受限，只能访问80端口的链接，为了调试，只好挂在xsolife.com的子域名focusdog.xsolife.com上.

需要说明白的是在godaaay注册的xsolife.com域名没有备案，之所以现在可以正常访问，因为运行xsolife.com代码的服务器在台湾。而我使用sinatra搭建的代码运行在阿里云服务器，是大陆的，问题就出来了。

ping域名focusdog.xsolfe.com,跳转到的ip是对的;使用浏览器加载时，查看nginx日志，显示也有访问记录，但浏览器显示**连接重置**，

由于之前没有在nginx上为sinatra配置过，我一直认为是自己的配置信息有误，在网上查阅资料，也没发现问题。

## 备案域名

由于问题一直卡在最边缘，无奈向同事请教，描述问题现象。同事给了解答，是由于域名未备案，服务器又运行在大陆，域名访问被大陆防火墙挡了，从公司拿了个备过案的域名，再访问，一切正常....

原来搞技术的，也有必要了解一下政治呀？！

xsolife.com代码运行的是公司服务器，公司有意向把服务器从台湾内迁回阿里云。xsolife.com将何去何从: 备案? 太麻烦。租用国外服务器，要废钱。


### nginx 配置

sinatra在nginx配置是ok的，贴在这里，以备自己或他人参考。
  
        #focusmail log
        server {
            listen 80;
            server_name focusdog.xsolife.com;
            #下面日志文件[可选]
            access_log  /mnt/work/etl/focus_dog/log/access.log;
            error_log   /mnt/work/etl/focus_dog/log/error.log;
    
            location / {
              #需要创建public文件夹
              root /mnt/work/etl/focus_dog/public;
              passenger_enabled on;
              index  index.html index.htm;
    
              proxy_set_header        Host            $host;
              proxy_set_header        X-Forwarded-For $proxy_add_x_forwarded_for;
            }
        }   

## 参考

[Nginx 配置重复项引发的一个服务器内部错误](http://blog.sina.com.cn/s/blog_549212ae01009hej.html)
