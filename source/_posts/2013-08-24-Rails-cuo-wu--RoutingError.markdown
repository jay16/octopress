---
layout: post
title: Rails 错误 - RoutingError
date: 2013-08-24 17:43:01
comments: true
categories: Rails,Error
---
## 报错描述

界面上图片都正常显示,不知那段css代码中定义有误,log里总是显示一片片的`ActionController::RoutingError`报错。

    Started GET "/img/glyphicons-halflings.png" for 222.67.62.40 at 2013-07-29 00:25:33 +0800
    
    ActionController::RoutingError (No route matches [GET] "/img/glyphicons-halflings.png"):
    .....
    
      Rendered vendor/cache/ruby/1.9.1/gems/actionpack-3.2.3/lib/action_dispatch/middleware/templates/rescues/routing_error.erb within rescues/layout (0.4ms)

## 问题原因

  `No route matches [GET] "/img/glyphicons-halflings.png"`,而在Rais项目中`/img/`的绝对路径是`Rails.root.join("public","img")`.


## 解决方法

  1. 修改css中对image的引用url,指定到Rails默认的图片放置位置Rails.root.join("app","assets","images")下。

       [class^="icon-"], [class*=" icon-"] {
          background-image: url(/assets/glyphicons-halflings.png)
       }

  2. 把图片放在`Rails.root.join("public","img")`下,这样就可以正常引用,自然也就不会报错。
  

## 参考

[Ruby On Rails Bootstrap glyph icons not working properly](http://stackoverflow.com/questions/13708189/ruby-on-rails-bootstrap-glyph-icons-not-working-properly "solife")
