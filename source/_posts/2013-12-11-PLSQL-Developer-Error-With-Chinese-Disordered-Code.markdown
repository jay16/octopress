---
layout: post
title: PL/SQL Developer ERROR - 中文乱码
date: 2013-12-11 14:20:45
comments: true
categories: Error,Oracle
---
## 现象描述:

   Oracle数据库表中存储有中文,使用PL/SQL Developer客户端查看时显示乱码,具体显示为问号**?**。


## 解决原理:

   设置本地客户端处可查看中文编码。

## 解决方法:

### **查看服务器端编码格式:**

      --查看本地用户系统变量中编码格式
      --若要正常显示中文须设置为SIMPLIFIED CHINESE_CHINA.ZHS16GBK
      select userenv('language') from dual;
      select * from v$nls_parameters; 

  
### **设置客户端与服务器相同的编码格式:**

      #我的电脑->右键属性->高级->环境变量->添加[系统变量]
      LANG=zh_CN.GBK
      NLS_LANG=SIMPLIFIED CHINESE_CHINA.ZHS16GBK
    
      #设置系统变量后无需要重启就让它生效
      #原理:会触发系统变量的刷新,详细在附注
      E:\ETL>echo %LANG%
      %LANG%
      E:\ETL>set LANG=zh_CN.GBK
      E:\ETL>set NLS_LANG=SIMPLIFIED CHINESE_CHINA.ZHS16GBK
      E:\ETL>echo %LANG%
      zh_CN.GBK
      E:\ETL>echo %NLS_LANG%
      SIMPLIFIED CHINESE_CHINA.ZHS16GBK


### PL/SQL Developer设置并重新连接:[可选择]
   
   配置pl/sql developer的菜单

   + tools -> preferences -> user interface -> fonts      中选择为**中文字体**
   + tools -> preferences -> user interface -> appearence 中选择为**中文字体**


## 附:Windows

> **附:让环境变量生效不需重启Windows**

>`先到我的电脑>属性>高级>环境变量，添加新环境变量或修改已有的环境变量，然后运行“DOS命令提示符”或run cmd，假设要修改PATH变量，不管PATH的原值是什么，在DOS窗口直接把PATH修改为任意值，关闭DOS窗口，这时，我的电脑>属性>高级>环境变量里PATH已经在Windows全局生效了。

> 不用担心在DOS窗口的修改会影响我的电脑>属性>高级>环境变量里的修改，DOS窗口的环境变量只是Windows环境变量的一个副本，副本的改动不会影响正本，但会触发正本的刷新，这正是我想要的——让环境变量生效。`


## 参考

1. [奋斗ing](http://dw008.blog.51cto.com/2050259/934741)
2. [pl/sql developer LANG Pack](http://www.allroundautomations.com/plsqldevlang/90/index.html)
3. [让环境变量生效不需重启](http://blog.goods-pro.com/146/%E8%AE%A9%E7%8E%AF%E5%A2%83%E5%8F%98%E9%87%8F%E7%94%9F%E6%95%88%E4%B8%8D%E9%9C%80%E9%87%8D%E5%90%AFwindows/)
