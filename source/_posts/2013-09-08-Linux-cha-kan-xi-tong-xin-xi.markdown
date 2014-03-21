---
layout: post
title: Linux - 查看系统信息
date: 2013-09-08 07:35:29
comments: true
categories: Linux,lsb_release
---
## 系统内核

### 1. `cat /proc/version`

    [root@AY130809151541558e92Z jvm]# cat /proc/version
    Linux version 2.6.32-279.el6.x86_64 (mockbuild@c6b9.bsys.dev.centos.org) (gcc version 4.4.6 20120305 (Red Hat 4.4.6-4) (GCC) ) #1 SMP Fri Jun 22 12:19:21 UTC 2012

### 2. uname

    [root@AY130809151541558e92Z ~]# uname -a
    Linux AY130809151541558e92Z 2.6.32-279.el6.x86_64 #1 SMP Fri Jun 22 12:19:21 UTC 2012 x86_64 x86_64 x86_64 GNU/Linux

## 系统版本

### 1. lsb_release
    [root@AY130809151541558e92Z ~]# lsb_release -i
    Distributor ID: CentOS
    [root@AY130809151541558e92Z ~]# lsb_release -d
    Description:    CentOS release 6.3 (Final)
    [root@AY130809151541558e92Z ~]# lsb_release -r
    Release:        6.3

### 2. /etc/issue

    [root@AY130809151541558e92Z ~]# cat /etc/issue
    CentOS release 6.3 (Final)
    Kernel \r on an \m

### 3. /etc/redhat-release

    [root@AY130809151541558e92Z ~]# cat /etc/redhat-release
    CentOS release 6.3 (Final)

## 系统位数

    [root@AY130809151541558e92Z ~]# lsb_release -s
    :base-4.0-amd64:base-4.0-noarch:core-4.0-amd64:core-4.0-noarch:graphics-4.0-amd64:graphics-4.0-noarch:printing-4.0-amd64:printing-4.0-noarch

    [root@AY130809151541558e92Z jvm]# file /bin/ls
    /bin/ls: ELF 64-bit LSB executable, x86-64, version 1 (SYSV), dynamically linked (uses shared libs), for GNU/Linux 2.6.18, stripped

## lsb_release

>  lsb_release v2.0 prints certain LSB (Linux Standard Base) and Distribution information

> 即查看发行版、版本号等详细信息;通过查看cat /etc/issue文件得到发行版信息

  
### 安装

  有些系统上不一定安装了这个命令,安装lsb_release命令

    [root@emd jay]# yum install  -y redhat-lsb

### 用法

    [root@AY130809151541558e92Z ~]# lsb_release -h
    FSG lsb_release v2.0 prints certain LSB (Linux Standard Base) and
    Distribution information.
    
    Usage: lsb_release [OPTION]...
    With no OPTION specified defaults to -v.
    Options:
      -v, --version
        Display the version of the LSB specification against which the distribution is compliant.
      -i, --id
        Display the string id of the distributor.
        显示发行版id
      -d, --description
        Display the single line text description of the distribution.
        显示发行版本描述,显示形式为一行
      -r, --release
        Display the release number of the distribution.
        显示发行版的发行号
      -c, --codename
        Display the codename according to the distribution release.
        显示发行版的代号
      -a, --all
        Display all of the above information.
        显示上述所有参数显示的信息
      -s, --short
        Use short output format for information requested by other options (or version if none).
        显示短格式
    
    [root@AY130809151541558e92Z ~]# lsb_release -a
    LSB Version:    :base-4.0-amd64:base-4.0-noarch:core-4.0-amd64:core-4.0-noarch:graphics-4.0-amd64:graphics-4.0-noarch:printing-4.0-amd64:printing-4.0-noarch
    Distributor ID: CentOS
    Description:    CentOS release 6.3 (Final)
    Release:        6.3
    Codename:       Final

## uname

> uname用来获取电脑和操作系统的相关信息。

    [root@AY130809151541558e92Z ~]# uname --help
    Usage: uname [OPTION]...
    Print certain system information.  With no OPTION, same as -s.
    
      -a, --all                print all information, in the following order,
                               except omit -p and -i if unknown:
                               详细输出所有信息，依次为内核名称，主机名，内核版本号，内核版本，硬件名，处理器类型，硬件平台类型，操作系统名称
      -s, --kernel-name        print the kernel name
                               显示linux(内核名称)
      -n, --nodename           print the network node hostname
                               显示主机在网络节点上的名称或(主机名称)
      -r, --kernel-release     print the kernel release
                               显示linux操作系统(内核版本号)
      -v, --kernel-version     print the kernel version
                               显示显示操作系统是第几个(version版本)
      -m, --machine            print the machine hardware name
                               显示主机的(硬件(CPU)名)
      -p, --processor          print the processor type or "unknown"
                               显示(处理器类型)或unknow
      -i, --hardware-platform  print the hardware platform or "unknown"
                               显示(硬件平台类型)或unknown
      -o, --operating-system   print the operating system
                               显示(操作系统名)
      --help                   display this help and exit
      --version                output version information and exit
    
    [root@AY130809151541558e92Z ~]# uname -a
    Linux AY130809151541558e92Z 2.6.32-279.el6.x86_64 #1 SMP Fri Jun 22 12:19:21 UTC 2012 x86_64 x86_64 x86_64 GNU/Linux
    [root@AY130809151541558e92Z ~]# uname -s
    Linux
    [root@AY130809151541558e92Z ~]# uname -n
    AY130809151541558e92Z
    [root@AY130809151541558e92Z ~]# uname -r
    2.6.32-279.el6.x86_64
    [root@AY130809151541558e92Z ~]# uname -v
    #1 SMP Fri Jun 22 12:19:21 UTC 2012
    [root@AY130809151541558e92Z ~]# uname -m
    x86_64
    [root@AY130809151541558e92Z ~]# uname -p
    x86_64
    [root@AY130809151541558e92Z ~]# uname -i
    x86_64
    [root@AY130809151541558e92Z ~]# uname -o
    GNU/Linux
    [root@AY130809151541558e92Z ~]# 



## 参考

[如何查看linux版本、内核版本、系统位数（32位OR64位）](http://blog.sina.com.cn/s/blog_4b856bcb0101e42s.html)
