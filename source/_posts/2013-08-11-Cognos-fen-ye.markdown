---
layout: post
title: Cognos分页
date: 2013-08-11 16:08:39
comments: true
categories: report
---
  目前开发报表中cognos(10.1.1)分页主要针对列表,分两种情况:

  1.报表中仅有一个列表,列表控件的选项设置:
  List[Properities] => Data => Rows per Page => 设置页面显示行数,行数大于此数则分页

  2.报表中不止一个列表,上述设置不会对整体页面分页不起作用,应该设置:
  List[Properities] => General => Pagination => 选项设置:
    Repeat every page                          [勾选]
    Allow contents to break across pages       [不勾]
    All horizontal pagination                  [不勾]
  这样设置后多个列表都会在同一页面展开,而不会分页.
