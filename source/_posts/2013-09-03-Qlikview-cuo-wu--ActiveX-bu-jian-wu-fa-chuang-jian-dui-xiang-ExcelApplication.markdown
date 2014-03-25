---
layout: post
title: Qlikview 错误 - ActiveX部件无法创建对象 -"Excel.Application“
date: 2013-09-03 09:52:13
comments: true
categories: [error,qlikview,mac]
---
## 描述

在使用qlikview开发报表过程中,使用`macro modul`把报表数据写入Excel,执行时报错: **ActiveX部件无法创建对象:"Excel.Application“**

## 原因&解决方法


把数据写入Excel即操作系统文件,在qlikview中是有权限限制的,默认权限是`Only Safe Mode`,是无法权限创建新文件的。

编辑代码左侧有设置系统安全级别选项,设置为**允许访问系统**即可解决问题

## 截图

![dd](/photos/bo-wen-tu-pian_at_20130831172402/20130903174931-qlikview-errorActiveX-Create-FailsPNG.PNG)

## 参考

[ActiveX component can't create object: 'Excel.Application' error on IE](http://community.qlikview.com/thread/20948)
