---
layout: post
title: Centos 修改时区时间
date: 2013-12-19 10:04:19
comments: true
categories: CentOS
---
## 系统信息

    [root@localhost script]# lsb_release -a
    LSB Version:    :core-4.0-ia32:core-4.0-noarch:graphics-4.0-ia32:graphics-4.0-noarch:printing-4.0-ia32:printing-4.0-noarch
    Distributor ID: CentOS
    Description:    CentOS release 5.9 (Final)
    Release:        5.9
    Codename:       Final

## 修改本地时区

    # 查看当前时区,中国+0800区
    [root@localhost script]# date -R
    Sat, 17 Aug 2013 11:56:53 -0400
    
    # 复制相应的时区文件，替换CentOS系统时区文件；或者创建链接文件
    # cp /usr/share/zoneinfo/$主时区/$次时区 /etc/localtime
    # 中国可以使用：cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
    #查看zoneinfo是否存在
    [root@localhost script]# ls /usr/share/zoneinfo/Asia/Shanghai
    /usr/share/zoneinfo/Asia/Shanghai
    
    #查看本地localtime是否存在
    [root@localhost script]# ls /etc/localtime 
    /etc/localtime
    
    #备份本地localtime
    [root@localhost script]# mv /etc/localtime /etc/localtime_bk
    
    #使用上海时间覆盖本地时间
    [root@localhost script]# cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
    
    #再查看本地时区
    [root@localhost script]# date -R
    Sat, 17 Aug 2013 12:10:36 +0800

## 修改本地时间

    # 查看当前系统时间
    [root@localhost script]# date
    Fri Aug 16 23:58:12 EDT 2013
    [root@localhost script]# date "+%m/%d/%y %H:%M:%S"
    08/16/13 23:58:12
    
    # 修改date
    [root@localhost script]# date -s 08/17/13
    Sat Aug 17 00:00:00 EDT 2013
    
    # 修改time
    [root@localhost script]# date -s 11:55:19
    Sat Aug 17 11:55:19 EDT 2013
    
    # 再查看当前系统时间
    [root@localhost script]# date
    Sat Aug 17 11:55:21 EDT 2013
    [root@localhost script]#  date "+%m/%d/%y %H:%M:%S"
    08/17/13 11:55:30
    
    # 使用命令clock -w强制把系统时间写CMOS
    [root@localhost script]# clock -w
    bash: clock: command not found
    [root@localhost script]# whereis clock
    clock: /sbin/clock /usr/share/man/man3p/clock.3p.gz /usr/share/man/man3/clock.3.gz
    [root@localhost script]# /sbin/clock -w

## 脚本自动校正

    #!/bin/bash
    #功能：
    #     自动校正系统时区、日期、时间
    #校正方式一:
    #     通过ssh取得远程主机时区、日期、时间为参照校正本机时区、日期、时间
    #     此方式需要设置shost=登陆用户名@参照主机ip
    #校正方式二:
    #     手工设置要修改参考的标准信息
    #     此方式需要设置sinfo="+0800 09/28/13 16:25:30"
    #说明:
    #     默认使用校正方式一,方式二被注释;
    #     若使用校正方式二，需把校正方式一代码注释
    
    
    #校正方式一
    shost="root@112.112.112.112"
    echo "校正主机${shost},若无ssh设置免密码,则需要输入密码"
    sinfo=$(ssh ${shost} "date +'%z %m/%d/%y %H:%M:%S'")
    #校正方式二
    #sinfo="+0800 09/28/13 16:25:30"
    
    #修改参考标准时区、日期、时间
    infos=(${sinfo})
    szstr=${infos[0]}
    sdstr=${infos[1]}
    ststr=${infos[2]}
    
    #本地时区、日期、时间
    zstr=$(date +%z)
    dstr=$(date +%m/%d/%y)
    tstr=$(date +%H:%M:%S)
    shanghai=/usr/share/zoneinfo/Asia/Shanghai
    loltime=/etc/localtime
    
    echo "****************************"
    echo "校正时区"
    if [ ${zstr} = ${szstr} ];
    then
        echo "本地与校正主机相同时区:${szstr}"
    else
        echo "时区错误:本地时区[${zstr}],校正主机时区[${szstr}]" 
    
        if [ -e ${shanghai} ] && [ -e ${loltime} ];
        then
            /bin/mv ${loltime} ${loltime}.bak
            echo "备份${loltime}=>${loltime}.bak"
            /bin/cp ${shanghai} ${loltime}
            echo "覆盖${shanghai}=>${loltime}" 
        else
            [ -e ${shanghai} ] || echo "${shanghai} 不存在！"
            [ -e ${loltime} ]  || echo "${loltime} 不存在！"
        fi
    fi
    
    echo "****************************"
    echo "校正日期"
    if [ ${dstr} = ${sdstr} ];
    then
        echo "本地与校正主机相同日期:${sdstr}"
    else
        echo "修改日期${dstr}=>${sdstr}"
        /bin/date -s ${sdstr}
        /sbin/clock -w
    fi
    
    echo "****************************"
    echo "校正时间"
    hm=$(echo ${tstr} | cut -c 1-5)
    shm=$(echo ${ststr} | cut -c 1-5)
    if [ ${hm} = ${shm} ];
    then
        echo "本地与校正主机相同时分:"
        echo "本地:${tstr} 校正主机:${ststr}"
    else
        echo "修改时间${tstr}=>${ststr}"
        /bin/date -s ${ststr}
        /sbin/clock -w
    fi

