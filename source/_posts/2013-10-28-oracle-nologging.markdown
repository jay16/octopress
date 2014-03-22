---
layout: post
title: oracle - nologging
date: 2013-10-28 16:07:47
comments: true
categories: database
---
Nologging只在很少情况下生效.通常,DML操作总是要生成redo的.

话不多说,来看一下测试:

## Nologging & 运行模式

> Nologging跟数据库的运行模式有关.

### 1. 非归档模式

数据库运行在非归档模式下:

    SQL> archive log list;
    Database log mode              No Archive Mode
    Automatic archival             Enabled
    Archive destination            /opt/oracle/oradata/hsjf/archive
    Oldest online log sequence     155
    Current log sequence           157
    
    SQL> @redo
    SQL> create table test as select * from dba_objects where 1=0;
    
    Table created.
    
    SQL> select * from redo_size;
    
         VALUE
    ----------
         63392
    
    SQL>
    SQL> insert into test select * from dba_objects;
    
    10470 rows created.
    
    SQL> select * from redo_size;
    
         VALUE
    ----------
       1150988
    
    SQL>
    SQL> insert /*+ append */ into test select * from dba_objects;
    
    10470 rows created.
    
    SQL> select * from redo_size;
    
         VALUE
    ----------
       1152368
    
    SQL> select (1152368 -1150988) redo_append,(1150988 -63392) redo from dual;
    
    REDO_APPEND       REDO
    ----------- ----------
           1380    1087596
    
    SQL> drop table test;
    
    Table dropped.

可以看到在Noarchivelog模式下,对于常规表的insert append只产生少量redo。

### 2. 在归档模式下

    SQL> shutdown immediate
    Database closed.
    Database dismounted.
    ORACLE instance shut down.
    SQL> startup mount
    ORACLE instance started.
    
    Total System Global Area  235999908 bytes
    Fixed Size                   451236 bytes
    Variable Size             201326592 bytes
    Database Buffers           33554432 bytes
    Redo Buffers                 667648 bytes
    Database mounted.
    
    SQL> alter database archivelog;
    
    Database altered.
    
    SQL> alter database open;
    
    Database altered.
    
    SQL> @redo
    SQL> create table test as select * from dba_objects where 1=0;
    
    Table created.
    
    SQL> select * from redo_size;
    
         VALUE
    ----------
         56288
    
    SQL>
    SQL> insert into test select * from dba_objects;
    
    10470 rows created.
    
    SQL> select * from redo_size;
    
         VALUE
    ----------
       1143948
    
    SQL>
    SQL> insert /*+ append */ into test select * from dba_objects;
    
    10470 rows created.
    
    SQL> select * from redo_size;
    
         VALUE
    ----------
       2227712
    
    SQL> select (2227712 -1143948) redo_append,(1143948 -56288) redo from dual;
    
    REDO_APPEND       REDO
    ----------- ----------
        1083764    1087660
    
    SQL> drop table test;
    
    Table dropped.

我们看到在归档模式下,对于常规表的insert append产生和insert同样的redo

此时的insert append实际上并不会有性能提高.但是此时的append是生效了的

通过Logmnr分析日志得到以下结果:

    SQL> select operation,count(*) from v$logmnr_content group by operation;
    
    OPERATION                          COUNT(*)
    -------------------------------- ----------
    COMMIT                                   17
    DIRECT INSERT                      10470   
    INTERNAL                                49
    START                                      17

我们注意到这里是DIRECT INSERT,而且是10470条记录,也就是每条记录都记录了redo.

## Nologging & table

对于Nologging的table的处理:

### 1. 在归档模式下:

    SQL> create table test nologging as select * from dba_objects where 1=0;
    
    Table created.
    
    SQL> select * from redo_size;
    
         VALUE
    ----------
       2270284
    
    SQL>
    SQL> insert into test select * from dba_objects;
    
    10470 rows created.
    
    SQL> select * from redo_size;
    
         VALUE
    ----------
       3357644
    
    SQL>
    SQL> insert /*+ append */ into test select * from dba_objects;
    
    10470 rows created.
    
    SQL> select * from redo_size;
    
         VALUE
    ----------
       3359024
    
    SQL> select (3359024 -3357644) redo_append,(3357644 - 2270284) redo from dual;
    
    REDO_APPEND       REDO
    ----------- ----------
           1380    1087360
    
    SQL> drop table test;
    
    Table dropped.

我们注意到,只有append才能减少redo

### 2. 在非归档模式下:

    SQL> shutdown immediate
    Database closed.
    Database dismounted.
    ORACLE instance shut down.
    SQL> startup mount
    ORACLE instance started.
    
    Total System Global Area  235999908 bytes
    Fixed Size                   451236 bytes
    Variable Size             201326592 bytes
    Database Buffers           33554432 bytes
    Redo Buffers                 667648 bytes
    Database mounted.
    SQL> alter database noarchivelog;
    
    Database altered.
    
    SQL> alter database open;
    
    Database altered.
    
    SQL> @redo
    SQL> create table test nologging as select * from dba_objects where 1=0;
    
    Table created.
    
    SQL> select * from redo_size;
    
         VALUE
    ----------
         56580
    
    SQL>
    SQL> insert into test select * from dba_objects;
    
    10470 rows created.
    
    SQL> select * from redo_size;
    
         VALUE
    ----------
       1144148
    
    SQL>
    SQL> insert /*+ append */ into test select * from dba_objects;
    
    10470 rows created.
    
    SQL> select * from redo_size;
    
         VALUE
    ----------
       1145528
    
    SQL> select (1145528 -1144148) redo_append,(1144148 -56580) redo from dual;
    
    REDO_APPEND       REDO
    ----------- ----------
           1380    1087568
    
    SQL>                                          

同样只有append才能减少redo的生成.

biti给出过测试,说明在append模式下不会对数据产生undo

也就是说
**在Noarchivelog模式下的append操作将是性能最高的.**等价于对**Nologging表的append insert操作**

## 参考

[Nologging到底何时才能生效?](http://www.itpub.net/thread-242761-1-1.html)
