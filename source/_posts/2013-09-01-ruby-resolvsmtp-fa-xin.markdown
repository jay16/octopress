---
layout: post
title: ruby - resolv&smtp发信
date: 2013-09-01 04:43:50
comments: true
categories: Email,Ruby
---
    #使用resolv与smtp发信
    [root@localhost ruby]# vi dns_002.rb 
    #!/usr/local/bin/ruby -w
    require 'resolv'
    require 'net/smtp'
    
    from = "solife_li@126.com"
    to = "jay_li@intfocus.com"
    
    message = <<MESSAGE_END
    From: #{from}
    To: #{to}
    Subject: Direct e-mail test
    This is a test e-mail message.
    MESSAGE_END
    
    to_domain = to.match(/\@(.+)/)[1]
    
    Resolv::DNS.open do |dns|
      mail_servers = dns.getresources(to_domain, Resolv::DNS::Resource::IN::MX)
      mail_server = mail_servers[rand(mail_servers.size)].exchange.to_s
    
      Net::SMTP.start(mail_server) do |smtp|
        smtp.send_message message, from, to
      end
    end
