---
layout: post
title: Qlikview 脚本范围函数
date: 2013-08-23 02:40:06
comments: true
categories: BI,Qlikview
---
范围函数将替代以下一般数字函数(第302 页)：numsum，numavg，numcount，nummin 和 nummax( 现在应被视为已过时) 。

## rangesum

> rangesum(expr1 [ , expr2, ... exprN ])

> 返回范围为1 至N 参数的总和。**相对于+运算符，rangesum 将非数字值都看成0**。 

    // rangsum 示例：
    rangesum (1,2,4)   => 7 // 1 + 2 + 4
    rangesum (1,'xyz') => 1 // 1 + 'xyz' = 1 + 0
    rangesum (null( )) => 0

## rangeavg

> rangeavg(expr1 [ , expr2, ... exprN ])

> 返回范围为1 至N 参数的平均值。如果未查找到数字值，则返回空值。

    // rangeavg 示例：
    rangeavg (1,2,4)          => 2.33333333 // (1 + 2 + 4）/3 = 7/3
    rangeavg (1,'xyz')        => 1
    rangeavg (null( ), 'abc') => 空值

## rangecount

> rangecount(expr1 [ , expr2, ... exprN ])

> 返回在1 至N 参数范围内的值的数量。**空值不计算在内**。

    // rangecount 示例：
    rangecount (1,2,4)    => 3
    rangecount (2,'xyz')  => 2
    rangecount (null( ))  => 0

## rangemin

> rangemin(expr1 [ , expr2, ... exprN ])

> 返回在1 至N 参数范围内的最低数字值。**如果未查找到数字值，则返回空值**。

    // rangemin 示例：
    rangemin (1,2,4)    => 1
    rangemin (1,'xyz')  => 1
    rangemin (null( ), 'abc') => 空值

## rangemax

> rangemax(expr1 [ , expr2, ... exprN ])

> 返回在1 至N 参数范围内的最高数字值。**如果未查找到数字值，则返回空值**。

    // rangemax 示例：
    rangemax (1,2,4)    => 4
    rangemax (1,'xyz')  => 1
    rangemax (null( ), 'abc') => 空值

## rangestdev

> rangestdev(expr1 [ , expr2, ... exprN ] )

> 返回1 - N 参数范围内发现的标准偏差。**如果未查找到数字值，则返回空值**。

    // rangestdev 示例：
    rangestdev (1,2,4)   => 1.5275252316519
    rangestdev (null( )) => 空值

## rangeskew

> rangeskew(expr1 [ , expr2, ... exprN ])

>返回1 至N 参数范围内的偏度。如果未查找到数字值，则返回空值。

    // rangeskew 示例：
    rangeskew (1,2,4) => 0.93521952958283

## rangekurtosis

> rangekurtosis(expr1 [ , expr2, ... exprN ])

> 返回1 至N 参数范围内的峰度。如果未查找到数字值，则返回空值。

    // rangekurtosis 示例：
    rangekurtosis (1,2,4,7)返回-0.28571428571429

## rangefractile

> rangefractile(fractile, expr1 [ , expr2, ... exprN ])

> 返回1 - N 参数范围的分位数。

    // rangefractile 示例：
    rangefractile (0.24,1,2,4,6)  => 1
    rangefractile (0.5,1,2,3,4,6) => 3
    rangefractile (0.5,1,2,5,6)   => 3.5

## rangenumericcount

> rangenumericcount(expr1 [ , expr2, ... exprN ])

> 返回在1 至N 参数范围内的数字值的数量。

    // rangenumericcount 示例：
    rangenumericcount (1,2,4)   => 3
    rangenumericcount (2,'xyz') => 1
    rangenumericcount (null( )) => 0

## rangetextcount

> rangetextcount(expr1 [ , expr2, ... exprN ])

> 返回在1 至N 参数范围内的文本值的数量。

    // rangetextcount 示例：
    rangetextcount (1,2,4)   => 0
    rangetextcount (2,'xyz') => 1
    rangetextcount (null( )) => 0

## rangenullcount

> rangenullcount(expr1 [ , expr2, ... exprN ])

> 返回在1 至N 参数范围内的空值的数量。

    // rangenullcount 示例：
    rangenullcount (1,2,4)   => 0
    rangenullcount (2,'xyz') => 0
    rangenullcount (null( ),null( )) => 2

## rangemissingcount

> rangemissingcount(expr1 [ , expr2, ... exprN ])

>返回在1 至N 参数范围内的非数字值( 包括空值) 的数量。

    // rangemissingcount 示例：
    rangemissingcount (1,2,4)    => 0
    rangemissingcount (2,'xyz')  => 1
    rangemissingcount (null( ))  => 1

## rangeminstring

> rangeminstring(expr1 [ , expr2, ... exprN ])

> 返回1 至N 范围内文本排序方式的第一值。

    // rangeminstring 示例：
    rangeminstring (1,2,4)       => 1
    rangeminstring ('xyz','abc') => 'abc'
    rangeminstring (null( ))     => 空值

