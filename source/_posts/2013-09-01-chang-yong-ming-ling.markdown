---
layout: post
title: 常用命令
date: 2013-09-01 06:33:58
comments: true
categories: [error,ruby,bi,cognos,mysql,linux,nginx]
---
## sqlserver 整数转化为浮点

>  某计算字段是两个整型除出来的,结果显示为0,需要在除计算前转换为浮点型,除出来的结果也为浮点型,结果才是正确的.

    cast(sum(int_col1) as numeric(9,2))/cast(sum(int_col2) as numeric(9,2))

## cognos取前10名

  cognos中使用`rank(field desc) <= 10 `取到的是前10名,其中某名次可能不止一个,即前10名不止10行;
  
  如果想排序后仅取前10行应该使用`running-count(rank()) <= 10 `则会取到排序后的前10行数据。
  
## Apanta多行注释

    Shift + Alt + A => Shift + 上/下键

## 根据pid判断进程是否存在

> 用法： kill -0 pid 

> 解释： kill -0 就是不发送任何信号，但是系统会进行错误检查。 经常用来检查一个进程是否存在; 

> **当进程不存在时， kill -0 pid会返回错误。**


1. kill中若pid为0，则表示对进程自身执行kill操作。
2. kill并不一定结束进程，仅仅表示对进程发送信号量而已。

