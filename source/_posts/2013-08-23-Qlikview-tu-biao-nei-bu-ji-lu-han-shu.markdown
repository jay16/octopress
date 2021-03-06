---
layout: post
title: Qlikview 图表内部记录函数
date: 2013-08-23 07:02:38
comments: true
categories: [qlikview]
---
> 这些函数只可用于图表表达式中。

****
**注意！**

当图表内部记录函数用于任何图表表达式时，按图表Y 值排序或者按垂直表表达式列排序不
可用。因此，这些排序替代项会自动禁用。

当使用这些函数时，消零值自动禁用。

参见图表间记录函数示例(第821 页)。

****

## Fieldvalue

> Fieldvalue(fieldname , n)

> 返回在字段字段名的n位置发现的字段值(按载入顺序)。**字段名必须是字符串值**，例如**字段名必须用单引号括起来**。返回n=1 的首个字段值。

> **如果n 比字段值数值大，则返回空值。**

    示例：
    fieldvalue( 'Helptext', 5 )

## FieldIndex

> FieldIndex(fieldname , value )

> 返回字段字段名内字段值值的位置( 依据加载顺序) 。如果值无法在字段字段名的字段值内找到，则会返回0。**字段名必须是字符串值**，例如字段名必须用单引号括起来。

    示例：
    fieldindex( 'Name', 'John Doe' )

## 维度()

> 返回包含非聚合函数内容的维度列数，即不包含部分总和或折叠聚合。

> 典型的应用是，当您想要应用不同的单元格格式化时，在特性表达式内使用该函数，具体取决于数据的聚合级别。

> 此函数仅可用于图表。对于除透视表之外的所有图表类型，它会返回除总计之外的所有行的维度数，即0。

> 参见图表间记录函数示例(第821 页)。

## secondarydimensionality

> secondarydimensionality ( )

> 平透视表维度的dimensionality() 函数。

> ** secondarydimensionality() 函数用于透视表之外时总是会返回0。**

> 参见图表间记录函数示例(第821 页)。

## above

> above([ total ] expression [ , offset [,n ]])

> 返回使用图表的维度值评估的表达式值，因为维度值显示在表格，位图图表或图表的垂直表等同物的列段的当前行之上的行( 实际上，所有QlikView 图表均拥有垂直表等同物，但拥有更复杂结构的透视表除外) 。

> **列段的第一行会返回空值，因为其上没有行。**

> 如果图表是一维的或如果表达式前面有一个total 限定符，当前的列片断总是与整列相等。如果表格或类似物有多个垂直维度，当前的列片断将只包括值与全部维度列的当前行相同的行，除了显示字段排序间上一次维度的列之外。透视表的内部字段排序只需依据从左至右的维度顺序定义。对于其他图表类型，这可在图表属性：排序对话框中操纵。

> 指定大于1 的偏移量可让您移动表达式评估至当前行之上的行。负偏移量值实际会促使above函数等同于带有相应正偏移量值的below函数。指定0 偏移量会评估当前行上的表达式。递归调用将返回空值。

> **通过指定第三个参数n 大于1，函数返回的不是一个值，而是一连串n值，每个值对应一个从原始单元格开始向上计数的n表格行。**此时，该函数用作任何特殊图表范围函数(第792 页)的参数。

    示例：
    sum( Sales ) / above( sum( Sales ))
    above( sum( Sales ), 2 )
    above( total sum( Sales ))
    rangeavg(above(sum(x),1,3)) //返回评估当前行上方三行的sum(x) 函数的三个结果的平均值。

## below

> below([ total ] expression [ , offset [,n ]])

> 返回使用图表的维度值评估的表达式，因为维度值显示在表格，位图图表或图表的垂直表等同物的列段的当前行之下的行。

> **列段的最后一行会返回空值，因为其下没有行。**

> 如果图表是一维的或如果表达式前面有一个total 限定符，当前的列片断总是与整列相等。

> 如果表格或类似物有多个垂直维度，当前的列片断将只包括值与全部维度列的当前行相同的行，除了显示字段排序间上一次维度的列之外。透视表的内部字段排序只需依据从左至右的维度顺序定义。对于其他图表类型，这可在图表属性：排序对话框中操纵。

> 指定大于1 的偏移量可让您移动表达式评估至当前行之下的行。负偏移量值实际会促使below函数等同于带有相应正偏移量值的above函数。指定0 偏移量会评估当前行上的表达式。递归调用将返回空值。

> **通过指定第三个参数n 大于1，函数返回的不是一个值，而是一连串n值，每个值对应一个从原始单元格开始向下计数的n表格行。**此时，该函数用作任何特殊图表范围函数(第792 页)的参数。

    示例：
    below( sum( Sales ))
    below( sum( Sales ), 2 )
    below( total sum( Sales ))
    rangeavg(below(sum(x),1,3)) //返回评估当前行下方三行的sum(x) 函数的三个结果的平均值。

## top

> top([ total ] expression [ , offset [,n ]])

> 返回使用图表的维度值评估的表达式，因为维度值显示在表格，位图图表或图表的垂直表等同物的当前列段的第一行。

