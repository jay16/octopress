---
layout: post
title: Rails 错误 - SECURITY WARNING
date: 2013-09-24 11:47:20
comments: true
categories: error
---
## 描述

Rails启动后总会报出`SECURITY WARNING`,感觉怪怪的.

    => Rails 3.2.3 application starting in development on http://0.0.0.0:4567
    => Call with -d to detach
    => Ctrl-C to shutdown server
            SECURITY WARNING: No secret option provided to Rack::Session::Cookie.
            This poses a security threat. It is strongly recommended that youprovide a secret to prevent exploits that may be possible from craftedcookies. This will not be supported in future versions of Rack, and
            future versions will even invalidate your existing user cookies.
    
            Called from: /home/work/solife/vendor/cache/ruby/1.9.1/gems/actionpack-3.2.3/lib/action_dispatch/middleware/session/abstract_store.rb:28:in `initialize'.
    
    [2013-07-29 00:56:06] INFO  WEBrick 1.3.1
    [2013-07-29 00:56:06] INFO  ruby 1.9.2 (2011-02-18) [i686-linux]
    [2013-07-29 00:56:06] INFO  WEBrick::HTTPServer#start: pid=4060 port=4567

## 原因

> This is a Rails bug, as the subclass is violating the superclass API contract.

> The warning can be safely ignored by Rails users.

 
Rails 3.2.3版本的bug,由于子类继承父类API时违背了相关约定。Rails开发者可以放心的忽略此提示。
  


## 解决方法

  编辑`/home/work/solife/vendor/cache/ruby/1.9.1/gems/actionpack-3.2.3/lib/action_dispatch/middleware/session/abstract_store.rb `直接跳到**28**行方法**initialize**添加`Rails的secret_token`

        module Compatibility
          def initialize(app, options = {})
            options[:key] ||= '_session_id'
            #fixed warning - SECURITY WARNING: No secret option provided to Rack::Session::Cookie.
            options[:secret] ||= Rails.application.config.secret_token
            super
          end


## 参考

- [no-secret-option-provided-to-racksessioncookie-warning](http://stackoverflow.com/questions/10374871/no-secret-option-provided-to-racksessioncookie-warning)
