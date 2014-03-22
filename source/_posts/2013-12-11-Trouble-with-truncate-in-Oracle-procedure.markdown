---
layout: post
title: Oracle储存过程中使用truncate报错
date: 2013-12-11 14:04:09
comments: true
categories: other
---
## 案发现场

有些定时更新表数据的动作索性写在存储过程中，定时执行存储过程就可以了。

在PL/SQL编辑器中操作truncate动作，可以成功执行。

    truncate table table_name

但是把truncate语言写到存储过程中，时会报错，有些莫名其妙。

    create or replace procedure procedure_name as
    begin
        truncate table table_name;
        commit;
    end;

报错信息:

    Compilation errors for PROCEDURE NEANDS3.PROCEDURE_NAME
    
    Error: PLS-00103: 出现符号 "TABLE"在需要下列之一时：
            := . ( @ % ;
           符号 ":=在 "TABLE" 继续之前已插入。
    Line: 3
    Text: truncate table table_name;

## 解决方案

查看了资源才发现，使用 EXECUTE AS 为数据库操作创建自定义权限。某些操作（如 TRUNCATE TABLE）没有可授予的权限。通过将 TRUNCATE TABLE 语句合并到存储过程中并指定该过程作为一个有权修改表的用户执行，您可以将截断表的权限扩展至授予其对过程的 EXECUTE 权限的用户。

解决的方案就是使用execute来执行truncate动作。下面的代码可以成功执行。

    create or replace procedure procedure_name as
    begin
        execute immediate 'truncate table table_name'; 
        commit;
    end;

## 参考

[Trouble with TRUNCATE in a procedure](http://searchoracle.techtarget.com/answer/Trouble-with-TRUNCATE-in-a-procedure)
