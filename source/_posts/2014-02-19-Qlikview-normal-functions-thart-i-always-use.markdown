---
layout: post
title: Qlikview 常用函数
date: 2014-02-19 10:40:52
comments: true
categories: qlikview,report
---
+ total分组汇总，相当于group by

    sum(total<款号,颜色> if(数据类型='期初到货',数量))

+ 计算占比，即当前值除以汇总值，使用total

    count(实际评级)/count(total<个人评级,区域名称,买家名称> 实际评级))

+ 字符串拼接（& ||）

    //oracle sql
    款号||颜色 as 色款
    
    //qlikview
    款号&颜色 as 色款

+ 字符串截取

    //date: 20141121 => 2014-11-21
    left(date,4)&'-'&mid(date,5,2)&'-'&right(date,2) as 去年标准日期

+ 日期操作函数

    dual AddMonths (date, no_of_months [, mode=1])
    dual AddYears (date, no_of_years)
    dual Date (number [, format])

+ rank 根据在**[Dimensions]**中定义的维度**维度选择**,在**所选维度**中各自排名

    num(rank(维度选择
    &num(零售量*10000+10000000,'#########0', '' , '')
    ,4))

+ rank 相对区域排名,在**区域名称**各自排名

    num(rank(区域名称&num(零售量*10000+10000000,'#########0', '' , ''),4))


+ rank 整体排名

参数**4**表示**每一列都依次提高一位,没有相同名次

    rank(total ((零售量*10000000+成交金额)*1000+if(isnull(平均折扣),0,平均折扣)*1000,4)

****

+ 判断字段为空

    =if(isnull(数据类型),null(),年份&季节编码&波段)

+ 判断字段不为空

    if(ot isnull(商品个人评级),商品个人评级)

+ 显示图片 

[**Advanced Filed Settings**] -> [**Representation**] -> Select [**Image**]

    ='\srverpbi\产品图片
+ 字符串包含子集个数

    SubStringCount(LILYFAIR_PRODUCT_MARK.AREA_NAME,'北京区')=1
&款号&颜色&'.JPG'

+ 字符串包含子集个数

    SubStringCount(LILYFAIR_PRODUCT_MARK.AREA_NAME,'北京区')=1
