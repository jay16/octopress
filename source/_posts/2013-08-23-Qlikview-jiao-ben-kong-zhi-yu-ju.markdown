---
layout: post
title: Qlikview 脚本控制语句
date: 2013-08-23 08:30:08
comments: true
categories: BI,Qlikview
---
> QlikView 脚本由许多语句组成。一个语句可以为常规脚本语句和关键字(第217 页)或脚本控制语句。

> 控制语句通常用于控制脚本执行流程。控制语句中每一个子句必须保持在一个脚本行内，以分号或行尾结束。

> 前缀从不用于控制语句，除了when 和unless 前缀可用于少数指定的控制语句。

> 所有脚本关键字可以大小写字符集的任意组合输入。

## Sub..end sub

> sub..end sub 控制语句用于定义可从call 语句中调用的子例程。

    相应语法为：
    sub name [ ( paramlist )] 语句end sub
    其中：
    name 为子例程的名称。
    paramlist 是子例程形式参数变量名列表的逗号分隔符列表。这些可用作子例程内的任意变量。
    语句是一个或多个QlikView 脚本语句的任意组。
自变量将复制到子例程，而如果call 语句中相应实际参数是变量名，则退出子例程时这些参数将再次从现有子例程中复制回来。

如果通过call 语句，子例程中的形式参数比实际参数多，额外的形式参数将初始化为空值，且可在子例程中用作局部变量。

由于此sub 语句是控制语句，并以分号或行尾结束，其中各子句( sub 和end sub) 不可跨越行边界。

如果sub 语句在其他控制语句，例如For … Next 或If … Then 以内定义，则相应子例程仅在此控制语句的范围以内有效。换言之，如果子例程调用应在控制语句以外做出，则sub 语句不可在相应控制语句以内定义。在使用控制语句内部的include 系统变量时，如果子例程在所包含的脚本文件以内定义，则上述情况同样会发生。

    // 示例1
    sub INCR (I,J)
      I = I + 1
      exit sub when I < 10
      J = J + 1
    end sub
    
    call INCR (X,Y)
    -------------------------------------------------------
    // 示例2 - 参数转移
    sub ParTrans (A,B,C)
      A=A+1
      B=B+1
      C=C+1
    end sub
    A=1
    X=1
    C=1
    call ParTrans (A, (X+1)*2)
    //以上结果将在本地子例程内，A 将初始化为1，B 将初始化为4，C 将初始化为空值。
    //退出子例程时，全局变量A 会将2 作为值( 从子例程复制回来) 。第二个实际参数“(X+1)*2” 不
    //会复制回来，因为其不是变量。最终，全局变量C 不会受到子例程调用的影响。


## Call

> call 控制语句可调用必须由先前的sub 语句定义的子例程。

    相应语法为：
    callname ( [ paramlist ])
    其中：
    name 为子例程的名称。
    paramlist 为实际参数逗号分隔符列表，用以发送至子例程。此列表中每
    个项目都可为字段名，变量或任意表达式。
    由一条call 语句调用的子例程必须由在脚本执行期间更先遇到的sub 语句定义。
    参数会复制到子例程中，此外，如果在call 语句中的参数是一个变量而非表达式，重新将其复
    制到现有子例程中。
    由于该call 语句是一个控制语句，其以分号或终止线结束，且不允许跨过行边界。

    // 示例1
    sub INCR (I,J)
    I = I + 1
    exit sub when I < 10
    J = J + 1
    end sub
    call INCR (X,Y)
    -------------------------------------------------------
    // 示例2 - 列出磁盘上的所有QV 相关文件
    sub DoDir (Root)
      for each Ext in 'qvw', 'qvo', 'qvs', 'qvt', 'qvd'
        for each File in filelist (Root&'\*.'&Ext)
          Load '$(File)' as Name, 
               FileSize( '$(File)' ) as Size, 
               FileTime( '$(File)' ) as FileTime 
               autogenerate 1;
               
         next File
       next Ext
    
      for each Dir in dirlist (Root&'\*' )
        call DoDir (Dir)
      next Dir
    end sub
    
    call DoDir ('C:')

