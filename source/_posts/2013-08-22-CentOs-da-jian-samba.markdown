---
layout: post
title: CentOs 搭建samba
date: 2013-08-22 05:39:07
comments: true
categories: [bash,bi,mysql,centos,linux,mac,html]
---
> 搭建samba服务器端

    1.1
    #需要root权限
    
    Last login: Thu Jun 20 19:24:32 2013 from 192.168.0.105
    [jay@localhost ~]$ su root
    Password: 
    
    1.2 
    #查看是否安装samba
    #安装samba服务端命令 yum -y install samba
    #安装samba客户端命令 yum -y install samba-client
    
    [root@localhost ~]# rpm -qa | grep samba
    system-config-samba-1.2.41-5.el5
    samba-client-3.0.33-3.39.el5_8
    samba-3.0.33-3.39.el5_8
    samba-common-3.0.33-3.39.el5_8
    
    1.3 
    #查看samba服务状态
    
    [root@localhost jay]# service smb status
    smbd is stopped
    nmbd is stopped
    
    #启动samba服务
    
    [root@localhost jay]# service smb start
    Starting SMB services: [  OK  ]
    Starting NMB services: [  OK  ]
    
    1.4 
    #检查samba配置文件是否OK
    
    [root@localhost jay]# testparm
    Load smb config files from /etc/samba/smb.conf
    Processing section "[homes]"
    Processing section "[printers]"
    Loaded services file OK.
    Server role: ROLE_STANDALONE
    Press enter to see a dump of your service definitions
    
    [global]
            workgroup = MYGROUP
            server string = Samba Server Version %v
            passdb backend = tdbsam
            cups options = raw
    
    [homes]
            comment = Home Directories
            read only = No
            browseable = No
    
    [printers]
            comment = All Printers
            path = /var/spool/samba
            printable = Yes
            browseable = No
    
    1.5 
    #添加samba用户
    
    [root@localhost jay]# useradd samba
    bash: useradd: command not found
    [root@localhost jay]# whereis useradd
    useradd: /usr/sbin/useradd /usr/share/man/man8/useradd.8.gz
    [root@localhost jay]# /usr/sbin/useradd samba
    [root@localhost jay]# passwd samba
    Changing password for user samba.
    New UNIX password: 
    BAD PASSWORD: it is based on a dictionary word
    Retype new UNIX password: 
    passwd: all authentication tokens updated successfully.
    
    1.6 
    #配置samba用户为共享下载区管理者
    #-a 添加用户 -x 删除用户 -d 禁用用户
    
    [root@localhost jay]# smbpasswd -a samba
    New SMB password:
    Retype new SMB password:
    Added user samba.
    
    1.6.1 
    #samba服务配置文件位置/etc/samba
    
    [root@localhost samba]# tail /etc/samba/smb.conf 
    
    # A publicly accessible directory, but read only, except for people in
    # the "staff" group
    ;       [public]
    ;       comment = Public Stuff
    ;       path = /home/samba
    ;       public = yes
    ;       writable = yes
    ;       printable = no
    ;       write list = +staff
    [root@localhost samba]# 
    
    1.7 
    #配置samba后，重启samba服务
    
    [root@localhost jay]# service smb restart
    Shutting down SMB services: [  OK  ]
    Shutting down NMB services: [  OK  ]
    Starting SMB services: [  OK  ]
    Starting NMB services: [  OK  ]
    
    1.8 
    #进入samba用户文件夹
    
    [root@localhost jay]# cd /home/samba/
    [root@localhost samba]# ls
    
    [root@localhost samba]# ls -A 
    .bash_logout  .bash_profile  .bashrc  .emacs
    
    1.8.1 
    #添加mysamba.txt,提供下载
    
    [root@localhost samba]# echo "hello samba" > mysamba.txt
    [root@localhost samba]# ls
    mysamba.txt
    [root@localhost samba]# 
    
    1.9
    #若在windows上查看，打开[我的电脑]在地址栏中输入 \samba服务器ip\samba 即可查看

