---
layout: post
title: MySQL 常用操作
date: 2013-09-08 13:10:06
comments: true
categories: [mysql,database]
---
## 备份&还原

数据库备份:

    [jay@localhost ~]$ mysqldump -uroot -ppwd databasename > /home/sql_bak.sql

数据库还原：

    [jay@localhost ~]$ mysql -uroot -ppwd newdatabasename < /home/sql_bak.sql

## 查新时间

在原有时间字段基础上加8小时

    mysql> select date_add(created_at,interval 8 hour) as dd,created_at from tags;
    +---------------------+---------------------+
    | dd                  | created_at          |
    +---------------------+---------------------+
    | 2013-06-20 10:06:29 | 2013-06-20 02:06:29 |
    | 2013-06-20 10:06:36 | 2013-06-20 02:06:36 |
    | 2013-06-20 10:06:45 | 2013-06-20 02:06:45 |
    | 2013-06-20 10:06:51 | 2013-06-20 02:06:51 |
    | 2013-06-20 10:06:57 | 2013-06-20 02:06:57 |
    | 2013-06-20 12:40:11 | 2013-06-20 04:40:11 |
    | 2013-06-20 12:40:16 | 2013-06-20 04:40:16 |

修改`created_at`字段减8小时

    update clicks set created_at = date_add(created_at,interval -8 hour) where created_at >= '2013-09-01';

## 数据物理大小

    mysql> show databases;
    +--------------------+
    | Database           |
    +--------------------+
    | information_schema | 
    | mysql              | 
    | solife_dev         | 
    | solife_test        | 
    +--------------------+
    8 rows in set (0.03 sec)
    
    #所有表数据的相关数据在information_schema数据库中
    mysql> use information_schema;
    Reading table information for completion of table and column names
    You can turn off this feature to get a quicker startup with -A
    
    Database changed
    
    #查看所有表数据大小
    mysql> select concat(round(sum(data_length/1024/1024),2),'MB') as data from tables;
    +----------+
    | data     |
    +----------+
    | 534.36MB | 
    +----------+
    1 row in set (0.91 sec)
    
    #查看某数据库表数据大小
    mysql> select concat(round(sum(data_length/1024/1024),2),'MB') as data from tables where table_schema = 'solife_dev';
    +----------+
    | data     |
    +----------+
    | 408.61MB | 
    +----------+
    1 row in set (0.00 sec)
    
    #查看某表数据大小
    mysql> select concat(round(sum(data_length/1024/1024),2),'MB') as data from tables where table_schema = 'solife_dev' and table_name='inboxes';
    +----------+
    | data     |
    +----------+
    | 408.12MB | 
    +----------+
    1 row in set (0.00 sec)

## 参考:

+ [haicang](http://haicang.blog.51cto.com/2590303/1112676)
