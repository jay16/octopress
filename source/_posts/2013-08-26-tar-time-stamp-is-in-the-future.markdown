---
layout: post
title: tar - time stamp is in the future
date: 2013-08-26 09:11:14
comments: true
categories: Linux,Shell
---
## 报错原因 

如果你在A系统上创建tar压缩文件,然后到B系统上解压,但B系统上的系统时间比A系统上的系统时间要早！也就是在解压到压缩文件中的创建时间在B系统上系统时间还没有到,就会报出下面错误：

> If you create a tar archive on system A and then try to unpack it on system B and system B's clock is behind that of system A then tar will complain.

    tar: node: time stamp 2011-06-07 02:02:30 is 8309 s in the future
    tar: user/Node: time stamp 2011-06-07 01:56:05 is 7924 s in the future

## 解决方法

解压时忽略压缩文档的创建时间,就可避免类似错误。

> If you use the -m switch to tar then it will set all of the modified times on the unpacked files to the current system time.

    # 忽略压缩文档创建时间
    -m, --touch
    
    tar -xzvfm avoid-mtime.tar.gz

## 参考

+ [tar: time stamp is in the future](http://www.chrisnewland.com/tar-time-stamp-is-in-the-future-146)
+ [Prevent showing time stamp message when running “tar xzf”](http://unix.stackexchange.com/questions/14528/prevent-showing-time-stamp-message-when-running-tar-xzf)

