---
layout: post
title: Oracle - left & right & case when
date: 2013-08-29 07:12:49
comments: true
categories: database
---
## left & right

 oracle里面是没有left和right这种写法的 你要取可以用length先去长度 然后用substr .

> substr(字段,起始坐标,截取长度)

注意:

1. 起始坐标是从1开始，即第一字符的坐标1，而不是0.
2. 截取指定长度字符串中包含[起始坐标]那个字符

实例,截取a表了b字段最前或最后两个字符串

    select 
      substr(b,1,2)            -- 相当于left(b,2)
      substr(b,length(b)-1,2)  -- 相当于right(b,2)
    from a

## case when

case when 的两种表现方法。

    --简单case函数  
    
    case sex  
    when '1' then '男'  
    when '2' then '女'  
    else '其他' end  
    
    --case搜索函数  
    
    case
    when sex = '1' then '男'  
    when sex = '2' then '女'  
    else '其他' end

## 不同位置用法

### select case when

    --sex 1为男生，2位女生
    select grade, 
       count (case when sex = 1 then 1      
         else null
         end) 男生数,
       count (case when sex = 2 then 1
         else null
         end) 女生数
    from students 
    group by grade

### where case when

    select t2.*, t1.*
       from t1, t2
      where (case 
        when t2.compare_type = 'a' and t1.some_type like 'nothing%'
          then 1
        when t2.compare_type != 'a' and t1.some_type not like 'nothing%'
          then 1
        else 0
        end
       ) = 1

### group by case when

    select  
    case when salary <= 500 then '1'  
    when salary > 500 and salary <= 600  then '2'  
    when salary > 600 and salary <= 800  then '3'  
    when salary > 800 and salary <= 1000 then '4'  
    else null end salary_class, -- 别名命名
    count(*)  
    from    table_a  
    group by  
    case when salary <= 500 then '1'  
    when salary > 500 and salary <= 600  then '2'  
    when salary > 600 and salary <= 800  then '3'  
    when salary > 800 and salary <= 1000 then '4'  
    else null end;

## 疑问

    select 
      case 
      when a in (1,2,3) then 'y'
      when a in (4,5,6) then 'n'
      else
        'un'
      end
    from b

上面的`case when`用法如果写成下面形式?!

    --下面写法执行报错
    select 
      case a
      when in (1,2,3) then 'y'
      when in (4,5,6) then n
      else
        'un'
      end
    from b


## 参考

[爱因斯坦：爱因无私而坦荡 ](http://www.cnblogs.com/eshizhan/archive/2012/04/06/2435493.html)
