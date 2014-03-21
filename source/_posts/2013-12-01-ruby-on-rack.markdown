---
layout: post
title: Ruby on Rack
date: 2013-12-01 20:01:31
comments: true
categories: Ruby
---
## Rack介绍

Rack为使用Ruby开发web应用提供了一个最小的模块化和可修改的接口。用可能最简单的方式来包装HTTP请求和响应，它为web 服务器，web框架和中间件的API进行了统一并提纯到了单一的方法调用。

一个`Rack app`的Ruby对象被调用，参数env包括一个环境变量和请求参数的散列,代码块的返回值由带有三个元素的数组组成: HTTP状态码、响应头和响应体

### HTTP

> 超文本转移协议 (HTTP-Hypertext transfer protocol) 是一种详细规定了浏览器和万维网服务器之间互相通信的规则，通过因特网传送万维网文档的数据传送协议。

它主要描述了一个客户端发送一个HTTP请求到服务器，服务器返回一个HTTP响应的活动。HTTP请求和HTTP响应交互时传递的消息内容具有非常相似的结构。

HTTP请求三件套：`a method and resource pair`、 `a set of headers` 与 `optional body`, HTTP响应三件套: `a response code`、`a set of headers`与`an optional body`.

### 支持的web服务器

Rack提供以下handler来连接各种各样的web服务器机:

1. Mongrel
2. EventedMongrel
3. SwiftipliedMongrel
4. WEBrick
5. FCGI
6. CGI
7. SCGI
8. LiteSpeed
9. Thin

也可以在irb环境中查看`Rack::Handler.constants`:

    irb(main):001:0> require 'rack'
    => true
    irb(main):002:0> Rack::Handler.constants
    => [:CGI, :FastCGI, :Mongrel, :EventedMongrel, :SwiftipliedMongrel, :WEBrick, :LSWS, :SCGI, :Thin]

### 支持的web框架

以下的web框架的发布实例中都包含了rack适配器:

1. Camping
2. Coset
3. Espresso
4. Halcyon
5. Mack
6. Maveric
7. Merb
8. Racktools::SimpleApplication
9. Ramaze
10. Ruby on Rails
11. Rum
12. Sinatra
13. Sin
14. Vintage
15. Waves
16. Wee

## Rack实例

### ruby实例

首先列几个使用ruby执行的实例，测试代码模拟最简单的WEBrick服务器，端口设置为9292，有http请求时响应显示我们自定义的文字。

    #hello_rack.rb 
    require 'rack'
    
    #实例一
    ###########################################################
    
    class HelloRack
      def call(env)
        [200, {"Content-Type" => "text/html"}, ["Hello Rack! Now is #{Time.now}"]]
      end
    end
    #Rack::Handler::WEBrick.run HelloRack.new, :Port => 9292
    
    #实例二
    ###########################################################
    
    def application(env)
      [200, {"Content-Type" => "text/html"}, ["Hello Rack! Now is #{Time.now}"]]
    end
    
    #Rack::Handler::WEBrick.run method(:application), :Port => 9292
    
    #实例三
    ###########################################################
    
    my_rack_proc = lambda { |env| [200, {"Content-Type" => "text/plain"}, ["Hello Rack! Now is #{Time.now}"]] }
    Rack::Handler::WEBrick.run my_rack_proc, :Port => 9292

启动实例代码只需执行`ruby hello_rack.rb`，就会看到WEBrick的启动信息(WEBrick版本、ruby版本，启动端口，进程id),在浏览器地址栏输入`http://localhost:9292/`会显示我们自定义的文字，这就相当一次客户端http请求与服务器http响应。

中断实例代码的运行可以使用快捷键`Ctrl + C`.

    [root@allentest rb]# ruby hello_rack.rb 
    [2013-12-01 18:58:58] INFO  WEBrick 1.3.1
    [2013-12-01 18:58:58] INFO  ruby 1.9.2 (2011-02-18) [i686-linux]
    [2013-12-01 18:58:58] WARN  TCPServer Error: Address family not supported by protocol - socket(2)
    [2013-12-01 18:58:58] INFO  WEBrick::HTTPServer#start: pid=15673 port=9292
    localhost - - [01/Dec/2013:18:59:06 CST] "GET / HTTP/1.1" 200 44
    - -> /
    localhost - - [01/Dec/2013:18:59:07 CST] "GET /favicon.ico HTTP/1.1" 200 44
    - -> /favicon.ico
    localhost - - [01/Dec/2013:18:59:09 CST] "GET /favicon.ico HTTP/1.1" 200 44
    - -> /favicon.ico

### rack实例

rack安装包里包含了很多可以简化rack应用程序开发者工作的有用命令行工具，rackup便是其一。

rackup命令会自动侦测出当前运行环境的一些信息，使用默认的服务器适配置器(例如WEBrick,Mongrel.etc)来启动我们的程序。

按照默认约定，rackup执行的文件名称后缀必须为**.ru**,否则会报错。要执行的文件名称推荐为config.ru(文件名没有约定要求)。

**在不指定启动端口时，rackup默认启动端口为9292.**

    [root@allentest rb]# cat config.ru 
    #实例一
    ###########################################################
    
    #run lambda { |env| [200, {"Content-Type" => "text/plain"}, ["Hello Rack! Now is #{Time.now}"]] }
    
    
    #实例二
    ###########################################################
    
    #my_rack_proc = lambda { |env| [200, {"Content-Type" => "text/plain"}, ["Hello Rack! Now is #{Time.now}"]] }
    #Rack::Server.new( { :app => my_rack_proc, :server => 'webrick', :Port => 9292} ).start
    
    #实例二
    ###########################################################
    require "./my_app"
    run MyApp.new
    #等同于指定服务器Handler
    #Rack::Handler::WEBrick.run MyApp.new
    
    =begin
    #my_app.rb
    my_app.rb 
    class MyApp
      def call env
        [200, {"content-Type" => "text/html"}, ["Hello Rack! Now is #{Time.now}"]]
      end
    end
    =end


