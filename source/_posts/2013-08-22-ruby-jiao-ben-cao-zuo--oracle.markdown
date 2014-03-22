---
layout: post
title: ruby 脚本操作 oracle
date: 2013-08-22 05:39:09
comments: true
categories: code
---
## bash操作ruby

官方提供的`Sample one-liner`方式是在bash命令中实现的，但这是有前提的:**声明oracle用户所需要变量**。

如果在非oracle用户权限下使用ruby操作oracle，完整的`Sample one-liner`实现的代码如下:

    # ruby_con_oracle.sh
    ORACLE_SID=hello;export ORACLE_SID
    ORACLE_UNQNAME=ora11g;export ORACLE_UNQNAME
    ORACLE_BASE=/home/work/oracle;export ORACLE_BASE
    ORACLE_HOME=$ORACLE_BASE/product/11.2.0/db_1;export ORACLE_HOME
    NLS_LANG=AMERICAN_AMERICA.ZHS16GBK;export NLS_LANG
    PATH=$PATH:$ORACLE_HOME/bin:$HOME/bin;export PATH
    alias sqlplus='rlwrap sqlplus'
    
    ruby -r oci8 -e "OCI8.new('intfocus','focus_mail').exec('select * from dog_totle_data') do |r| puts r.join(','); end "

上面这种方式如果写复杂点的ruby功能代码不太方便,可以变通点的这样写:

    #ruby_con_oracle.sh
    ORACLE_SID=hello;export ORACLE_SID
    ORACLE_UNQNAME=ora11g;export ORACLE_UNQNAME
    ORACLE_BASE=/home/work/oracle;export ORACLE_BASE
    ORACLE_HOME=$ORACLE_BASE/product/11.2.0/db_1;export ORACLE_HOME
    NLS_LANG=AMERICAN_AMERICA.ZHS16GBK;export NLS_LANG
    PATH=$PATH:$ORACLE_HOME/bin:$HOME/bin;export PATH
    alias sqlplus='rlwrap sqlplus'
    
    ruby ruby_at_oracle.rb $*

    # ruby_at_oracle.rb
    require 'oci8'
    
    con = OCI8.new('intfocus','focus_mail')
    con.exec('select * from dog_totle_data') do |r|
      puts r.join(',');
    end

## 疑问

为什么使用`Kernel.system`来声明oracle环境变量就会报错呢？

    [root@oracle11g work]# vi ruby_oci.rb 
    # ruby_oci.rb 
    oracle_envs = %w[
    export RACLE_SID='hello';
    export ORACLE_UNQNAME='ora11g';
    export ORACLE_BASE='/home/work/oracle';
    export ORACLE_HOME='$ORACLE_BASE/product/11.2.0/db_1';
    export NLS_LANG=AMERICAN_AMERICA.ZHS16GBK;
    export PATH=$PATH:$ORACLE_HOME/bin:$HOME/bin;
    ]
    oracle_envs.each do |env_var|
      system(env_var)
    end
    
    require 'oci8'
    
    con = OCI8.new('intfocus','focus_mail')
    con.exec('select * from dog_totle_data') do |r|
      puts r.join(',');
    end
    [root@oracle11g work]# ruby ruby_oci.rb 

  报错信息如下：

    /usr/local/lib/ruby/site_ruby/1.9.1/rubygems/custom_require.rb:36:in `initialize': wrong number of arguments (2 for 0..1) (ArgumentError)
            from /usr/local/lib/ruby/site_ruby/1.9.1/rubygems/custom_require.rb:36:in `new'
            from /usr/local/lib/ruby/site_ruby/1.9.1/rubygems/custom_require.rb:36:in `require'
            from /usr/local/lib/ruby/site_ruby/1.9.1/rubygems/custom_require.rb:36:in `require'
            from /usr/local/lib/ruby/gems/1.9.1/gems/ruby-oci8-2.1.5/lib/oci8.rb:81:in `<top (required)>'
            from /usr/local/lib/ruby/site_ruby/1.9.1/rubygems/custom_require.rb:60:in `require'
            from /usr/local/lib/ruby/site_ruby/1.9.1/rubygems/custom_require.rb:60:in `rescue in require'
            from /usr/local/lib/ruby/site_ruby/1.9.1/rubygems/custom_require.rb:35:in `require'
            from ruby_oci.rb:15:in `<main>'

## 参考

+ [Stack Overflow ](http://stackoverflow.com/questions/1495035/how-to-automatically-export-oracle-environment-variable-required-to-run-a-ruby-s)
+ [Sample one-liner](http://ruby-oci8.rubyforge.org/en/index.html)
+ [Ray::Apps.blog](http://blog.rayapps.com/2008/04/24/how-to-setup-ruby-and-new-oracle-instant-client-on-leopard/)

## 当前实现方式
 
**使用oracle用户权限操作ruby脚本**

    require 'json'
    require "open-uri"
    require 'net/http'
    require 'uri'
    require 'oci8'
    
    hash = {}
    i = 0
    con = OCI8.new('intfocus','focus_mail')
    cursor = con.exec('select campaign_id,send_num,send_ok from dog_totle_data') do |r|
      hash[i]={:campaign_id => r[0], :send_num => r[1], :send_ok => r[2]}
      i += 1
    end
    #  puts hash
    
    focus_mail = "http://main.intfocus.com/open/dog_data"
    pp = {:dog_data => hash}
    
    header = {'Content-Type' => 'application/json'}
    uri = URI.parse(focus_mail)
    http = Net::HTTP.new(uri.host, uri.port)
    #http.open_timeout = 5
    #http.read_timeout = 5
    request = Net::HTTP::Post.new(uri.request_uri, header)
    request.body = pp.to_json
    
    begin
      response = http.request(request)
    rescue => e
      puts e.message
    else
      json_body = response.body #JSON.parse(response.body)
      puts json_body
    end