## Do..loop

> do..loop 控制语句是一个脚本迭代构造，可不断执行一个或几个语句，直到逻辑条件得到满足为止。

    相应语法为：
    do[ ( while | until ) condition ] [statements]
    [exit do [ ( when | unless ) condition ] [statements]
    loop[ ( while | until ) condition ]
    其中：
    condition 是评估“真”或“假”的逻辑表达式。
    语句是一个或多个QlikView 脚本语句的任意组。

**while 或until 条件子句在任何do..loop 语句中必须只能出现一次，即要么在do 之后，要么在
loop 之后。**只有首次遇到时才会解释每一个条件，但在循环中每次遇到时都会作评估。

如果在循环内遇到exit do 子句，将转换至表示循环结束的loop 子句之后的第一个语句来执行脚本。exit do 子句可以通过选择性使用when 或unless 前缀有条件地创建。

由于do..loop 语句是控制语句，并且又因为是以分号或行尾结束，因此这三个可能用到的子句(do，exit do 和loop) 每一个都不能跨过行边界。

    //示例：
    // load files file1.csv..file9.csv
    for a=1
    do while a<10
      load * from file$(a).csv;
      let a=a+1;
    loop

## Exit Script

> exit script 控制语句可以**停止执行脚本**。可以插入到脚本的任何位置。exit script 语句可以通过选择性使用when 或unless 子句有条件地创建。

    相应语法为：
    exit script[ (when | unless) condition ]
    其中
    condition 是评估“真”或“假”的逻辑表达式。
    由于exit script 语句是一个控制语句，并且由于此控制语句是以分号或行尾结束，因此不能跨越线框。

    //示例：
    exit script
    exit script;
    exit script when a=1


## For..next

> for..next 控制语句是一个带有计数器的脚本迭代构造。指定的高低限值之间的计数器变量的每个值均会执行由for 和next 限定的循环中的语句。

    相应语法为：
    forcounter = expr1 to expr2 [ step expr3 ]
    [statements]
    [exit for [ ( when | unless ) condition ]
    [statements]
    next[counter]
    其中：
    counter 即变量名。如果计数器在next 之后指定，变量名必须与对应的for 之后查找的变量名相同。
    expr1 是一个表达式，可决定与应执行循环有关的计数器变量的第一个值。
    expr2 是一个表达式，可决定与应执行循环有关的计数器变量的最后一个值。
    expr3 是一个表达式，可决定每执行一次循环计数器变量增加的值。
    condition 是评估“真”或“假”的逻辑表达式。
    statements 是一个或多个QlikView 脚本语句的任意组。

表达式expr1，expr2 和expr3 仅会在首次输入循环时进行评估。计数器变量的值可通过循环内的语句进行更改，但这并非出色的编程做法。

如果在循环内遇到exit for 子句，则脚本执行会转移至表示循环结束的next 子句之后的第一个语句。exit for 子句可通过选择性使用when 或unless 后缀变为有条件子句。

由于for ..next 语句是控制语句，并以分号或行尾结束，三个可能子句(for..to..step，exit for 和next) 中任意一个子句不得跨越行边界。

    //示例：
    // load files file1.csv..file9.csv
    FOR a=1 to 9
      LOAD * FROM file$(a).csv;
    NEXT
    
    FOR counter=1 to 9 step 2
      SET filename=x$(counter).csv;
      IF rand( )<0.5 THEN
        EXIT For Unless counter=1
      END IF
      LOAD a,b FROM $(filename);
    NEXT

## For each..next

> for each..next 控制语句是一个脚本迭代构造，可为逗号分隔列表中的每个值执行一个或几个语句。列表中的每个值均会执行由for 和next 限定的循环中的语句。特殊语法可以生成带有当前目录内文件和目录名称的列表。

    相应语法为：
    for each var in list
    [statements]
    [exit for [ ( when | unless ) condition ]
    [statements]
    next[var]
    其中：
    var 是脚本变量名称，可为每次循环执行获取列表中的新值。如果var 在next 之后指定，变量名必须与对应的for each 之后查找的变量名相同。
    list := item { , item }
    item := constant | (expression) | filelistmask | dirlistmask
    constant 是任意数字或字符串。请注意，直接在脚本中写入的字符串必须附上单引号。没有单引号的字符串将被解释为变量，而变量的值之后将被使用。数字不必附上单引号。
    expression 是任意表达式。
    mask 是文件名称或目录名称掩码，包括任何有效的文件名称字符及标准通配符，比如* 和?。
    condition 是评估“真”或“假”的逻辑表达式。
    statements 是一个或多个QlikView 脚本语句的任意组。
    filelistmask 语法会在匹配文件名称掩码的当前目录中生成逗号分隔的全部文件列表。dirlistmask语法会在匹配目录名称掩码的当前目录中生成逗号分隔的全部目录列表。

var 变量的值可通过循环内的语句进行更改，但这并非出色的编程方法。

如果在循环内遇到exit for 子句，则脚本执行会转移至表示循环结束的next 子句之后的第一个语句。exit for 子句可通过选择性使用when 或unless 后缀变为有条件子句。

由于for each..next 语句是控制语句，并以分号或行尾结束，三个可能子句( for each，exit for 和next) 中任意一个子句不得跨越行边界。

    //示例：
    FOR Each a in 1,3,7,'xyz'
      LOAD * FROM file$(a).csv;
    NEXT
    // list all QV related files on disk
    SUB DoDir (Root)
      FOR Each Ext in 'qvw', 'qva', 'qvo', 'qvs'
        FOR Each File in filelist (Root&' \*.'&Ext)
          LOAD  '$(File)' as Name,Size, 
                 FileTime( '$(File)') as FileTime
                 FileTime( '$(File)') as FileTime
          autogenerate 1;
        NEXT File
      NEXT Ext
      FOR Each Dir in dirlist (Root&' \*' )
        call DoDir (Dir)
      NEXT Dir
    ENDSUB
    
    CALL DoDir ('C:')

##If..then..elseif..else..end if

> if..then 控制语句是一个脚本选择结构，其可根据一个或几个逻辑条件按照不同路径强制执行脚本。

    相应语法为：
    ifcondition then
    [ statements ]
    { elseif condition then
    [ statements ] }
    [ else
    [ statements ] ]
    end if
    其中：
    condition 是可以被评估为“真”或“假”的逻辑表达式。
    statements 是一个或多个QlikView 脚本语句的任意组。

由于if..then 语句是控制语句，并且又因为是以分号或行尾结束，因此这四个可能用到的子句(if..then，elseif..the
n，else 和end if) 每一个都不能跨过行边界。

    示例：
    if a=1 then
      load * from abc.csv;
      sql select e, f, g from tab1;
    end if
    
    if a=1 then; drop table xyz; end if;
    
    if x>0 then
      load * from pos.csv;
    elseif x<0 then
      load * from neg.csv;
    else
      load * from zero.txt;
    end if


## Switch..case..default..end switch

> switch 控制语句是一个脚本选择项构造，根据表达式值，以不同路径强制执行脚本。

    相应语法为：
    switch expression { 
      case valuelist [ statements ]} [ default statements ]
    end switch
    其中：
    expression 是任意表达式。
    valuelist 是逗号分隔的值列表，可以在其中比较表达式的值。

执行此脚本将继续沿用第一组中在值列表和表达式中相等的值的语句。
值列表中的每一个值都可以是任意表达式。如果在任意case 子句中都无匹配值，则将执行default 子句下的语句( 如果指定的话) 。

语句是一个或多个QlikView 脚本语句的任意组。

由于switch 语句是控制语句，并且又因为是以分号或行尾结束，因此这四个可能用到的子句( switch，case，default 和end switch) 的每一个都不能跨过行边界。

    示例：
    switch I
    case 1
       load '$(I):CASE 1'  as case autogenerate 1;
    case 2
       load '$(I):CASE 2'  as case autogenerate 1;
    default
       load '$(I):DEFAULT' as case autogenerate 1;
    end switch