[参考](http://hi.baidu.com/0998123474/item/f2e0f5c7272a95dfef183bf2)


## SELinux

    #SELinux配置文件位置:
    /etc/selinux/config
    
    #显示当前的 SELinux的信息
    [root@allentest ~]# sestatus
    SELinux status:                 disabled
    [root@allentest ~]# sestatus -v
    SELinux status:                 disabled
    
    #得到当前的SELINUX值
    [root@allentest ~]# getenforce
    Disabled
    
    #更改当前的SELINUX值
    #后面可以跟 enforcing,permissive 或者 1,0。
    setenforce 0

## mysql远程登陆授权 

    #报错
    Host '192.168.0.128' is not allowed to connect to this MySQL server (Mysql2::Error)
    
    #原因:
    帐号不允许从远程登陆，只能在localhost
    
    #解决方法：
    1.修改表内容
    [root@localhost jay]#  mysql -u root -pMy_Passwd
    mysql> use mysql;
    mysql> update user set host = ‘%’ where user = ‘root’;
    
    2.授权
    mysql> use mysql;
    mysql> GRANT ALL PRIVILEGES ON *.* TO ‘root’@‘192.168.0.128′ IDENTIFIED BY ’My_Passwd′ WITH GRANT OPTION;

## 禁止root远程ssh登陆

    #修改ss配置档
    [root@localhost jay]# vi /etc/ssh/sshd_config 
    PermitRootLogin no
    
    #重启ssh服务
    [root@localhost jay]# /etc/init.d/sshd restart
    Stopping sshd: [  OK  ]
    Starting sshd: [  OK  ]

## 根据pid重启进程

    [webmail@mg log]$ kill -HUP cat mgmailerd_qq_eth0.pid

`deliver.policy,间隔是tab符 RCPT_STR @ BIND_REMOTE_DELIVER_IP 0.0.0.0`


## linux命令符界面

    ctrl + k  - 清除当前鼠标位置后的字符
    ctrl + u  - 清除当前鼠标位置前的字符
    ctrl +  insert  - 复制当前选中字符串
    shift + insert  - 粘贴剪贴板上内容

## 动态查看log

    #实时查看文本内容,文本内容有变化时，界面会跳动变化
    tail *.log -f     或  tail -f *.log

## 根据端口号搜索进程

    [root@allentest solife]# netstat -tulpn | grep 80
    tcp 0 0 0.0.0.0:80 0.0.0.0:*  LISTEN  7405/nginx: worker  
    

## 根据关键字搜索进程

    #grep不显示自身搜索进程
    ps -ef | grep keyword | grep -v grep

## tar忽略创建时间

    #tar解压时不显示时间戳提示 -m,解压到指定路径 -C
    tar -xzvmf  hhh.tar.gz  -C /mypath

## 查看文本行数

    #查看文本行数
    [root@allentest solife]# wc -l Gemfile
    56 Gemfile
    #显示文件数量
    [root@allentest solife]# ls * | wc -l
    103

## grep用法


    #显示输出空行的行号
    [root@allentest solife]# cat Gemfile | grep -n "^$"
    #查看以gem开关的行数
    [root@allentest solife]# cat Gemfile | grep -c "gem"
    32
    #查看以gem(忽略大小写)开关的行数
    [root@allentest solife]# cat Gemfile | grep -ic "Gem"
    33
    #显示行号；显示匹配字符“Gem”所在的行的行号
    [root@allentest solife]# cat Gemfile | grep -n "Gem"
    27:# Gems used only for assets and not required
    #查看不以Gem开关的行数
    [root@allentest solife]# cat Gemfile | grep -vc "Gem"
    55
    #全字匹配
    [root@allentest solife]# cat Gemfile | grep -w  "bcrypt-ruby"
    # gem 'bcrypt-ruby', '~> 3.0.0'
    #多关键字搜索
    [root@allentest solife]# cat Gemfile | grep -E  "unicorn|bcrypt-ruby"
    # gem 'bcrypt-ruby', '~> 3.0.0'
    # Use unicorn as the app server
    # gem 'unicorn'
    22771
    
    1、参数：
    -I ：忽略大小写
    -c ：打印匹配的行数
    -l ：从多个文件中查找包含匹配项
    -v ：查找不包含匹配项的行
    -n：打印包含匹配项的行和行标
    
    2、RE（正则表达式）
    \ 忽略正则表达式中特殊字符的原有含义
    ^ 匹配正则表达式的开始行
    $ 匹配正则表达式的结束行
    \< 从匹配正则表达式的行开始
    \>; 到匹配正则表达式的行结束
    [ ] 单个字符；如[A] 即A符合要求
    [ - ] 范围 ；如[A-Z]即A，B，C一直到Z都符合要求
    . 所有的单个字符
    * 所有字符，长度可以为0

## 批量删除进程

    [root@localhost jay]# cat /home/jay/sh/kp.sh
    keyword=$1
    user=$2
    
    #必须提供一个参数
    #echo -e支持换行符\n
    if [ -z $1 ]; then
      echo -e "usage:kp keyword username \nplease offer argument!"
      exit
    fi
    
    #默认使用搜索webmail用户权限级别
    if [ -z ${user} ]; then
      user="webmail"
    fi
    
    echo "keyword:${keyword} - user:${user}"
    
    #使用awk分解ps命令返回字符串
    id_str=$(ps axuw | grep ${keyword} |               \
             grep -v grep |                            \
             awk -v awk_user="${user}" 'BEGIN { -F" "}  \
               {if($1==awk_user) printf("%s ",$2);}    \
               END { }')
    
    #id_str为从ps命令返回结果中取得的Pid，以空格分隔
    #id_ary为pid数组
    id_ary=(${id_str})
    id_num=${#id_ary[@]}
    
    echo "find [${id_num}] result."
    
    if [ ${id_num} -gt 0 ]; then
    
      #显示完整搜索结果
      #awk中$0为处理的当前字符串
      ps axuw | grep ${keyword} | grep -v grep | awk -v awk_user="${user}" 'BEGIN{ -F" "}  { if($1==awk_user) printf("%s\n ", $0);}'
    
      echo -n "kill the above ${id_num} process?(y/n)"
      read yn
    
      #输入内容非Y|y不作处理
      case ${yn} in
        Y|y)
         kill -9 ${id_str}
         echo "kill over!"
        ;;
        N|n)
         echo "do nothing"
        ;;
        *)
         echo "do nothing"
        ;;
      esac
    
    fi
    
