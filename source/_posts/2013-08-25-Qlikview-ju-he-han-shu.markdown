---
layout: post
title: Qlikview 聚合函数
date: 2013-08-25 15:16:16
comments: true
categories: report
---
***

**注意！**

如果未发现任何值，所有聚合函数都将返回一个空值，总和和计数除外，它们返回0。

***

# 基本聚合函数

## sum

> sum([distinct]expression)

> 返回涉及子句group by 所定义记录的表达式总和。如果在表达式前出现distinct，所有重复值将被忽略。

    示例：
    Load Month, sum(Sales) as SalesPerMonth
    from abc.csv group by month;

## min

> min( expression[, rank] )

> 返回遇到的涉及子句group by 所定义记录的表达式最小数值。Rank 默认设置为1，对应最小值。通过指定Rank 为2 将返回第二小的值。如果Rank 为3，将会返回第三小的值，以此类推。

    示例：
    Load Month, min(Sales) as SmallestSalePerMonth from abc.csv group by Month;
    Load Month, min(Sales, 2) as SecondSmallestSalePerMonth from abc.csv group by Month;

## max

> max( expression[, rank] )

> 返回遇到分类标准子句定义的众多记录的表达式最大数值。Rank 默认设置为1，对应最大值。通过指定Rank 为2 将返回第二大的值。如果Rank 为3，将会返回第三大的值，以此类推。

    示例：
    Load Month, max(Sales) as LargestSalePerMonth from abc.csv group by Month;
    Load Month, max(Sales, 2) as SecondLargestSalePerMonth from abc.csv group by Month;

## only

> only(expression)

> 如果分类标准子句定义的众多记录的表达式仅包含一个数值，即返回该值。否则即返回空值。

    示例：
    Load Month, only(Price) as OnlyPriceSoldFor from abc.csv group by Month;

## mode

> mode(expression)

> 返回模式值，即分类标准子句定义的众多记录的表达式最常出现的值。如果不只一个值经常出现，则返回空值。Mode 可返回数值，也可返回文本值。

    示例：
    Load Month, mode( ErrorNumber ) as MostCommonErrorNumber from abc.csv group by Month;
    Load Month, mode( Product ) as ProductMostOftenSold from abc.csv group by Month;

## firstsortedvalue

> firstsortedvalue ([distinct ] expression [, sort-weight [, n ]])

> 当表达式在许多涉及子句group by 定义的记录上重复时，返回首个按相应sort-weight 分类的表达式值。sort-weight 应返回数值，最小的值将使相应的表达式值首先分类。通过在sort-value 表达式前面加一个减号，函数就会返回最后数值。如果不只一个表达式值共享相同的最小sortorder，函数将返回空值。通过赋予n 一个大于1 的值，则第n 个值将会按顺序返回。如果在表达式前出现distinct，所有重复值将被忽略。

    示例：
    //按客户分组
    Load Customer,
    firstsortedvalue(PurchasedArticle, OrderDate) as FirstProductBought from abc.csv


# 字符串聚合函数

## MinString

> MinString(expression)

> 返回分类标准子句定义的众多记录的表达式的首个文本值。如果未发现文本值，则返回空值。

    示例：
    Load Month, MinString(Month) as FirstSalesMonth from abc.csv group by Year;
## MaxString

> MaxString(expression)

> 返回分类标准子句定义的众多记录的表达式的最后一个文本值。如果未发现文本值，则返回空值。


    示例：
    Load Month, MaxString(Month) as LastSalesMonth from abc.csv group by Year;

## FirstValue

> FirstValue(expression)

> 返回group by 子句定义的众多记录的表达式按加载顺序排序的首个值。如果未发现文本值，则返回空值。此函数仅可用作脚本函数。

    示例：
    Load City, FirstValue(Name), as FirstName from abc.csv group by City;

## LastValue

> LastValue(expression)

> 返回group by 子句定义的众多记录的表达式按加载顺序排序的最后一个值。如果未发现文本值，则返回空值。此函数仅可用作脚本函数。

    示例：
    Load City, LastValue(Name), as FirstName from abc.csv group by City;

## concat

> concat ([ distinct ] expression [, delimiter [, sort-weight]])

> 返回在子句group by 所定义记录上进行迭代的表达式所有值的聚合字符串串联。每个值均由分隔符内的字符串分隔。串联的顺序可由sort-weight 决定。Sort-weight 应返回一个数值，最低数值将使项目首先被排序。如果在表达式前出现distinct，所有重复值将被忽略。

    示例：
    Load Department, concat(Name,';') as NameList from abc.csv group by Department;

# 计数器聚合函数

## count

> count([distinct ] expression | \* )

> 返回涉及子句group by 所定义记录的表达式的计数。如果在表达式前出现distinct，所有重复值将被忽略。

    示例：
    Load Month, count(Sales) as NumberOfSalesPerMonth from abc.csv group by Month;
    Load Month, count(distinct Customer) as CustomerBuyingPerMonth from abc.csv group by Month;
    LoadMonth, count(\*) as NumberOfRecordsPerMonth from abc.csv group by Month;

## NumericCount

> NumericCount([distinct ] expression )

> 返回涉及子句group by 所定义记录的表达式的数值计数。如果在表达式前出现distinct，所有重复值将被忽略。

    示例：
    Load Month, NumericCount(Item) as NumberOfNumericItems from abc.csv group by Month;

## TextCount

> TextCount([distinct ] expression)

> 返回涉及子句group by 所定义记录的表达式的文本计数。如果在表达式前出现distinct，所有重复值将被忽略。

    示例：
    Load Month, TextCount(Item) as NumberOfTextItems from abc.csv group by Month;
## NullCount

> NullCount([distinct ] expression )

> 返回涉及子句group by 所定义记录的表达式的空值计数。如果在表达式前出现distinct，所有重复值将被忽略。

    示例：
    Load Month, NullCount(Item) as NumberOfNullItems from abc.csv group by Month;

## MissingCount

> MissingCount([distinct ] expression )

> 返回涉及子句group by 所定义记录的表达式的遗漏值计数。如果在表达式前出现distinct，所有重复值将被忽略。

    示例：
    Load Month, MissingCount(Item) as NumberOfMissingItems from abc.csv group by Month;

# 高级聚合

## aggr

> aggr ([ distinct | nodistinct ] [{set_expression}]expression {,dimension})

> 返回在多个维度上计算的表达式数值集。返回结果可与局部图表的表达式列作对比，并于存在aggr 函数的上下文中进行验证。每一个维度必须是单个字段。不能为表达式( 计算维度) 。

如果表达式参数前方为nodistinct 识别符，各维度值组合可能生成一个或多个返回值，具体结果由基础数据结构决定。

如果表达式参数前方为distinct 限定符，或者没有识别符，各维度值组合将生成唯一的返回值。

聚合函数会默认聚合选择项定义的可能记录集合。可选记录集合可由集合分析(第782 页)表达式定义。

在添加计算维度(第594 页)中使用该功能可实现多层次嵌套图表聚合。另请参阅嵌套聚合函数和相关问题(第827 页)。

在图表表达式中使用时可以实现透视表中的行总和(第828 页)。

    示例：
    aggr( sum(Sales), Country )
    aggr( nodistinct sum(Sales), Country )
    aggr( sum(Sales), Country, Region )
    count( aggr( sum(Sales), Country ))