> 如果图表是一维的或如果表达式前面有一个total 限定符，当前的列片断总是与整列相等。

> 如果表格或类似物有多个垂直维度，当前的列片断将只包括值与全部维度列的当前行相同的行，除了显示字段排序间上一次维度的列之外。透视表的内部字段排序只需依据从左至右的维度顺序定义。对于其他图表类型，这可在图表属性：排序对话框中操纵。

> 指定大于1 的偏移量可让您移动表达式评估至顶行之下的行。负偏移量值实际会促使top函数等同于带有相应正偏移量值的bottom函数。递归调用将返回空值。

> 通过指定第三个参数n 大于1，函数返回的不是一个值，而是一连串n值，每个值对应当前列段的第一个n行中的一行。此时，该函数用作任何特殊图表范围函数(第792 页)的参数。

    示例：
    sum( Sales ) / top( sum( Sales ))
    top( sum( Sales ), 2 )
    top( total sum( Sales ))
    rangeavg(top(sum(x),1,5)) //返回评估当前列段顶部五行的sum(x) 函数的结果的平均值。

## bottom

> bottom([ total ] expression [ , offset [,n ]])

> 返回使用图表的维度值评估的表达式，因为维度值显示在表格，位图图表或图表的垂直表等同物的当前列段的最后一行。

> 如果图表是一维的或如果表达式前面有一个total 限定符，当前的列片断总是与整列相等。

> 如果表格或类似物有多个垂直维度，当前的列片断将只包括值与全部维度列的当前行相同的行，除了显示字段排序间上一次维度的列之外。透视表的内部字段排序只需依据从左至右的维度顺序定义。对于其他图表类型，这可在图表属性：排序对话框中操纵。

> 指定大于1 的偏移量可让您移动表达式评估至底行之上的行。负偏移量值实际会促使bottom函数等同于带有相应正偏移量值的top函数。递归调用将返回空值。

> 通过指定第三个参数n 大于1，函数返回的不是一个值，而是一连串n值，每个值对应当前列段的最后一个n行中的一行。此时，该函数用作任何特殊图表范围函数(第792 页)的参数。

    示例：
    bottom( sum( Sales ))
    bottom( sum( Sales ), 2 )
    bottom( total sum( Sales ))
    rangeavg(bottom(sum(x),1,5)) //返回评估当前列段底部五行的sum(x) 函数的结果的平均值。

## before

> before([ total ] expression [ , offset [,n ]])

> 返回使用透视表的维度值评估的表达式，因为维度值显示在透视表的行段内当前列之前的列。

> **除透视表之外的所有图表类型中，此函数均会返回空值。**

> 行段的第一列会返回空值，因为其前没有列。

> 如果表格是单维度，或者如果表达式先于总计限定符，则当前行段总是等同于整行。

> 如果透视表有多个水平维度，当前的行片断将只包括值全部维度行当前列相同的列，除了显示字段排序间上一次水平维度的行之外。透视表的水平维度的内部字段排序只需依据从上至下的维度顺序定义。

> 指定大于1 的偏移量可让您移动表达式评估至当前行更靠左的列。负偏移量值实际会促使before函数等同于带有相应正偏移量值的after函数。指定0 偏移量会评估当前列上的表达式。递归调用将返回空值。

> 通过指定第三个参数n 大于1，函数返回的不是一个值，而是一连串n值，每个值对应一个从原始单元格开始向左计数的n表格列。此时，该函数用作任何特殊图表范围函数(第792 页)的参数。

    示例：
    before( sum( Sales ))
    before( sum( Sales ), 2 )
    before( total sum( Sales ))
    rangeavg(before(sum(x),1,3)) //返回当前列左边三列内评估的sum(x) 函数的三个结果的平均值。

## after

> after([ total ] expression [ , offset [,n ]] )

> 返回使用透视表的维度值评估的表达式值，因为维度值显示在透视表的行段内当前列之后的列。除透视表之外的所有图表类型中，此函数均会返回空值。

> **行段的最后一列会返回空值，因为其后没有列。**

> **如果表格是单维度，或者如果表达式先于总计限定符，则当前行段总是等同于整行。**

> 如果透视表有多个水平维度，当前的行片断将只包括值全部维度行当前列相同的列，除了显示字段排序间上一次水平维度的行之外。透视表的水平维度的内部字段排序只需依据从上至下的维度顺序定义。

> 指定大于1 的偏移量可让您移动表达式评估至当前列更靠右的列。负偏移量值实际会促使after函数等同于带有相应正偏移量值的before函数。指定0 偏移量会评估当前列上的表达式。递归调用将返回空值。

> 通过指定第三个参数n 大于1，函数返回的不是一个值，而是一连串n值，每个值对应一个从原始单元格开始向右计数的n表格列。此时，该函数用作任何特殊图表范围函数(第792 页)的参数。

    示例：
    after( sum( Sales ))
    after( sum( Sales ), 2 )
    after( total sum( Sales ))
    rangeavg(after(sum(x),1,3)) //返回当前列右边三列内评估的sum(x) 函数的三个结果的平均值。

## first

