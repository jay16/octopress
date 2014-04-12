---
layout: post
title: Linux shell 学习
date: 2013-09-19 04:49:13
comments: true
categories: [error,bash,bi,linux]
---
## 默认变量

| 变量 | 意义 |
|------|------|
| &#38;0 | 脚本文件或函数自身名称 |
| &#38;1...&#38;n | 第一个参数...第n个参数 |
| &#38;# | 参数个数 |
| &#38;@ | 参数数组 |
| &#38;* | 参数数组 |


## 调试方法

### 调试选项

Shell提供了一些用于调试脚本的选项，如下所示：

| 参数 | 用途 |
|------|-----|
| -n | 读一遍脚本中的命令但不执行，用于检查脚本中的语法错误
| -v | 一边执行脚本，一边将执行过的脚本命令打印到标准错误输出
| -x | 提供跟踪执行信息，将执行的每一条命令和结果依次打印出来

### 使用方法

使用这些选项有三种方法：

+ 1.是在命令行提供参数

    $ sh -x ./script.sh

+ 2.是在脚本开头提供参数

    #! /bin/sh -x

+ 3.种方法是在脚本中用set命令启用或禁用参数

    #! /bin/sh
    if [ -z "$1" ]; then
      set -x
      echo "ERROR: Insufficient Args."
      exit 1
      set +x
    fi

`set -x`和`set +x`分别表示启用和禁用`-x`参数，这样可以只对脚本中的某一段进行跟踪调试。

## 内建命令

### type

| 参数| 意义 |
|-----|------|
| 空 |type 会显示出 name 是外部命令还是 bash 内建命令 |
| -t | type 会将 name 以底下这些字眼显示出他的意义：|
|    |  file    ：表示为外部命令；|
|    | alias   ：表示该命令为命令别名所配置的名称；|
|     | builtin ：表示该命令为 bash 内建的命令功能；|
|-p | 如果后面接的 name 为外部命令时，才会显示完整文件名；|
| -a  | 会由 PATH 变量定义的路径中，将所有含 name 的命令都列出来，包含 alias|

    [root@localhost]# type ls
    ls is aliased to `ls --color=tty' <==未加任何参数，列出 ls 的最主要使用情况
    
    [root@localhost]# type -t ls
    alias                             <==仅列出 ls 运行时的依据
    
    [root@localhost]# type -a ls
    ls is aliased to `ls --color=tty' <==最先使用 aliase
    ls is /bin/ls                     <==还有找到外部命令在 /bin/ls
    
    [root@localhost]# type cd
    cd is a function                  <==cd 是 shell 函数(对内建命令cd加了层壳)
    cd ()                             <==cd函数的定义
    { 
        if builtin cd "$@"; then
            [[ -n "${rvm_current_rvmrc:-}" && "$*" == "." ]] && rvm_current_rvmrc="" || true;
            __rvm_cd_functions_set;
            return 0;
        else
            return $?;
        fi
    }
    
    [root@localhost]# type grep
    grep is hashed (/bin/grep)       <==grep命令
    
    [root@localhost]# type reboot
    reboot is /sbin/reboot           <==reboot命令代码位置
    
    [root@localhost]# type -a declare
    declare is a shell builtin       <==declare是内建命令
透过`type`这个命令我们可以知道每个命令是否为bash的内建命令。 此外，由于利用`type`搜寻后面的名称时，如果后面接的名称并不能以运行档的状态被找到， 那么该名称是不会被显示出来的。也就是说，`type`主要在找出『运行档』而不是一般文件档名！ 所以，这个 type 也可以用来作为类似 which 命令的用途！


## 变量

### declare

> 功能说明：声明 shell 变量。

> 语　法：declare [+/-][afrix]
 
> 补充说明：declare为shell指令，

> 在第一种语法中可用来声明变量并设置变量的属性([rix]即为变量的属性），

> 在第二种语法中可用来显示shell函数。

> 若不加上任何参数，则会显示全部的shell变量与函数(与执行set指令的效果相同)。
 

| 参数 | 意义 |
|------|------|
| +/- | `-`可用来指定变量的属性，`+`则是取消变量所设的属性。|
| -a　| 定义为数组`array` | 
| -f  |　定义为函数function |
| -i　| 定义为整数integer |
| -r | 定义为只读 |
| -x |　定义为通过环境输出变量|

## 比较

条件结合，使用`&&`，`||`，以及`!`三种方式，表示“和”，“或”，与”非“，格式如下：

    if statement1 && statement2
    if statement1 || statement2
    if !statement1 

`exit status`不是判断的唯一值，可以使用`[...]`和`[[...]]`。

### 字符串比较

字符串比较是放置在`[...]`中，有以下的几种：

1. `str1 = str2`，字符串1匹配字符串2
2. `str1 != str2`，字符串1不匹配字符串2
3. `str1 > str2`，字符串1大于字符串2
4. `str1 < str2`，字符串1小于字符串2
5. `-n str`，字符串不为null，长度大于零
6. `-z str`，字符串为null，长度为零

### 整数比较

**`>`或者`<`或者`=`是用于字符串的比较**，如果用于整数比较，使用：

1. `-lt`，小于
2. `-le`，小于等于
3. `-eq`，等于
4. `-ge`，大于等于
5. `-gt`，大于
6. `-ne`，不等于

### 文件属性比较

文件属性比较是另一个常用的条件判断类型。

1. `-a file` ：file 存在
2. `-d file` ：file存在并是一个目录
3. `-e file` ：file 存在，同- a
4. `-f file` ：file 存在并且是一个常规的文件（不是目录或者其他特殊类型文件）
5. `-r file` ：有读的权限
6. `-s file` ：文件存在且不为空
7. `-w file` ：有写的权限
8. `-x file` ：有执行的权限，或者对于目录有search的权限
9. `-N file` ：在上次读取后，文件有改动
10. `-O file` ：own所属的文件
11. `-G file` ：group所属的文件
12. `file1 -nt file2` ：file1 比 file2 更新，以最后更新时间为准
13. `file1 -ot file2` ：file1 比 file2 更旧，以最后更新时间为准
