---
layout: post
title: CentOS - 搭建samba服务
date: 2013-09-01 06:28:59
comments: true
categories: linux
---
    1.1
    #需要root权限 
    #查看是否安装samba
    #安装samba服务端命令 yum -y install samba
    #安装samba客户端命令 yum -y install samba-client
    
    [root@localhost ~]# rpm -qa | grep samba
    system-config-samba-1.2.41-5.el5
    samba-client-3.0.33-3.39.el5_8
    samba-3.0.33-3.39.el5_8
    samba-common-3.0.33-3.39.el5_8
    
    1.2
    #查看samba服务状态
    
    [root@localhost jay]# service smb status
    smbd is stopped
    nmbd is stopped
    
    #启动samba服务相关命令
    service smb start
    service smb stop
    service smb restart
    service smb status
    
    1.3
    #添加samba用户(/etc/passwd必须有该用户)
    
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
    
    1.4
    #配置samba用户为共享下载区管理者
    #-a 添加用户 -x 删除用户 -d 禁用用户
    #旧用法:
    
    [root@localhost jay]# smbpasswd -a samba
    New SMB password:
    Retype new SMB password:
    Added user samba.
    
    新用法:
    [root@localhost jay]# pdbedit -a webmail
    new password:
    retype new password:
    Unix username:        webmail
    NT username:          
    Account Flags:        [U          ]
    User SID:             S-1-5-21-2382617105-2143977179-3272205118-1001
    Primary Group SID:    S-1-5-21-2382617105-2143977179-3272205118-513
    Full Name:            
    Home Directory:       \localhost\webmail
    HomeDir Drive:        
    Logon Script:         
    Profile Path:         \localhost\webmail\profile
    Domain:               LOCALHOST
    Account desc:         
    Workstations:         
    Munged dial:          
    Logon time:           0
    Logoff time:          never
    Kickoff time:         never
    Password last set:    Wed, 24 Jul 2013 10:25:14 CST
    Password can change:  Wed, 24 Jul 2013 10:25:14 CST
    Password must change: never
    Last bad password   : 0
    Bad password count  : 0
    Logon hours         : FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
    
    1.5
    #samba服务配置文件位置/etc/samba
    
    [root@localhost samba]# vim /etc/samba/smb.conf 
    
    #修改
    [global]
            workgroup = WORKGROUP
            security = user
    #追加内容
    [mypublic]
            comment = Share for Users
            path = /home/samba/mypublic
            public = yes
            writeable = yes
    
    
    1.6
    #检查samba配置文件是否OK
    
    [root@localhost jay]# testparm
    Load smb config files from /etc/samba/smb.conf
    
    1.7
    #配置samba后，重启samba服务
    
    [root@localhost jay]# service smb restart
    Shutting down SMB services: [  OK  ]
    Shutting down NMB services: [  OK  ]
    Starting SMB services: [  OK  ]
    Starting NMB services: [  OK  ]
    
    1.8
    #若在windows上查看，打开[我的电脑]在地址栏中输入 \samba服务器ip\ 即可查看
    #若在linux查看共享,挂载到本地
     mount -t cifs -o username=samba,password=Samba_01 //192.168.0.187/mypublic /home/samba
     smbclient //192.168.0.187/mypublic -U samba%Samba_01
    
    1.9
    #注意事项
    1. 共享目录权限必须是目录不可以是文本
    2. 共享目录属性最简单设置chmod 777 /home/mypublic

## 参考链接

1. http://linux.vbird.org/linux_server/0370samba.php#server_pkg
2. http://publish.it168.com/2007/0629/20070629156203.shtml
3. http://www.lishiming.net/study/23.htm
4. http://www.suse.url.tw/sles10/lesson14.htm
