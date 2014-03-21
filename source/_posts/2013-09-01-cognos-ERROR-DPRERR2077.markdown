---
layout: post
title: cognos ERROR - DPR-ERR-2077
date: 2013-09-01 06:31:28
comments: true
categories: Error,Cognos
---
## 报错

Cognos报表Query不知那里修改错了,忽然报出下面错误:

    DPR-ERR-2077
    Failed to forward the request because the associated external process with PID 5460 is unavailable, either because the process is shutting down, or this was an absolute affinity request and the requested process does not exist anymore. For more information, enable the dispatcher and the external process detailed logs, and reproduce the conditions that caused the error.

## 原因

  对比下面解决方案,报表Query里没有出现引起该错误的选项配置,解决步骤也无从着手.
  
  只好每个Query的Data Item测试排查,终于发现报错原因,其中**一个汇总数据项把total(dd)写成了sum(dd),在cognos中汇总函数是total.**
  

## 常规解决方案

  下面的解决方案以备后用吧.

    Cause
    The query associated with list object had the property 'Processing' set to database only, however the query had calculated data items which needs local processing, hence causing the error.
    
    Resolving the problem
    
    Steps to resolve the error:
    1. Open the report In Report Studio.
    2. Click on 'Query Explorer' and then select the query associated with list report.
    3. Set the property 'Processing' to Default or Limited Local
    4. 'Use Local Cache' as Default.
    5. Save the report.
    6. Now execute the report it should successfully.

## 参考:

http://www-01.ibm.com/support/docview.wss?uid=swg21615939
