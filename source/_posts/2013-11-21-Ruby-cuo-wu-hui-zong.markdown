---
layout: post
title: Ruby 错误汇总
date: 2013-11-21 09:55:13
comments: true
categories: CentOS,Shell,Ruby,Error
---

## Encoding

### Encoding::InvalidByteSequenceError

使用crontab定时执行shell脚本，在shell脚本结尾再调用ruby脚本，强调一下，手工执行ruby脚本是没有问题的，但shell脚本调用ruby脚本就会报出下面错误:

    /mnt/work/etl/crond/focusmail_log_report.rb:254:in `encode': "\xE6" on US-ASCII (Encoding::InvalidByteSequenceError)

### 错误原因

shell中的编码与ruby的编码冲突，解决方法就是在shell中声明ruby需要的编码:

    # Linux
    export LANG=en_US.UTF-8
    
    # OS X
    export LC_CTYPE=en_US.UTF-8

### 代码再现
crontab定时任务及shell调用ruby脚本代码如下:

    [root@oraclehost crond]# crontab -l
    #定时处理FcousMail log
    30 4 * * * /mnt/work/etl/crond/kettle_deal_log.sh byday > /mnt/work/etl/logs/crond_dogday_deal_byday.log 2>&1
    [root@oraclehost crond]# tail /mnt/work/etl/crond/kettle_deal_log.sh
    
    [root@oraclehost crond]# tail /mnt/work/etl/crond/kettle_deal_log.sh
    #生成日志报告
    export LANG=en_US.UTF-8
    #解决Encoding::InvalidByteSequenceError
    /usr/local/rvm/rubies/ruby-1.9.2-p320/bin/ruby /mnt/work/etl/crond/focusmail_log_report.rb

### 参考

[Cucumber fails with json Encoding::InvalidByteSequenceError](http://stackoverflow.com/questions/12130162/cucumber-fails-with-json-encodinginvalidbytesequenceerror)
