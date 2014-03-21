---
layout: post
title: webmail mailgate克隆
date: 2013-08-22 05:39:07
comments: true
categories: Ruby
---
    #encoding: utf-8
    require 'fileutils'
    
    mq_path   = "/mailgates/mqueue"
    copy_base = "/webmail"
    
    ip_base  = "64.78.168."
    ip_range = (227..254)
    
    domains  = %w(qq sina 126 163)
    
    domains.each_with_index do |domain, oi|
      ip_range.each_with_index do |ipnot, ii|
        #拼接ip
        ipstr = ip_base + ipnot.to_s
       
        #第一步:复制mqueue文件夹
        mqueue_name = "mqueue_#{domain}_eth#{ii}"
        mqueue_path = File.join(copy_base,mqueue_name)
        FileUtils.cp_r(mq_path,mqueue_path,{:preserve => true})
       
        #第二步:修改mqueue/conf
        #重命名:mgmailerd.conf => mgmailerd_163_eth0.conf
        mgmailerd_old = File.join(mqueue_path,"conf","mgmailerd.conf")
        mgmailerd_new = File.join(mqueue_path,"conf","mgmailerd_#{domain}_eth#{ii}.conf")
        FileUtils.mv(mgmailerd_old,mgmailerd_new)
    
        #修改原始内容
        buffer = File.open(mgmailerd_new).read.gsub("MaxMailers=32", "MaxMailers=1")
        File.open(mgmailerd_new, "w") { |fw| fw.write(buffer) }
    
        #追加日志配置信息
        File.open(mgmailerd_new,"a") do |file|
           file.puts("MaxQueueAge=1440")
           file.puts("WorkDir=/webmail/#{mqueue_name}")
           file.puts("LogFile=/webmail/mqueue_#{domain}_eth#{ii}/log/mgmailerd_#{domain}_eth#{ii}.log")
           file.puts("PidFile=/webmail/mqueue_#{domain}_eth#{ii}/log/mgmailerd_#{domain}_eth#{ii}.pid")
           file.puts("RulesFile=/webmail/mqueue_#{domain}_eth#{ii}/conf/rules.list")
           file.puts("DeliveryPolicy=/webmail/mqueue_#{domain}_eth#{ii}/conf/delivery.policy")
        end    
       
        
        #mqueue_163_eth0/conf添加deliver.policy文件
        deliver_policy = File.join(mqueue_path,"conf","delivery.policy")
        FileUtlis.rm(deliver_policy) if File.exist?(deliver_policy)
        File.open(deliver_policy,"w+") do |file|
           file.write("RCPT_STR        *@*     BIND_REMOTE_DELIVER_IP  #{ipstr}")
        end
    
        #第三步:修改mqueue/bin
        mgmailerd_old = File.join(mqueue_path,"bin","mgmailerd")
        mgmailerd_new = File.join(mqueue_path,"bin","mgmailerd_#{domain}_eth#{ii}")
        FileUtils.mv(mgmailerd_old,mgmailerd_new)
      end
    end

> 注意事项:

1. 执行权限需是webmail

2. 注意`/conf/*.deliver`文件内容配置

3. 使用`md5sum`对比拷贝文件是否相同 

4. mailgates由于不同系统环境需要添加`动态链接库`
