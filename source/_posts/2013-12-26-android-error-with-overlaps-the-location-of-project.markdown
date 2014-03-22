---
layout: post
title: android error -  overlaps the location 
date: 2013-12-26 23:45:34
comments: true
categories: other
---
## 现场再现

new -> android project -> create project from exist source 或 file -> import 时出现如下错误信息：

    Invalid project description
    ------>detail: ->>> xxxx(project path) overlaps the location of another project: 'xxxx'

最后发现时我把源码把放到了workspace目录下了的原因导致的。

eclipse插件在创建项目的时候需要在workspace目录下创建一个同名的目录。

但发现workspace目录下已存在对应的目录时，就会报上面的处错误信息了。

## 解决方案

解决办法很简单，就是将源码包移到非workspace目录下。

## 参考

[解决eclipse中overlaps the location of another project: 'xxxx'](http://longshuai2007.blog.163.com/blog/static/1420944142011714309608/)
