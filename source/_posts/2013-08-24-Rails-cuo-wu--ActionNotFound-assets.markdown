---
layout: post
title: Rails 错误 - ActionNotFound & assets
date: 2013-08-24 17:14:52
comments: true
categories: [ruby,rails,css]
---
## 错误描述

在log中出现报错信息:

    Started GET "/segments/assets/header-bg.png" for 114.93.18.168 at 2013-08-07 23:04:09 +0800
    
    AbstractController::ActionNotFound (The action 'assets' could not be found for SegmentsController):
      vendor/cache/ruby/1.9.1/gems/actionpack-3.2.3/lib/abstract_controller/base.rb:116:in `process'
      vendor/cache/ruby/1.9.1/gems/actionpack-3.2.3/lib/abstract_controller/rendering.rb:45:in `process'
      vendor/cache/ruby/1.9.1/gems/actionpack-3.2.3/lib/action_controller/metal.rb:203:in `dispatch'
      vendor/cache/ruby/1.9.1/gems/actionpack-3.2.3/lib/action_controller/metal/rack_delegation.rb:14:in `dispatch'
      vendor/cache/ruby/1.9.1/gems/actionpack-3.2.3/lib/action_controller/metal.rb:246:in `block in action'
      vendor/cache/ruby/1.9.1/gems/actionpack-3.2.3/lib/action_dispatch/routing/route_set.rb:73:in `call'
      vendor/cache/ruby/1.9.1/gems/actionpack-3.2.3/lib/action_dispatch/routing/route_set.rb:73:in `dispatch'
      vendor/cache/ruby/1.9.1/gems/actionpack-3.2.3/lib/action_dispatch/routing/route_set.rb:36:in `call'
      vendor/cache/ruby/1.9.1/gems/journey-1.0.4/lib/journey/router.rb:68:in `block in call'
      vendor/cache/ruby/1.9.1/gems/journey-1.0.4/lib/journey/router.rb:56:in `each'
      vendor/cache/ruby/1.9.1/gems/journey-1.0.4/lib/journey/router.rb:56:in `call'
      vendor/cache/ruby/1.9.1/gems/actionpack-3.2.3/lib/action_dispatch/routing/route_set.rb:600:in `call'
      vendor/cache/ruby/1.9.1/gems/actionpack-3.2.3/lib/action_dispatch/middleware/best_standards_support.rb:17:in `call'
    
      Rendered vendor/cache/ruby/1.9.1/gems/actionpack-3.2.3/lib/action_dispatch/middleware/templates/rescues/unknown_action.erb within rescues/layout (2.4ms)
    
    Started GET "/assets/roll.png" for 114.93.18.168 at 2013-08-07 23:04:09 +0800
    Served asset /roll.png - 200 OK (3ms)

## 解决方法

究其原因是对图片的引用地址写错了,要引用的图片在`/app/assets/images`路径下的,正确代码应该:

    .img {
      background: url("/assets/header-bg.png") repeat scroll left top transparent;
    }

而我写成了`url("assets/header-bg.png")`,于是造就了这个ActionNotFound 错误。

***

**注意:**

1. url `/hello`默认跳转到`/hello/index`上,css引用要写成`assets/header-bg.png`
2. url `/hello/index`,css引用要写成`/assets/header-bg.png`
