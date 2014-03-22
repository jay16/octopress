---
layout: post
title: VMWare Error - *.vmx not valid 
date: 2013-09-01 06:01:04
comments: true
categories: error
---
## 版本

    系统版本: windows2008 x64
    VMWare:  9.0

## 起因:

  运行SQLServer2008 + Cognos10.1.1,可能内存溢出或其他原因,VMWare被卡死,强制关闭VMWare.
  启动VMWare后,点击虚拟系统启动时报错.
  
## 报错信息:

      Could not open virtual machine: *\*\*.vmx.
      "*\*\*.vmx" is not a valid virtual machine configuration file.

## 解决方法:

  第一步:删除虚拟机安装路径下的*.lck文件(夹),或剪切至新建临时文件夹.
  
  第二步:使用记事本打开*\*\*.vmx.(此时应该为空)
  
  第三步:拷贝其他正常运行虚拟机的*.vmx内容到*\*\*.vmx,并修改以下内容.

      scsi0:0.fileName = "***.vmdk"
      displayName = "display describtion"
      nvram = "***.nvram"
      extendedConfigFile = "***.vmxf" 

  使用报错虚拟机路径下的后缀名为vmdk,nvram,vmxf的文件名填写**保存!
  
  虚拟机应该可以正常启动了.

## 参考网址:

  [link](http://blog.laksha.net/2009/10/vmx-is-not-valid-virtual-machine.html)