执行校正脚本

    [root@localhost focusbash]# ./chkdate.sh 
    校正主机root@112.112.112.112,若无ssh设置免密码,则需要输入密码
    root@112.112.112.112's password: 
    ****************************
    校正时区
    本地与校正主机相同时区:+0800
    ****************************
    校正日期
    本地与校正主机相同日期:09/28/13
    ****************************
    校正时间
    本地与校正主机相同时分:
    本地:16:30:13 校正主机:16:30:14

## 服务器端检查

服务器端批量检查代理服务器时区、日期、时间与本地误差

    #!/bin/bash
    #功能:
    #    服务器端检查代理服务器时区日期与服务器误差
    
    declare -a mghosts
    mghosts[0]="root@192.168.0.1"
    mghosts[1]="root@192.168.0.2"
    mghosts[2]="root@192.168.0.3"
    mghosts[3]="root@192.168.0.4"
    mghosts[4]="root@192.168.0.5"
    
    #本地时区、日期、时间
    zstr=$(date +%z)
    dstr=$(date +%m/%d/%y)
    tstr=$(date +%H:%M:%S)
    hm=$(echo ${tstr} | cut -c 1-5)
    
    for mghost in ${mghosts[@]}
    do
        echo "------------------------"
        echo "查看代理服务器 ${mghost}"
        sinfo=$(ssh ${mghost} "echo $(date +'%z %m/%d/%y %H:%M:%S')")
        #代理服务器时区、日期、时间
        infos=(${sinfo})
        szstr=${infos[0]}
        sdstr=${infos[1]}
        ststr=${infos[2]}
        shm=$(echo ${ststr} | cut -c 1-5)
       
        if [ ${zstr} = ${szstr} ];
        then
            echo "===时区相同:${zstr}" 
        else
            echo "xxx时区不同:本地${zstr},代理${szstr}" 
        fi
    
        if [ ${dstr} = ${sdstr} ];
        then
            echo "===日期相同:${dstr}" 
        else
            echo "xxx日期不同:本地${dstr},代理${sdstr}" 
        fi
        
        if [ ${hm} = ${shm} ];
        then
            echo "===时分相同:本地${tstr},代理${ststr}" 
        else
            echo "xxx时分不同:本地${tstr},代理${ststr}" 
        fi
    done

执行脚本结果:

    [root@oraclehost sh]# sh chkssh.sh 
    ------------------------
    查看代理服务器 root@192.168.0.1
    ===时区相同:+0800
    ===日期相同:09/28/13
    ===时分相同:本地18:36:16,代理18:36:16
    ------------------------
    查看代理服务器 root@192.168.0.2
    Address 192.168.0.2 maps to mailhok.com, but this does not map back to the address - POSSIBLE BREAK-IN ATTEMPT!
    ===时区相同:+0800
    ===日期相同:09/28/13
    ===时分相同:本地18:36:16,代理18:36:16
    ------------------------
    查看代理服务器 webmail@192.168.0.3
    ===时区相同:+0800
    ===日期相同:09/28/13
    ===时分相同:本地18:36:16,代理18:36:17
    ------------------------
    查看代理服务器 root@192.168.0.4
    ===时区相同:+0800
    ===日期相同:09/28/13
    ===时分相同:本地18:36:16,代理18:36:18
    ------------------------
    查看代理服务器 root@192.168.0.5
    ===时区相同:+0800
    ===日期相同:09/28/13
    ===时分相同:本地18:36:16,代理18:36:19
