---
layout: post
title: Kettle 使用简述
date: 2013-10-26 23:34:15
comments: true
categories: [error,java,bi,kettle,linux]
---
## 简介

> Kettle是一款国外开源的ETL工具，纯java编写，可以在Window、Linux、Unix上运行，绿色无需安装，数据抽取高效稳定。

**强调一下，Kettle基于JVM,忽略外部系统环境。即32位系统上配置好的Kettle Job迁移到64位系统正常运行**

## 安装

更准确的说是**解压**,因为Kettle绿色无需安装，官网上下载适当版本后解压后即可。

## 准备工作

正是由于Kettle由java编写，要想使用kettle必须安装java,**安装java是区分系统位数的**

## Linux中使用

在提供界面的系统中(Windows中使用`spoon.bat`,Linux中使用`spoon.sh`),Kettle提供界面开发创建`transform`与`job`,`transform`是功能块，`job`是把多个功能模块串成完成的ETL流程.


下面为在Linux系统中调用Kettle job的命令行代码：

    #下面变量若不需要传入参数，则无需改动
    #kitchen.sh执行脚本
    kettle_sh="/mnt/work/etl/kettle/data-integration/kitchen.sh"            
    
    #声明java环境变量
    export JAVA_HOME=/usr/lib/jvm/java-7-sun
    export JRE_HOME=${JAVA_HOME}/jre
    export CLASSPATH=.:${JAVA_HOME}/lib:${JRE_HOME}/lib
    export PATH=${JAVA_HOME}/bin:$PATH
    
    #kitchen执行kettle job
    #kettle job中使用参数为: DATE_STR
    ${kettle_sh} -file=${kettle_job} -level=Rowlevel -log=${kettle_log}
    #${kettle_sh} -file=${kettle_job} -level=Rowlevel -log=${kettle_log} -param:DATE_STR=20130930

其中`log`的级别有:

    Error: Only show errors
    Nothing: Don't show any output
    Minimal: Only use minimal logging
    Basic: This is the default basic logging level
    Detailed: Give detailed logging output
    Debug: For debugging purposes, very detailed output.
    Rowlevel: Logging at a row level, this can generate a lot of data.

## Windows中使用

    rem win 定时任务 bat
    for /f "tokens=1,2,3 delims=/ " %%A in ('date /t') do set sDate=%%A-%%B-%%C
    
    D:\data-integration\Kitchen.bat /norep /file "D:\rfm job\ETL_All.kjb" /level Error /log "d:\rfm job\log\log.%sDate%.txt"
    
    pause
