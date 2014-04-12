---
layout: post
title: Ruby - 判断Rails.root
date: 2013-09-02 02:55:32
comments: true
categories: [ruby,rails]
---
  Rails的部分功能代码使用ruby调试时，一些宏定义会报错，需判断一下

      if Object.const_defined?("Rails") then
          @yaml_path = File.join(Rails.root,"lib","focus_agent","mail_servers.yml")
      else
          @yaml_path = File.join(Dir.pwd,"mail_servers.yml")
      end

查看Rails源代码时发现更简单玩更准确的方法:

    <%= defined?(Rails) && Rails.respond_to?(:root) ? Rails.root : "unset" %>
