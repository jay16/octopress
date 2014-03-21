---
layout: post
title: Linux - crontab & RubyGem - whenever
date: 2013-10-28 23:23:59
comments: true
categories: Gem,Ruby,Linux
---
## crontab

### 用法&格式

| 字段 | 1 | 2 | 3 | 4 | 5 | 6 |
|:---:|:--:|:---:|:--:|:---:|:--:|:---:|:--:|
| 格式 | * | *  | * | * | * | command |
| 意义 | 分钟 | 小时 | 日期 | 月份 | 星期 | 待执行命令 |
| 范围 | 0-59 | 1-23 | 1-31 | 1-12 | 0-6 | - |

注:

1. `*` 表示任何时刻
2. `,` 表示分割

## 编辑命令

1. `crontable -l`  查看所有定时任务
2. `crontable -e`  编辑定时任务
3. `crontable -r`  删除所有定时任务

## 重定向

并将错误输出2重定向到标准输出1，然后将标准输出1全部放到crontab.log  文件。

-  0 表示键盘输入
-  1 表示标准输出
-  2 表示错误输出.

## 实例

    [root@localhost script]# cat crontab.conf 
    #每分钟把当前日期时间写入log，确保crontab正常运行
    * * * * * echo $(date) > chkcrond.log 2>&1
    30 3 * * * ruby /home/webmail/work/focus_agent/script/gether_log.rb 2>&1

`2>&1`表示标准输出与错误信息都写入

使上述设置起效，使用`crontab`调用该配置脚本

    [root@localhost script]# crontab crontab.conf 
    [root@localhost script]# crontab -l 
    #每分钟把当前日期时间写入log，确保crontab正常运行
    * * * * * echo $(date) > chkcrond.log 2>&1
    30 3 * * * ruby /home/webmail/work/focus_agent/script/gether_log.rb 2>&1

