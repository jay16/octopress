---
layout: post
title: Rails 错误 - 中文入库乱码
date: 2013-08-24 17:24:08
comments: true
categories: Rails,MySql,Error
---
## 描述

Rails搭建的网站新迁移到台湾服务器，迁移后添加的功能中向数据库(MySql)写入中文时是乱码?!，之前写好的功能入库中文是正常的，Rails log中Insert语句中的中文文字正常显示。

简单推测应该知道,原因出在程序与数据库衔接的地方。Rails代码连接数据方面应该没问题，因为迁移之前没有出现此问题。

    #config/database.yml
    development:
      adapter: mysql2
      encoding: utf8
      reconnect: false
      database: xsolife
      pool: 5
      username: root
      password: Focus_01
      host: localhost

## 修改MySql配置档

新服务器中数据库MySql的配置需要调整，编辑格式需要调整为utf-8。

修改MySql的配置文件`/etc/my.cnf`，如果没有就把`/usr/share/mysql/my-large.cnf`拷贝一份重命名`my.cnf`

    #[client]下面添加 
    ### 默认字符集为utf8 
    default-character-set=utf8 
    
    #[mysqld] 添加
    ### 默认字符集为utf8 
    default-character-set=utf8 
    ### （设定连接mysql数据库时使用utf8编码，以让mysql数据库为utf8运行） 
    init_connect='SET NAMES utf8' 

调整后需要重启MySql服务

    service mysqld restart

## 重建数据库表

但问题依然存在,说明数据库编码的属性已无法改变，需要重建,但已经存有好多数据了,只好先备份数据。

    mysqldump -uroot -ppassword database_name > export.sql

重建数据库：

    rake db:drop
    rake db:create
    rake db:migrate

重新导入数据库:

    mysql -uroot -ppassword;
    use database_name;
    
    source /path/export.sql

再测试新功能插入中文,一切正常了。
