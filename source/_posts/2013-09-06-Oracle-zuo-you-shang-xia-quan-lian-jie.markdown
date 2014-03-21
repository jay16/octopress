---
layout: post
title: Oracle - 左右、上下全连接
date: 2013-09-06 08:30:30
comments: true
categories: DataBase,Oracle
---
## 概述

1. 连接主要分**内连接**与**外连接**两大类。

2. **外连接**中又分**左连接**、**右连接**、**全连接**。

假如有三支表a,b,c,各有d,e两列：

    ******a******
    D     E 
    1     1A 
    2     2A
     
    ******b******
    D      E
    1     1B
    3     3B
    
    ******c******
    D     E
    1     1C 
    4     4C

## 内连接

内连接，即最常见的**等值连接**，例：

    SELECT *
    FROM A,B
    WHERE A.D=B.D
    
    --->
    D   E     D    E
    1   1A    1    1B
 

## 外连接

1. 使用外连接可以查询不满足连接条件的数据
2. 外连接的符号是（+）

外连接分为左外连接，右外连接和全外连接。

### 左连接

左外连接 left outer join 或者 left join

左外连接就是**在等值连接的基础上加上主表中的未匹配数据**，例：

    SELECT *
    FROM A
    LEFT OUTER JOIN B
    ON A.D=B.D
     
    --Oracle 支持另一种写法
     
    SELECT *
    FROM A,B
    WHERE A.D=B.D(+)
    
    --结果：
    D     E    D    E
    1    1A    1    B
    2    1B

相当于为主表A添加了一列。

### 右外连接

right outer join 或者 right join

右外连接是在等值连接的基础上加上**被连接表**的不匹配数据
 
    SELECT *
    FROM A
    RIGHT OUTER JOIN B
    ON A.D=B.D
    
    --Oracle支持的另一种写法
     
    SELECT *
    FROM A,B
    WHERE A.D(+)=B.D
     
    结果：
    D  E  D  E
    1 1A  1  B
          3  3B

### 全外连接

full outer join 或者 full join

全外连接是在等值连接的基础上**将左表和右表的未匹配数据都加上**


    SELECT *
    FROM A
    FULL OUTER JOIN B
    ON A.D=B.D

全外连接的等价写法，对同一表先做左连接，然后右连接

    SELECT  A.*,B.*
    FROM A
    LEFT OUTER JOIN B
    ON A.D=B.D
    UNION
    SELECT A.*,B.*
    FROM B
    LEFT OUTER JOIN A
    ON A.D=B.D
     
    --结果：
    D  E   D  E 
    1  1A  1  1B 
    2  2A
           3  3B

## 参考

[Oracle内连接、左外连接、右外连接、全外连接小总结](http://www.51testing.com/?uid-77325-action-viewspace-itemid-236274)
