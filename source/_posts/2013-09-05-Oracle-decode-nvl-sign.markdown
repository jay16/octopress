---
layout: post
title: Oracle - decode nvl sign
date: 2013-09-05 09:26:54
comments: true
categories: Oracle
---
## SIGN

    -- 如果ToF是个正数则返回1,负数则返回-1,0则返回0
    select sign(ToF) from tableA

## DECODE

> decode(条件,值1,返回值1,值2,返回值2,...值n,返回值n,缺省值)

### 等价含义

该函数的含义如下：

    IF 条件=值1 THEN
    　　　　RETURN(返回值1)
    ELSIF 条件=值2 THEN
    　　　　RETURN(返回值2)
    　　　　......
    ELSIF 条件=值n THEN
    　　　　RETURN(返回值n)
    ELSE
    　　　　RETURN(返回值)
    END IF

### 实际应用

#### 用法一

比如我要查询某班男生和女生的数量分别是多少?

通常我们这么写:

    select count(*) from 表 where 性别 ＝ 男；
    select count(*) from 表 where 性别 ＝ 女；

要想显示到一起还要union一下，太麻烦了

用decode呢，只需要一句话:

    select decode(性别，男，1，0），decode(性别，女，1，0） from 表

#### 用法二

比较大小

    --取较小值
    --sign()函数根据某个值是0、正数还是负数，分别返回0、1、-1
    select decode(sign(变量1-变量2),-1,变量1,变量2) from dual; 

例如：

变量1=10，变量2=20

则sign(变量1-变量2)返回-1，decode解码结果为“变量1”，达到了取较小值的目的。

 
 
### 含义讲解

Decode函数与一系列嵌套的 IF-THEN-ELSE语句相似。

base_exp与compare1,compare2等等依次进行比较。

如果base_exp和 第i 个compare项匹配，就返回第i 个对应的value 。

如果base_exp与任何的compare值都不匹配，则返回default。

每个compare值顺次求值，如果发现一个匹配，则剩下的compare值（如果还有的话）就都不再求值。

一个为NULL的base_exp被认为和NULL compare值等价。如果需要的话，每一个compare值都被转换成和第一个compare 值相同的数据类型，这个数据类型也是返回值的类型。

## NVL & NVL2 & NullIF

### NVL

> Nvl(expr1,expr2)

> 如果expr1是null,则返回expr2,否则返回expr1.

### NVL2

> Nvl2(expr1,expr2,expr3)

> 如果expr1是null,则返回expr2,否则返回expr3.

### NullIF：

> NullIF(expr1,expr2)

> 如果expr1等于expr2,返回null,如果不等于返回expr2.    
      
## 转载

1. [Oracle 中 decode 函数用法](http://www.cnblogs.com/ZHF/archive/2008/09/12/1289619.html)
2. [Oracle:Nvl、Nvl2、decode、Sign、NULLIF分别的作用](http://www.haogongju.net/art/457318)
