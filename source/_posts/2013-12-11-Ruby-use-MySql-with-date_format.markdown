---
layout: post
title: Ruby操作MySql的日期格式
date: 2013-12-11 13:15:24
comments: true
categories: [ruby,mysql,html]
---
## 起因

有时从数据库抓取到数据后,为了显示格式再对数据再操作一遍。数据格式显示问题能在抓取数据时解决掉就不要放在后面再浪费代码了。

    # sql date_format
    mysql> select date_format(created_at,"%Y-%m-%d %H:%i:%S") from tracks;
    +---------------------------------------------+
    | date_format(created_at,"%Y-%m-%d %H:%i:%S") |
    +---------------------------------------------+
    | 2013-08-13 13:07:29                         | 
    +---------------------------------------------+
    1 rows in set (0.00 sec)

    # ruby strftime
    dog_data.created_at.strftime("%Y-%m-%d %H:%M:%S")

在controller中使用实例

    @consumes = Consume.select("day(created_at) as day, year(created_at) as year,month(created_at) as month,sum(volue) as sum_value")
      .group("year(created_at),month(created_at),day(created_at)")
      .order("year(created_at),month(created_at),day(created_at)")
          
    #params[:consume_date] = 2013109 201333
    @consumes = Consume.where("date_format(created_at,'%Y%c%e')=#{params[:consume_date]}")

## MySql Format

 The following specifiers may be used in the format string. The “%” character is required before format specifier characters.


| Specifier | Description |
|-----------|-------------|
|  %a  | Abbreviated weekday name (Sun..Sat)                                                              |
|  %b  |  Abbreviated month name (Jan..Dec)                                                                 |
|  %c  |  Month, numeric (0..12)                                                                            |
|  %D  |  Day of the month with English suffix (0th, 1st, 2nd, 3rd, …)                                      |
|  %d  |  Day of the month, numeric (00..31)                                                                |
|  %e  |  Day of the month, numeric (0..31)                                                                 |
|  %f  |  Microseconds (000000..999999)                                                                     |
|  %H  |  Hour (00..23)                                                                                     |
|  %h  |  Hour (01..12)                                                                                     |
|  %I  |  Hour (01..12)                                                                                     |
|  %i  |  Minutes, numeric (00..59)                                                                         |
|  %j  |  Day of year (001..366)                                                                            |
|  %k  |  Hour (0..23)                                                                                      |
|  %l  |  Hour (1..12)                                                                                      |
|  %M  |  Month name (January..December)                                                                    |
|  %m  |  Month, numeric (00..12)                                                                           |
|  %p  |  AM or PM                                                                                          |
|  %r  |  Time, 12-hour (hh:mm:ss followed by AM or PM)                                                     |
|  %S  |  Seconds (00..59)                                                                                  |
|  %s  |  Seconds (00..59)                                                                                  |
|  %T  |  Time, 24-hour (hh:mm:ss)                                                                          |
|  %U  |  Week (00..53), where Sunday is the first day of the week                                          |
|  %u  |  Week (00..53), where Monday is the first day of the week                                          |
|  %V  |  Week (01..53), where Sunday is the first day of the week; used with %X                            |
|  %v  |  Week (01..53), where Monday is the first day of the week; used with %x                            |
|  %W  |  Weekday name (Sunday..Saturday)                                                                   |
|  %w  |  Day of the week (0=Sunday..6=Saturday)                                                            |
|  %X  |  Year for the week where Sunday is the first day of the week, numeric, four digits; used with %V   |
|  %x  |  Year for the week, where Monday is the first day of the week, numeric, four digits; used with %v  |
|  %Y  |  Year, numeric, four digits                                                                        |
|  %y  |  Year, numeric (two digits)                                                                        |
|  %%  |  A literal “%” character                                                                           |
|  %x  |  x, for any “x” not listed above                                |

## 参考

+ [MySql - Date and Time Functions](https://dev.mysql.com/doc/refman/5.6/en/date-and-time-functions.html#function_date-format)