>参考
+ [在linux上安装配置samba服务器](http://publish.it168.com/2007/0629/20070629156203.shtml)

> linux访问Linux samba共享区

    2.1
    #切换为root用户
    
    Last login: Thu Jun 20 22:58:29 2013 from 101.85.241.205
    [jay@emd ~]$ su root
    密码：
    
    2.2
    #安装samba服务端
    
    [root@emd jay]# service smb status
    smb: 未被识别的服务
    
    [root@emd jay]# rpm -qa | grep samba
    
    [root@emd jay]# yum -y install samba
    
    [root@emd jay]# rpm -qa | grep samba
    samba-winbind-clients-3.6.9-151.el6.i686
    samba-common-3.6.9-151.el6.i686
    samba-winbind-3.6.9-151.el6.i686
    samba-3.6.9-151.el6.i686
    
    [root@emd jay]# service smb status
    smbd 已停
    [root@emd jay]# service smb start
    启动 SMB 服务：[确定]
    
    2.3
    #安装samba客户端
    
    [root@emd jay]# smbclient //192.168.0.187/samba -U samba%Samba_01
    bash: smbclient: command not found
    [root@emd jay]# whereis smbclient
    smbclient:
    
    [root@emd jay]# yum -y install samba-client
    [root@emd jay]# service smb restart
    关闭 SMB 服务：[确定]
    启动 SMB 服务：[确定]
    
    2.3.1
    #使用smbclient登陆其他linux samba共享区
    #格式：smbclient //samba-server-ip/share-dir -U user-name%user-pwd
    
    [root@emd jay]# smbclient //192.168.0.187/samba -U samba%Samba_01
    Domain=[MYGROUP] OS=[Unix] Server=[Samba 3.0.33-3.39.el5_8]
    smb: \> ls
      .                                   D        0  Fri Jun 21 09:55:06 2013
      ..                                  D        0  Fri Jun 21 09:43:45 2013
      .emacs                              H      515  Fri Jun 21 09:43:45 2013
      mysamba.txt                                 12  Fri Jun 21 09:55:06 2013
      .bashrc                             H      124  Fri Jun 21 09:43:45 2013
      .bash_profile                       H      176  Fri Jun 21 09:43:45 2013
      .bash_logout                        H       33  Fri Jun 21 09:43:45 2013
    
                    50362 blocks of size 262144. 23083 blocks available
    smb: \> 
    
    2.4.1
    #get 取回一个文件，put 向ftp服务器传文件
    #get [OPTS] <rfile> [-o <lfile>]
    
    smb: \> get mysamba.txt -o /home/jay/
    getting file \mysamba.txt of size 12 as -o (3.9 KiloBytes/sec) (average 1.2 KiloBytes/sec)
    
    2.4.2
    #put [OPTS] <lfile> [-o <rfile>]
    
    smb: \> put /home/jay/sh/mysql_bk.sh mysql.sh
    putting file /home/jay/sh/mysql_bk.sh as \mysql.sh (570.0 kb/s) (average 180.0 kb/s)
    smb: \> ls
      .                                   D        0  Fri Jun 21 10:48:15 2013
      ..                                  D        0  Fri Jun 21 09:43:45 2013
      .emacs                              H      515  Fri Jun 21 09:43:45 2013
      mysamba.txt                                 12  Fri Jun 21 09:55:06 2013
      .bashrc                             H      124  Fri Jun 21 09:43:45 2013
      mysql.sh                            A     1751  Fri Jun 21 10:48:15 2013
      .bash_profile                       H      176  Fri Jun 21 09:43:45 2013
      .bash_logout                        H       33  Fri Jun 21 09:43:45 2013
      -o                                  A     1751  Fri Jun 21 10:47:45 2013
    
                    50362 blocks of size 262144. 23130 blocks available
    smb: \> 
    smb: \> exit
    
    2.4.3
    #查看下载到本地的samba.txt
    
    [root@emd jay]# pwd
    /home/jay
    [root@emd jay]# cat mysamba.txt 
    hello samba
