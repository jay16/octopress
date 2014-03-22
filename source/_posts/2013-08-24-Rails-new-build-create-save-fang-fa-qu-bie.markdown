---
layout: post
title: Rails  - new, build, create, save方法区别
date: 2013-08-24 16:54:39
comments: true
categories: other
---
## 概述

| 方法名 | 关系与区别 |
|-------|:-------------------------------------------------------------------------|
| save   | rails中的save其实是create_or_update，新建或修改记录！不一定是新建，切记 |
| new    | 只是在内存中新建一个对象，操作数据库要调用save方法。 |
| create | = new + 执行sql。 |
| build  | 与new基本相同，多用于一对多情况下。 |
| !      | 区别是带!的方法会执行validate，如果验证失败会抛出导常。 |
| 注意    | save实例方法，而create, build, new是模型类的类方法  |


## 使用示例

设：Article与Comment是一对多关系

    @article = Article.new(params[:article])
    @article.save


**new后要调用save才会操作数据库**

注意:`Article.build(params[:article])`会报错，build不能这样用。

    # 会直接在数据库里插入一条记录
    @article = Article.create(params[:article])


    # 与new方法基本一样，有人说build会自动设置外键值，测试时发现build和new都可以设置外键
    @comment = @article.comments.build

    # 如果你处理一个“has_one”一对一关系时，这样写：
    @profile = @user.build_profile

## 转载

* [Ruby迷](http://rubyer.me/blog/262/)
