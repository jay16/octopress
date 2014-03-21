---
layout: post
title: PL/SQL Developer ERROR - Dynamic Performance Tables not accessible
date: 2013-09-11 01:43:07
comments: true
categories: PLSQL
---
## 现象描述

  在SQL Window编辑器中点击视图或表名,右键选择[**Query Data**]或按**F8**执行代码时,会弹出报错提示窗口。


报错信息:

      Dynamic Performance Tables not accessible,Automatic Statistics disabled for this session
      You can disable statistics in the preference menu, or obtain select priviliges on the V$session,V$sesstat and V$statname tables

## 解决原理

  从上面详细的报错提示信息中我们可以判断得到，报错原因不在工具本身。

  推荐使用的方法: **配置PL/SQL Developer禁掉该功能**。

## 解决步骤

  1. 导航到**Tools** --> **Preferences** --> --> **Oracle** --> **Options**
  2. 找到**Automatic Statistics**选项，将其前面的小对勾去掉，然后点击**Apply**和**OK**保存退出。

## 参考

  [secooler快乐的DBA](http://space.itpub.net/519536/viewspace-614671)
  