启动实例代码执行`rackup config.ru`，在浏览器地址栏输入`http://localhost:9292/`就会显示我们自定义的文字。

中断实例代码的运行可以使用快捷键`Ctrl + C`.

    [root@allentest rb]# rackup config.ru 
    [2013-12-01 19:21:37] INFO  WEBrick 1.3.1
    [2013-12-01 19:21:37] INFO  ruby 1.9.2 (2011-02-18) [i686-linux]
    [2013-12-01 19:21:37] WARN  TCPServer Error: Address family not supported by protocol - socket(2)
    [2013-12-01 19:21:37] INFO  WEBrick::HTTPServer#start: pid=16453 port=8080

### 小插曲

中断实例代码的运行可以使用快捷键`Ctrl + C`.但我按下快捷键`Ctrl + C`后，实例代码并没有中断，而是报了下面的错误:

    [2013-12-01 19:27:52] ERROR Interrupt: 
            /root/.rbenv/versions/1.9.2-p180/lib/ruby/1.9.1/webrick/server.rb:90:in `select'

查了资料后明白了其中原由，是因为启动的服务没有抓取到`SIGINT`,所以快捷键`Ctrl + C`会中断代码失败。

解决办法有两个:

+ 手工关闭进程
 
WEBrick启动信息里有进程pid，可以执行命令`kill -9 pid`或根据端口查找进程pid `netstat -tulpn | grep 9292` 或根据进程名称查找进程pid `ps aux | grep config.ru`(这个不方便，需要另打开一个命令行终端).

+ 代码中捕捉`SIGINT`

    #config.ru
    #原代码
    #my_rack_proc = lambda { |env| [200, {"Content-Type" => "text/plain"}, ["Hello Rack! Now is #{Time.now}"]] }
    #Rack::Server.new( { :app => my_rack_proc, :server => 'webrick', :Port => 9292} ).start
    ##########################################
    
    my_rack_proc = lambda { |env| [200, {"Content-Type" => "text/plain"}, ["Hello Rack! Now is #{Time.now}"]] }
    server = Rack::Server.new( { :app => my_rack_proc, :server => 'webrick', :Port => 9292} )
    
    trap 'INT' do server.shutdown end
    server.start

添加捕捉`SIGINT`的功能代码后，启动代码后再按快捷键`Ctrl + C`时，代码运行是被中断了，但也有报错的信息，不知道正常于否，把报错信息也贴下来，以后再补习...

    [root@allentest rb]# rackup confd.ru 
    [2013-12-01 19:44:38] INFO  WEBrick 1.3.1
    [2013-12-01 19:44:38] INFO  ruby 1.9.2 (2011-02-18) [i686-linux]
    [2013-12-01 19:44:38] WARN  TCPServer Error: Address family not supported by protocol - socket(2)
    [2013-12-01 19:44:38] INFO  WEBrick::HTTPServer#start: pid=17014 port=9876
    [2013-12-01 19:44:39] INFO  going to shutdown ...
    [2013-12-01 19:44:39] INFO  WEBrick::HTTPServer#start done.
    /root/.rbenv/versions/1.9.2-p180/lib/ruby/gems/1.9.1/gems/rack-1.5.2/lib/rack/builder.rb:133:in `to_app': missing run or map statement (RuntimeError)
            from /home/work/solife/script/rb/confd.ru:in `<main>'
            from /root/.rbenv/versions/1.9.2-p180/lib/ruby/gems/1.9.1/gems/rack-1.5.2/lib/rack/builder.rb:49:in `eval'
            from /root/.rbenv/versions/1.9.2-p180/lib/ruby/gems/1.9.1/gems/rack-1.5.2/lib/rack/builder.rb:49:in `new_from_string'
            from /root/.rbenv/versions/1.9.2-p180/lib/ruby/gems/1.9.1/gems/rack-1.5.2/lib/rack/builder.rb:40:in `parse_file'
            from /root/.rbenv/versions/1.9.2-p180/lib/ruby/gems/1.9.1/gems/rack-1.5.2/lib/rack/server.rb:277:in `build_app_and_options_from_config'
            from /root/.rbenv/versions/1.9.2-p180/lib/ruby/gems/1.9.1/gems/rack-1.5.2/lib/rack/server.rb:199:in `app'
            from /root/.rbenv/versions/1.9.2-p180/lib/ruby/gems/1.9.1/gems/rack-1.5.2/lib/rack/server.rb:314:in `wrapped_app'
            from /root/.rbenv/versions/1.9.2-p180/lib/ruby/gems/1.9.1/gems/rack-1.5.2/lib/rack/server.rb:250:in `start'
            from /root/.rbenv/versions/1.9.2-p180/lib/ruby/gems/1.9.1/gems/rack-1.5.2/lib/rack/server.rb:141:in `start'
            from /root/.rbenv/versions/1.9.2-p180/lib/ruby/gems/1.9.1/gems/rack-1.5.2/bin/rackup:4:in `<top (required)>'
            from /root/.rbenv/versions/1.9.2-p180/bin/rackup:23:in `load'
            from /root/.rbenv/versions/1.9.2-p180/bin/rackup:23:in `<main>'
    [root@allentest rb]# 

## 参考

+ [A Quick Introduction to Rack](http://rubylearning.com/blog/a-quick-introduction-to-rack/)
+ [How to stop Ruby WEBrick app from Terminal in Xubuntu](http://stackoverflow.com/questions/10075742/how-to-stop-ruby-webrick-app-from-terminal-in-xubuntu)
