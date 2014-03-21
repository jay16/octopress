---
layout: post
title: Ruby - Loops
date: 2013-08-28 06:28:23
comments: true
categories: Ruby
---
## while

第一种写法:

    hh = 0
    while(hh < 4) do
      puts "hh is #{hh}"
      hh += 1
    end

第二种写法：

    hh = 0
    begin
      puts "hh is #{hh}"
      hh += 1
    end while(hh < 4)

## untile

格式与while相同,判断条件与while相反

第一种写法:

    hh = 0
    until (hh > 4) do
      puts "hh is #{hh}"
      hh += 1
    end

第二种写法：

    hh = 0
    begin
      puts "hh is #{hh}"
      hh += 1
    end until(hh > 4)

## next&break

    hh = 0
    while(hh < 4) do
    
      #hh=3时退出循环
      break if hh == 3
      
      puts "hh is #{hh}"
      hh += 1
    
      #hh=2时跳过
      next if hh == 2
    end

    hh = 0
    begin
      puts "hh is #{hh}"
      hh += 1
    end while(hh < 4)

## redo

下面代码会无限循环的执行。

    for i in 0..5
       if i < 2 then
          puts "Value of local variable is #{i}"
          redo
       end
    end

## retry

    tt = 0
    begin 
      raise "test retry" if tt == 0
    rescue => e
      #处理异常
      puts e.message
      tt = 1
      #重新从begin执行
      retry 
    else
      puts "now normallay!"
    end
    # => test retry
    # => now normallay!
