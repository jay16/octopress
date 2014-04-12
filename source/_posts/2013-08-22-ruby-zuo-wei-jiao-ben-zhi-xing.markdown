---
layout: post
title: ruby 作为脚本执行
date: 2013-08-22 05:39:07
comments: true
categories: [ruby,bi]
---
> 查看ruby路径

    [root@localhost ruby]# whereis ruby
    ruby: /usr/bin/ruby /usr/lib/ruby /usr/local/bin/ruby /usr/local/lib/ruby

> 在ruby脚本文本首先添加ruby路径

    [root@localhost ruby]# vi ruby_001.rb
    
    #!/usr/local/bin/ruby -w
    
    puts "Hello, World!"

> 为ruby脚本文本赋予可执行权限

    [root@localhost ruby]# chmod +x ruby_001.rb 

> 作为脚本执行

    [root@localhost ruby]# ./ruby_001.rb 
    Hello, World!
