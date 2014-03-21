---
layout: post
title: LInux 开机启动
date: 2013-09-01 05:42:29
comments: true
categories: Linux,开机启动
---

设置某些服务或程序开机启动，以避免服务器莫名关机或重启后还要人工手动启动

    [root@localhost sh]# cat /etc/rc.local 
    #!/bin/sh
    #
    # This script will be executed *after* all the other init scripts.
    # You can put your own initialization stuff in here if you don't
    # want to do the full Sys V style init stuff.
    
    touch /var/lock/subsys/local
    
    #启动mysql服务
    
    /sbin/service mysqld start
    
    #启动防火墙设置
    
    /bin/sh /home/jay/sh/iptables.rule
    
    #启动redis -- 必须在resque启动之前
    
    cd /home/tools/redis-2.4.16
    redis-server /etc/redis.conf 
    
    #启动FocusMail Rails主程序 -- 使用webmail用户权限启动
    
    cd /home/work/focus_mail
    passenger start -p 80 --user webmail -d
    
    #启动resque
    #须进入FocusMail Rails主程序路径
    #使用webmail用户权限启动
    
    su - webmail -c "cd /home/work/focus_mail && /bin/sh focus_mail_resquework.sh"