> first([ total ] expression [ , offset [,n ]])
>返回使用透视表的维度值评估的表达式值，因为维度值显示在透视表的当前行段的第一列。除透视表之外的所有图表类型中，此函数均会返回空值。

> 如果表格是单维度，或者如果表达式先于总计限定符，则当前行段总是等同于整行。

> 如果透视表有多个水平维度，当前的行片断将只包括值全部维度行当前列相同的列，除了显示字段排序间上一次水平维度的行之外。透视表的水平维度的内部字段排序只需依据从上至下的维度顺序定义。

> 指定大于1 的偏移量可让您移动表达式评估至第一列更靠右的列。负偏移量值实际会促使first函数等同于带有相应正偏移量值的last函数。递归调用将返回空值。

> 通过指定第三个参数n 大于1，函数返回的不是一个值，而是一连串n值，每个值对应当前行段的第一个n列中的一列。此时，该函数用作任何特殊图表范围函数(第792 页)的参数。

    示例：
    first( sum( Sales ))
    first( sum( Sales ), 2 )
    first( total sum( Sales )
    rangeavg(first(sum(x),1,5)) //返回当前行段最左边五列内评估的sum(x) 函数的结果的平均值。

## last

> last([ total ] expression [ , offset [,n ]])

> 返回使用透视表的维度值评估的表达式值，因为维度值显示在透视表的当前行段的最后一列。

> 除透视表之外的所有图表类型中，此函数均会返回空值。

> 如果表格是单维度，或者如果表达式先于总计限定符，则当前行段总是等同于整行。

> 如果透视表有多个水平维度，当前的行片断将只包括值全部维度行当前列相同的列，除了显示字段排序间上一次水平维度的行之外。透视表的水平维度的内部字段排序只需依据从上至下的维度顺序定义。

> 指定大于1 的偏移量可让您移动表达式评估至最后一列更靠左的列。负偏移量值实际会促使last函数等同于带有相应正偏移量值的first函数。递归调用将返回空值。

> 通过指定第三个参数n 大于1，函数返回的不是一个值，而是一连串n值，每个值对应当前行段的最后一个n列中的一列。此时，该函数用作任何特殊图表范围函数(第792 页)的参数。

    示例：
    last( sum( Sales ))
    last( sum( Sales ), 2 )
    last( total sum( Sales )
    rangeavg(last(sum(x),1,5)) //返回当前行段最右边五列内评估的sum(x) 函数的结果的平均值。

## RowNo

> RowNo([total])

> 返回表格，位图图表或图表的垂直表等同物的当前列段中的当前行数。第一行为编号１。

> 如果表格是单维度，或者如果总计限定符用作参数，则当前列段总是等同于整列。

> 如果表格或类似物有多个垂直维度，当前的列片断将只包括值与全部维度列的当前行相同的行，除了显示字段排序间上一次维度的列之外。透视表的内部字段排序只需依据从左至右的维度顺序定义。

> **对于其他图表类型，这可在图表属性：排序对话框中操纵。**

    示例：
    if( RowNo( )=1, 0, sum( Sales ) / above( sum( Sales )))

## ColumnNo

> ColumnNo([total]) //返回透视表的当前行段中的当前列数。第一列是数字1。

> 如果透视表是单维度，或者如果总计限定符用作参数，则当前行段总是等同于整行。

> 如果透视表有多个水平维度，当前的行片断将只包括值全部维度行当前列相同的列，除了显示字段排序间上一次水平维度的行之外。透视表的水平维度的内部字段排序只需依据从上至下的维度顺序定义。

    示例：
    if( ColumnNo( )=1, 0, sum( Sales ) / before( sum( Sales )))

## NoOfRows

> NoOfRows([total])

> 返回表格，位图图表或图表的垂直表等同物的当前列段中的行数。

> 如果图表是单维度，或者如果总计限定符用作参数，则当前列段总是等同于整列。

> 如果表格或类似物有多个垂直维度，当前的列片断将只包括值与全部维度列的当前行相同的行，除了显示字段排序间上一次维度的列之外。透视表的内部字段排序只需依据从左至右的维度顺序定义。

> **对于其他图表类型，这可在图表属性：排序对话框中操纵。**

    示例：
    if( RowNo( )=NoOfRows( ), 0, after( sum( Sales )))

## NoOfColumns

> NoOfColumns([total])

> 返回透视表的当前行段中的列数。

> 如果透视表是单维度，或者如果总计限定符用作参数，则当前行段总是等同于整行。

> 如果透视表拥有多个水平维度，当前行段会仅包括与所有维度行内当前列相同值的列，当按内部字段排序显示最后维度的行除外。透视表的水平维度的内部字段排序只需依据从上至下的维度顺序定义。

    示例：
    if( ColumnNo( )=NoOfColumns( ), 0, after( sum( Sales )))

## fieldvaluecount

> fieldvaluecount(fieldname )

> 可返回表示字段特殊值的数字。字段名必须为字符串( 例如引用的文字) 。

## Column

> Column(ColumnNo)

> 返回垂直表或透视表的列号列中找到的值。

    示例：
    column(1)/column(2)返回商数。
