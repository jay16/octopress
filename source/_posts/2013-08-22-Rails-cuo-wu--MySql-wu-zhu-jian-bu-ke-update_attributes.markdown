---
layout: post
title: Rails 错误 - MySql 无主键不可update_attributes
date: 2013-08-22 05:39:09
comments: true
categories: Ruby,Error,Rails,MySql
---
## 起因

项目中手工在MySql数据库中添加了dog_data表,又手工创建了model文件,没有设置自增id主键,结果导致使用`update_attributes`时报出`Unknown column`错误,再手工给dog_data表添加自增id主键后,一切正常。

## 总结教训:

1. 使用rails命令规范添加&修改数据库信息
2. 手工作业的话要做完整,在对rails规范充分了解的前堤下


      dog = DogData.find_by_campaign_id(campaign_id)
      dog.update_attributes({:send_num => send_num,:send_ok => send_ok})

    Mysql2::Error: Unknown column 'dog_data.id' in 'where clause': UPDATE `dog_data` SET `send_num` = 5 WHERE `dog_data`.`id` IS NULL

    mysql> alter table dog_data add id int unsigned primary key auto_increment;
