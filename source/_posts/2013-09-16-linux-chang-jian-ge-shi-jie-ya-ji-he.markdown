---
layout: post
title: linux常见格式解压集合
date: 2013-09-16 12:18:22
comments: true
categories: Linux
---
## 常见格式

注：tar是打包，不是压缩！

### .tar.gz & .tgz

 
| tar.gz & tgz |  命令 |
|-----|-----|
| 解压 | tar zxvf FileName.tar.gz 
| 压缩 | tar zcvf FileName.tar.gz DirName 

### .tar.bz

| .tar.bz |  命令 |
|-----|-----|
| 解压| tar jxvf FileName.tar.bz 

###.gz

 
| gz |  命令 |
|-----|-----|
| 解压1 | gunzip FileName.gz 
| 解压2 | gzip -d FileName.gz 
| 压缩 | gzip FileName 


### .tar
 
|tar| 命令|
|-----|-----|
| 解包 | tar xvf FileName.tar |
| 打包 | tar cvf FileName.tar DirName |



###.zip

| zip |  命令 |
|-----|-----|
| 解压 | unzip FileName.zip
| 压缩 | zip FileName.zip DirName

###.rar

| rar |  命令 |
|-----|-----|
| 解压 | rar x FileName.rar
| 压缩 | rar a FileName.rar DirName

注: (若CentOS系统中未安装unrar命令)

    #第一步
    #编辑yum配置档,有则添加，无则新建
    vi /etc/yum.repos.d/dag.repo
    
    #第二步
    #添加内容如下:
    
    [dag]
    
    name=Dag RPM Repository for Red Hat Enterprise Linux
    
    baseurl=http://apt.sw.be/redhat/el$releasever/en/$basearch/dag
    
    gpgcheck=1
    
    enabled=1
    
    gpgkey=http://dag.wieers.com/rpm/packages/RPM-GPG-KEY.dag.txt
    
    #第三步
    #执行yum安装命令
    yum install unrar
    
    #第四步
    #解压
    unrar x myrar.rar

###.lha

| lha |  命令 |
|-----|-----|
|解压 | lha -e FileName.lha
| 压缩 | lha -a FileName.lha FileName


### .rpm


| rpm |  命令 |
|-----|-----|
| 解包 | rpm2cpio FileName.rpm &#124; cpio -div



### .bz2

| .bz2 |  命令 |
|-----|-----|
| 解压1 | bzip2 -d FileName.bz2
| 解压2 | bunzip2 FileName.bz2
| 压缩 |  bzip2 -z FileName

### .tar.bz2

| tar.bz2 |  命令 |
|-----|-----|
| 解压 | tar jxvf FileName.tar.bz2
| 压缩 | tar jcvf FileName.tar.bz2 DirName


###.bz

| bz |  命令 |
|-----|-----|
| 解压1 | bzip2 -d FileName.bz
| 解压2 | bunzip2 FileName.bz


### .Z

| Z |  命令 |
|-----|-----|
| 解压 | uncompress FileName.Z
| 压缩 | compress FileName

###.tar.Z

| tar.Z |  命令 |
|-----|-----|
| 解压 | tar Zxvf FileName.tar.Z
| 压缩 | tar Zcvf FileName.tar.Z DirName

## 转载

[linux下解压命令大全 ](http://www.cnblogs.com/eoiioe/archive/2008/09/20/1294681.html)

