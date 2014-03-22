---
layout: post
title: Rails 错误 -  Bundler - -GemNotFound
date: 2013-08-22 05:39:08
comments: true
categories: error
---
> passenger start启动后报错:

    [ pid=945 thr=21483740 file=utils.rb:176 time=2012-05-18 16:34:15.823 ]: *** Exception PhusionPassenger::UnknownError in PhusionPassenger::Rack::ApplicationSpawner (Could not find rake-10.1.0 in any of the sources (Bundler::GemNotFound)) (process 945, thread #<Thread:0x000000028fa1b8>):

> 但rake已经升级到10.1.0版本:

    [root@allentest solife]# bundle list rake
    /home/work/solife/vendor/cache/ruby/1.9.1/gems/rake-10.1.0
    [root@allentest solife]# gem list rake
    
    *** LOCAL GEMS ***
    
    rake (10.1.0, 10.0.4, 10.0.3, 0.8.7)

> google后解决方法:(把gem包下载到项本地,再运行,正常启动.)

    [root@allentest solife]# bundle install --path vendor/cache
