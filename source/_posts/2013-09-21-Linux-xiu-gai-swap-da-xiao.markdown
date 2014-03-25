---
layout: post
title: Linux 修改swap大小
date: 2013-09-21 21:38:43
comments: true
categories: [bi,oracle,linux]
---
## 修改步骤

    [root@oraclehost tools]# cd /usr/
    [root@oraclehost usr]# ls
    bin  etc  games  include  lib  lib64  libexec  local  sbin  share  src  tmp
    
    [root@oraclehost usr]# mkdir swap
    [root@oraclehost usr]# cd swap/
    
    [root@oraclehost swap]# dd if=/dev/zero of=swapfile bs=402400 count=10000
    10000+0 records in
    10000+0 records out
    4024000000 bytes (4.0 GB) copied, 113.153 s, 35.6 MB/s
    [root@oraclehost swap]# free -m
                 total       used       free     shared    buffers     cached
    Mem:          3829       3685        144          0        167       2699
    -/+ buffers/cache:        817       3011
    Swap:            0          0          0
    
    [root@oraclehost swap]# ls -al
    total 3933540
    drwxr-xr-x   2 root root       4096 Sep 21 13:31 .
    drwxr-xr-x. 14 root root       4096 Sep 21 13:30 ..
    -rw-r--r--   1 root root 4024000000 Sep 21 13:32 swapfile
    
    [root@oraclehost swap]# mkswap swapfile
    mkswap: swapfile: warning: don't erase bootbits sectors
            on whole disk. Use -f to force.
    Setting up swapspace version 1, size = 3929680 KiB
    no label, UUID=27a79094-d6b1-4f89-9a85-4fe34e4147d3
    
    [root@oraclehost swap]# swapon swapfile
    [root@oraclehost swap]# free -m
                 total       used       free     shared    buffers     cached
    Mem:          3829       3688        140          0        167       2700
    -/+ buffers/cache:        820       3009
    Swap:         3837          0       3837
    [root@oraclehost swap]# free -g
                 total       used       free     shared    buffers     cached
    Mem:             3          3          0          0          0          2
    -/+ buffers/cache:          0          2
    Swap:            3          0          3

## 转载

1. [Linux下修改swap的大小](http://moneypy.blog.51cto.com/745631/274548)
