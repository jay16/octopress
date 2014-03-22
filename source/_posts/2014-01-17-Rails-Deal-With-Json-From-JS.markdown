---
layout: post
title: Rails处理JS传入的JSON字符串
date: 2014-01-17 13:29:16
comments: true
categories: code
---
## 场景再现

最近在写一个网上水果店的rails项目，实现购物车功能时，考虑到操作session过于脆弱，数据保存可以不完整，就写了一支数据库表来存储顾客的购物车信息。

前台顾客选购的商品会实时传入后台，传递数据的方式是使用ajax传递json字符串的方式，rails解析json字符串时没有问题，添加移除商品其实就是操作更新或合并数据库表中的session字段，代码如下:

      #app/modal/shop_cart.rb
      #购物车内容
      def cart_items
        my_session = self.session || "[]"
        JSON.parse(my_session.gsub("=>",":"))
      end

随着测试的正常进行，前后台传递的数据也越完善，与之前测试的json字符串数据结构也都变了，我无意识的认识这些错误数据结构的json字符串会影响后面的测试，就随手把session字段更新为**空字符串**了，为后面的悲催挖好了坑。

      update shop_carts set session = "" where id in (1,3)

## 代码异常

在管理购物车界面加载所有顾客的购物车信息，有分析购物车中商品数据与金额的代码，报出了异常，而之前代码是没有问题。

      #app/modal/shop_cart.rb
      #计算购物车商品数量
      def cart_items_size
        cart_items.inject(0) do |sum, item| 
          sum + item["count"].to_i
        end
      end

报出的异常信息如下:

    A JSON text must at least contain two octets!

忽然冒出这个错误，一直理解不了，代码不是好好的吗？

刚开始以为是JSON解析出的数组不空但却有内容？人在过于自信时什么都敢猜想...

于是写ruby脚本测试，一切都正常.

    #encoding: utf-8
    require 'json'
    
    #session = '{"hh"=>1}'
    session = nil
    jsons = JSON.parse((session || "[]").gsub("=>",":"))
    
    puts jsons.length  => 0
    puts jsons.empty?  => true
    puts jsons.class   => Array

再看代码，豁然明白了，我少测试了一种字符串为空的情况，再测试，果然报出了同样的问题...

## 解决方法

把字符串为空的情况考虑进去，代码又生机勃勃了...

      #购物车内容
      def cart_items
        my_session = (self.session.nil? or self.session.empty?) ? "[]" : self.session
        JSON.parse(my_session.gsub("=>",":"))
      end
