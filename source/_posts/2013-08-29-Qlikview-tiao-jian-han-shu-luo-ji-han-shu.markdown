---
layout: post
title: Qlikview 条件函数 & 逻辑函数
date: 2013-08-29 09:12:20
comments: true
categories: qlikview
---
# 条件函数

## if

> if(condition , then , else)

> 三个参数condition，then 和else 均为表达式。

> 第一个condition 是以逻辑方式进行解释。其他两个( then 和else) 可为任何类型。它们最好为相同类型。

> 如果condition 为真，那么该函数返回表达式值then。

> 如果condition 为假，那么该函数返回表达式值else。


    示例：
    if( Amount>= 0, 'OK', 'Alarm' )

## alt

> alt(case1[ , case2 , case3 , ...], else)

> alt 函数返回首个具有有效数表示法的参数。

> 如果未找到此类匹配，则将返回最后一个参数。可使用任何数目的参数。


    示例：
    alt( date#( dat , 'YYYY/MM/DD' ),
         date#( dat , 'MM/DD/YYYY' ),
         date#( dat , 'MM/DD/YY' ),
         'No valid date' )

将测试日期字段是否包含三个指定日期格式中的任一日期。若如此，它将返回原始字符串和有效的日期数字呈现形式。

如果未找到匹配，将返回文本“No valid date”( 无任何有效的数字呈现形式) 。

## pic

> pick(n, expr1[ , expr2,...exprN])

> 返回列表中的第n 个表达式。n 是介于1 和N 之间的整数。

    示例：
    pick( N'A''B'4, , , )
    返回'B'，如果N = 2
    返回4，如果N = 3

## match 

> match( str, expr1 [ , expr2,...exprN ] )

> match 函数执行区分大小写的比较。

    示例：
    match( M, 'Jan','Feb','Mar')
    返回2，如果M = Feb
    返回0，如果M = Apr 或jan

## mixmatch

> mixmatch( str, expr1 [ , expr2,...exprN ] )


** mixmatch 函数执行不区分大小写的比较。**


    示例：
    mixmatch( M, 'Jan','Feb','Mar')
    返回1，如果M = jan

## wildmatch


> wildmatch( str, expr1 [ , expr2,...exprN ] )


** wildmatch 函数执行不区分大小写的比较，并允许在比较字符串中使用通配符( * 和?) 。**


    示例：
    wildmatch( M, 'ja*','fe?','mar')
    返回1，如果M = January
    返回2，如果M = fex

## class


> class(expression, interval [ , label [ , offset ]])


创建expressions 分类。bin 宽按数集确定为interval。结果显示为a<=x<b，其中a 和b 为bin 的上限值和下限值。x 可以由label 中声明的任意字符串替代。

0 通常是分类的默认起点。通过添加offset 可更改此起点。

    示例：
    class( var,10 ) with var = 23，返回'20<=x<30'
    class( var,5,'value' ) with var = 23，返回'20<= value <25'
    class( var,10,'x',5 ) with var = 23，返回'15<=x<25'

# 逻辑函数

## IsNum

> IsNum( expr)

> 如果表达式能解释为数字，则返回-1 ( 真) ，否则为0 ( 假) 。

## IsText

> IsText(expr)

如果表达式有文本呈现形式，则返回-1 ( 真) ，否则为0 ( 假) 。

## IsPartialReload

> IsPartialReload( )

如果当前部分重新加载，则返回-1 ( 真) ，否则为0 ( 假) 。

# 空函数

## Null( )

> Null( )

返回一个真实的空值。

## IsNull

> IsNull(expr)

如果表达式为空值，则返回-1( 真) ，否则返回0( 假) 。
