---
layout: post
title: Cognos Error - RQP-DEF-0182 
date: 2013-08-24 17:39:16
comments: true
categories: Error,Cognos
---
## 报错信息

    RQP-DEF-0182 
    The queries for the set operation are incompatible.

## 报表描述

多个`数据项`(data item)名称及顺序都相同的`查询`(query)`拼接`(union)成新的查询,右键点击`查看列表数据`(View Tabular Data)或直接运行报表(报表中有展示该拼接查询),就会报出上述错误.

## 错误原因:

1. 被`拼接`(union)的`查询`(query)中`数据项`(data item)名称或顺序不一一对应.(这个可以在本报表中排除)
2. 满足1条件后,查询中的`数据项`(data item)数量不同.(排除)
3. 满足1,2条件后,查询中的`数据项`(data item)对应列中格式不一致.(就是这点)

## 解决方法

本报表中某一列是日期格式,但有具体日期,月日期,周日期,能保证的是转化为字符串后都是日期字符串,每个`数据项(da`ta item)可能为Date,Timestamp或String,**最省事但费体力的解决方法是在该列数据项(data item)的定义中都统一转化为同一日期格式:cast([sales data],timestamp)**


## 参考

[ibm论坛](https://www-304.ibm.com/support/docview.wss?uid=swg21338754)
