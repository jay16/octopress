---
layout: post
title: Oracle - 数据表导入&导出
date: 2013-09-22 14:14:47
comments: true
categories: [bash,bi,oracle,database]
---
## 概述

注意: 

1. **切换至oracle用户并声明oracle相关变量**
2. 涉及到数据库登陆用户名/密码,与数据库名称无关


+ 1.导出命令

    exp a/apwd           file=/home/a.sql  owner=a
    exp 登陆用户名/密码  file=导出文件位置 owner=数据表的创建者;

+ 2.导入命令

    imp b/bpwd          file=/home/a.sql    fromuser=a ignore=y
    imp 登陆用户名/密码 file=要导入文件位置 fromuser=要导入数据库表的创建者 ignore=y


## 导出

    [oracle@oracle11g exp]$ source ~/.bash_profile 
    [oracle@oracle11g exp]$ echo $ORACLE_BASE
    /home/work/oracle
    [oracle@oracle11g exp]$ exp intfocus/mypasswd  file=./mail_exp.dmp owner=intfocus;
    
    Export: Release 11.2.0.1.0 - Production on Sun Sep 22 13:55:25 2013
    
    Copyright (c) 1982, 2009, Oracle and/or its affiliates.  All rights reserved.
    
    
    Connected to: Oracle Database 11g Enterprise Edition Release 11.2.0.1.0 - Production
    With the Partitioning, Oracle Label Security, OLAP, Data Mining,
    Oracle Database Vault and Real Application Testing options
    Export done in ZHS16GBK character set and AL16UTF16 NCHAR character set
    . exporting pre-schema procedural objects and actions
    . exporting foreign function library names for user INTFOCUS 
    . exporting PUBLIC type synonyms
    . exporting private type synonyms
    . exporting object type definitions for user INTFOCUS 
    About to export INTFOCUS's objects ...
    . exporting database links
    . exporting sequence numbers
    . exporting cluster definitions
    . about to export INTFOCUS's tables via Conventional Path ...
    . . exporting table                            ABC       7809 rows exported
    . . exporting table                    ACTION_LOGS      10133 rows exported
    . . exporting table                          IPMAP     252431 rows exported
    . . exporting table                         IP_MAP     252431 rows exported
    . exporting synonyms
    . exporting views
    . exporting stored procedures
    . exporting operators
    . exporting referential integrity constraints
    . exporting triggers
    . exporting indextypes
    . exporting bitmap, functional and extensible indexes
    . exporting posttables actions
    . exporting materialized views
    . exporting snapshot logs
    . exporting job queues
    . exporting refresh groups and children
    . exporting dimensions
    . exporting post-schema procedural objects and actions
    . exporting statistics
    Export terminated successfully without warnings.
    [oracle@oracle11g exp]$ 
    [oracle@oracle11g exp]$ 
    [oracle@oracle11g exp]$ 
    [oracle@oracle11g exp]$ 
    [oracle@oracle11g exp]$ ls    
    mail_exp.dmp
    [oracle@oracle11g exp]$ scp mail_exp.dmp root@192.168.0.1:/mnt/database/exp
    mail_exp.dmp                                  100%  483MB   1.5MB/s   05:14  

## 导入

    [root@oraclehost database]# su oracle
    [oracle@oraclehost database]$ ls
    exp  oracle  oradata
    [oracle@oraclehost database]$ echo $ORACLE_SID
    focusmail
    [oracle@oraclehost database]$ imp IntFocus/mypasswd file=exp/mail_exp.dmp fromuser=intfocus ignore=y
    
    Import: Release 11.2.0.1.0 - Production on Sun Sep 22 05:55:53 2013
    
    Copyright (c) 1982, 2009, Oracle and/or its affiliates.  All rights reserved.
    
    
    Connected to: Oracle Database 11g Enterprise Edition Release 11.2.0.1.0 - 64bit Production
    With the Partitioning, OLAP, Data Mining and Real Application Testing options
    
    Export file created by EXPORT:V11.02.00 via conventional path
    import done in US7ASCII character set and AL16UTF16 NCHAR character set
    import server uses ZHS16GBK character set (possible charset conversion)
    export client uses ZHS16GBK character set (possible charset conversion)
    . importing INTFOCUS's objects into INTFOCUS
    . . importing table                          "ABC"       7809 rows imported
    . . importing table                  "ACTION_LOGS"      10133 rows imported
    . . importing table                        "IPMAP"     252431 rows imported
    . . importing table                       "IP_MAP"     252431 rows imported
    Import terminated successfully without warnings.
