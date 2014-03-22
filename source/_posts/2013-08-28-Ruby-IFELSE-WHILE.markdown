---
layout: post
title: Ruby - IF..ELSE & WHILE
date: 2013-08-28 06:43:32
comments: true
categories: code
---
## if..else & unless

第一种情况，if..else组合使用.

注意: ** else if => elsif **

    hh = 2
    if hh == 1 then
      puts "hh is 1"
    elsif hh == 2
      puts "hh is 2"
    else
      puts "hh is #{hh}"
    end 
第二种情况,单一情况判断可写成一行。

    #encoding: utf-8
    puts "单行判断hh" if hh == 2
第三种情况,unless

** unless 等价 if! **,if的上述用法都可以用在unless上。

## case..when

第一种情况,单值比较是否相同

    hh = 2
    ret = case hh
    when 1 then "hh is 1"
    when 2 then "hh is 2"
    when 3 then "hh is 3"
    else
      "hh is #{hh}"
    end
    puts ret
    # => hh is 2

第二种情况,多值比较是否相同

    hh = 2
    ret = case hh
    when 0,1 then "hh is 0 or 1"
    when 2,3 then "hh is 2 or 3"
    else
      "hh is #{hh}"
    end
    puts ret
    # => hh is 2 or 3

第三种情况,判断是否在其范围中

    hh = 2
    ret = case hh
    when 0..1 then "hh in 0..1"
    when 2..3 then "hh in 2..3"
    else
      "hh is #{hh}"
    end
    puts ret
    # => hh in 2..3

第四种情况,任意比较

    ret = case
    when hh == 1 then "hh is 1"
    when hh == 2 then "hh is 2"
    when hh == 3 then "hh is 3"
    else
      "hh is #{hh}"
    end
    puts ret
    # => hh is 2
