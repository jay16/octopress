---
layout: post
title: Oracle 处理Number,Char,Date的关联
date: 2014-02-24 12:35:07
comments: true
categories: Oracle
---
## 需求

表字段t_month_id类型是number(6)，格式是YYYYMM,存放年月。

现在根据字段t_month_id，取得它上个月的年月值，举例201401，那它的上月年月值就是201312，不是单纯的减1就能解决的。

## 思路

先把`t_month_id*100+1`拼成YYYYMMDD格式，然后to_chart转化为字符串格式，再to_date转化为时期,使用日期函数`add_months(date,-1)`取得上月的日期，转化为字符串格式，截取字符串，转化为整数...

## 代码

转化为日期

    select 
      distinct t.t_month_id,
      to_date(to_char(t.t_month_id*100+1),'YYYYMMDD') as last_month
    from date_table t

        last_month t_month_id
    1    2013-11-1    201311
    2    2014-2-1     201402
    3    2013-10-1    201310
    4    2013-9-1     201309
    5    2013-6-1     201306
    6    2013-12-1    201312
    7    2013-4-1     201304
    8    2013-8-1     201308
    9    2013-7-1     201307
    10   2013-5-1     201305
    11   2014-1-1     201401

取得上月日期后再转化字符串

    select 
      distinct t.t_month_id,
      to_char(add_months(to_date(to_char(t.t_month_id*100+1),'YYYYMMDD'),-1),'YYYYMMDD') 
      as last_month
    from date_table t

        last_month t_month_id
    1    20131001    201311
    2    20130901    201310
    3    20130701    201308
    4    20130501    201306
    5    20131201    201401
    6    20131101    201312
    7    20130801    201309
    8    20130601    201307
    9    20130401    201305
    10   20130301    201304
    11   20140101    201402

截取字符串后再转化为整数

    select 
      distinct t.t_month_id,
      to_number(substr(to_char(add_months(to_date(to_char(t.t_month_id*100+1),'YYYYMMDD'),-1),'YYYYMMDD'),0,6)) 
      as last_month
    from date_table t

        last_month t_month_id
    1    201309    201310
    2    201308    201309
    3    201306    201307
    4    201305    201306
    5    201304    201305
    6    201311    201312
    7    201303    201304
    8    201310    201311
    9    201307    201308
    10   201401    201402
    11   201312    201401
