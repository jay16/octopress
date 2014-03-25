---
layout: post
title: CentOS系统上使用RVM安装Rails
date: 2014-01-23 12:38:14
comments: true
categories: [ruby,rails,bash,bi,mysql,database,centos,nginx]
---
## 安装RVM

    yum update
    
    yum install -y gcc-c++ patch readline readline-devel zlib zlib-devel libyaml-devel libffi-devel openssl-devel make bzip2 autoconf automake libtool bison iconv-devel curl
    
    curl -L get.rvm.io | bash -s stable
    source /etc/profile.d/rvm.sh
    
    rvm requirements
    rvm list known 

## 安装Ruby

    rvm install 1.9.2 #ruby version
    
    #指定默认ruby版本
    rvm --default use 1.9.2
    
    gem list
    gem sources -l
    gem sources --remove 要删除的源
    gem sources -a http://ruby.taobao.org/

## 安装 Rails

    gem install rails -v=3.2.3

## 安装 Passenger

    gem install passenger
    passenger-install-nginx-module

## 安装数据库

### sqlite

安装sqlite相关套件

    [root@localhost]# gem install sqlite3-ruby

### mysql 

    [root@localhost]# yum install mysql-server
    [root@localhost]# yum install mysql
    [root@localhost]# yum install mysql-devel 

启动mysql服务

    [root@localhost]# service mysqld start

登陆mysql,默认初始登陆密码为空

    [root@localhost]# mysql -u root -p
    Enter password:  (默认密码为空，直接回车)

修改mysql root登陆密码为Focus_Mail

    mysql> use mysql
    Database changed
    mysql> update user set password=password('Focus_Mail') where user='root';
    mysql> flush privileges;
    mysql> exit
    Bye

## 参考:

1. [安装rvm,ruby,rails,passenger,nginx在centos](http://www.zhuyinghao.com/2013/03/14/installing-rvm-ruby-rails-passenger-nginx-on-centos/)
2. [centos安装rvm（菜鸟安装）](http://blog.csdn.net/dzl84394/article/details/7750586)