## rangemaxstring

> rangemaxstring(expr1 [ , expr2, ... exprN ])

> 返回1 至N 范围内文本排序方式的最后的值。

    // rangemaxstring 示例：
    rangemaxstring (1,2,4)       => 4
    rangemaxstring ('xyz','abc') => 'xyz'
    rangemaxstring (null( ))     => 空值

## rangemode

> rangemode(expr1 [ , expr2, ... exprN ])

> 返回模式值,即1 至N 参数范围内最常出现的值。如果不止一个值具有最高频率，则返回空值。

    // rangemode 示例：
    rangemode (1,2,9,2,4)   => 2
    rangemode ('a',4,'a',4) => 空值
    rangemode (null())      => 空值

## rangeonly

> rangeonly(expr1 [ , expr2, ... exprN ])

> 如果一个非空值存在于N 表达式范围之内，则将返回该值。在所有其他情况下，返回的是空值。

    // rangeonly 示例：
    rangeonly (1,2,4)    => 空值
    rangeonly (1,'xyz')  => 空值
    rangeonly (null( ), 'abc') => 'abc'

## rangecorrel

> rangecorrel(x-value , y-value { , x-value , y-value})

> 为一系列坐标返回一个相关系数。

> X 轴值和Y 轴值是单个值。每个Y 轴值必须对应一个X 轴值。

> 计算此函数至少需要两对坐标。文本值，空值和缺失值都忽略不计。

    // rangecorrel 示例：
    rangecorrel (2,3,6,8,9,4)  => 0,269

## rangeirr

> rangeirr(value { ,value} )

> 返回按数值数量表示的一系列现金流的内部返回率。这些现金流不必是均值，因为它们可用于年金。但是，现金流必须定期出现，例如每月或每年。内部返回率是指投资回报的利率，该利率由定期出现的付款( 负值) 和收入( 正值) 构成。

> 值是图表内部记录函数(第797 页)返回并带第三个可选参数的单个值或值范围。计算此函数至少需要一个正值和一个负值。文本值，空值和缺失值都忽略不计。

    // rangeirr 示例：
    rangeirr(-70000,12000,15000,18000,21000,26000) => 0,0866
    rangeirr(above(sum(value), 0, 10))
    rangeirr(above(total value, 0, rowno(total)))

## rangenpv

> rangenpv (rate, value { ,value} )

> 返回基于折扣率和一系列未来付款( 负值) 和收入( 正值) 的投资的净现值。结果默认采用货币数字格式。

> 比率为每周期的利率。

> 值是指每个周期结束时发生的付款或收入。每个值可以是图表内部记录函数(第797 页)返回并带第三个可选参数的单个值或值范围。文本值，空值和缺失值都忽略不计。

    // rangenpv 示例：
    rangenpv(0.1,-10000,3000,4200,6800) 返回1188,44
    rangenpv(0.05, above(sum(value), 0, 10))
    rangenpv(0.05, above(total value, 0, rowno(total)))

## rangexirr

> rangexirr(value, date { ,value, date} )

> 返回现金流计划表的内部返回率( 不必是周期性的) 。要计算一系列周期性现金流的内部返回率，请使用rangeirr(value { ,value} ) (第309 页)函数。

> 值是指对应付款日期计划表的现金流或一系列现金流。每个值可以是图表内部记录函数(第797 页)返回并带第三个可选参数的单个值或值范围。文本值，空值和缺失值都忽略不计。所有付款全年折扣。系列值必须至少包含一个正值和一个负值。

> 日期是指对应现金流付款的付款日期或付款日期计划表。

    // rangexirr 示例：
    rangexirr(-2500,'2008-01-01',2750,'2008-09-01') 返回0,1532
    rangexirr (above(sum(value), 0, 10), above(date, 0, 10))
    rangexirr(above(total value,0,rowno(total)),
    above(total date,0,rowno(total)))

## rangexnpv

> rangexnpv(rate, value, date { ,value, date} )
> 返回现金流计划表的净现值( 不必是周期性的) 。结果默认采用货币数字格式。要计算一系列周期性现金流的净现值，请使用rangenpv (rate, value { ,value} ) (第310 页)函数。

> 比率为每周期的利率。

> 值是指对应付款日期计划表的现金流或一系列现金流。每个值可以是图表内部记录函数(第797 页)返回并带第三个可选参数的单个值或值范围。文本值，空值和缺失值都忽略不计。所有付款全年折扣。系列值必须至少包含一个正值和一个负值。

> 日期是指对应现金流付款的付款日期或付款日期计划表。

    // rangexnpv 示例：
    rangexnpv(0.1, -2500,'2008-01-01',2750,'2008-09-01') => 80,25
    rangexnpv (0.1, above(sum(value), 0, 10), above(date, 0, 10))
    rangexnpv(0.1, above(total value,0,rowno(total)),
    above(total date,0,rowno(total)))
