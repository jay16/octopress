---
layout: post
title: Linux.x64 Oracle安装
date: 2013-09-21 23:51:11
comments: true
categories: other
---
## 安装JDK

+ 1.赋予可执行权限

    chmod a+x jdk-6u38-ea-bin-b04-linux-amd64-31_oct_2012.bin  

+ 2.直接执行

    ./jdk-6u38-ea-bin-b04-linux-amd64-31_oct_2012.bin 

+ 3.把生成的jdk1.6.0_38 拷贝到/usr/lib/jvm

    mkdir /usr/lib/jvm
    mv jdk1.6.0_38 /usr/lib/jvm/java-7-sun

+ 4.修改环境变量~/.bashrc

    export JAVA_HOME=/usr/lib/jvm/java-7-sun  
    export JRE_HOME=${JAVA_HOME}/jre  
    export CLASSPATH=.:${JAVA_HOME}/lib:${JRE_HOME}/lib  
    export PATH=${JAVA_HOME}/bin:$PATH

+ 5.生效

    [root@localhost ~]# source ~/.bashrc
    [root@localhost ~]# java -version
    java version "1.6.0_38-ea"
    Java(TM) SE Runtime Environment (build 1.6.0_38-ea-b04)
    Java HotSpot(TM) 64-Bit Server VM (build 20.13-b02, mixed mode)

## 安装ORACLE

+ 1.安装依赖软件

    [root@localhost ~]# yum -y install binutils compat-libstdc++-33 compat-libstdc++-33.i686 elfutils-libelf elfutils-libelf-devel gcc gcc-c++ glibc glibc.i686 glibc-common glibc-devel glibc-devel.i686 glibc-headers ksh libaio libaio.i686 libaio-devel libaio-devel.i686 libgcc libgcc.i686 libstdc++ libstdc++.i686 libstdc++-devel make sysstat

+ 2.添加oracle用户

    添加用户Oracle
    [root@localhost ~]# groupadd oinstall
    [root@localhost ~]# groupadd dba
    [root@localhost ~]# useradd -d /opt/oracle -g oinstall -G dba -s /bin/bash oracle
    [root@localhost ~]# passwd oracle
    Changing password for user oracle.
    New password: 
    passwd: all authentication tokens updated successfully.

添加oracle环境变量

    [root@oraclehost ~]# cat /opt/oracle/.bashrc 
    # User specific environment and startup programs
    ORACLE_SID=focusmail;export ORACLE_SID
    ORACLE_UNQNAME=ora11g;export ORACLE_UNQNAME
    
    ORACLE_BASE=/mnt/database/oracle;export ORACLE_BASE
    ORACLE_HOME=$ORACLE_BASE/product/11.2.0/db_1;export ORACLE_HOME
    
    PATH=$PATH:$ORACLE_HOME/bin:$HOME/bin;export PATH

+ 3.修改用户资源限制

    [root@localhost ~]# grep oracle /etc/security/limits.conf 
    oracle    soft  nproc  2047
    oracle    hard  nproc  16384
    oracle    soft  nofile  1024
    oracle    hard  nofile  65536
+ 4.修改内核参数 `/etc/sysctl.conf`

    # /etc/sysctl.conf尾部追加
    
    # oracle sysctl parameters -------------------
    
    # max number of file descriptors
    fs.file-max = 6553600
    
    # maximum size in bytes of a single shared memory segment 
    # that a Linux process can allocate in its virtual address space.
    # with 64GB of RAM, we set the max segment size at 60GB, thus the 
    # SGA cannot be larger than 60GB for one database instance
    kernel.shmmax = 64424509440
    
    # total amount of shared memory pages that can be used system wide.
    # Hence, SHMALL should always be at least ceil(shmmax/PAGE_SIZE). 
    # with 60GB of RAM and a page size at 4KB
    kernel.shmall = 15728640
    
    # system wide maximum number of shared memory segments
    kernel.shmmni = 4096
    
    # control the number of semaphores on the system
    # kernel.sem = semmsl semmns semopm semmni
    #
    # SEMMSL kernel parameter is used to control the maximum number 
    # of semaphores per semaphore set.
    # SEMMSL setting should be 10 plus the largest PROCESSES 
    # parameter of any Oracle database on the system, here 2048
    #
    # SEMMNS parameter is the maximum number of semaphores that
    # can be allocated (SEMMSL * SEMMNI) system wide
    #
    # SEMOPM kernel parameter is used to control the number of
    # semaphore operations that can be performed per semop system call
    #
    # SEMMNI kernel parameter is used to control the maximum number
    # of semaphore sets on the entire Linux system. 
    kernel.sem = 2048 262144 2048 128
    
    # usuable port range
    net.ipv4.ip_local_port_range = 9000 65500
    
    # default OS receive buffer size in bytes 
    net.core.rmem_default = 262144
    
    # max OS receive buffer size in bytes 
    net.core.rmem_max = 4194304
    
    # default OS transmit buffer size in bytes 
    net.core.wmem_default = 262144
    
    # max OS transmit buffer size in bytes 
    net.core.wmem_max = 1048576

使用上述设置生效:

    [root@oraclehost response]# sysctl -p
    net.ipv4.ip_forward = 0
    net.ipv4.conf.all.rp_filter = 0
    net.ipv4.conf.default.rp_filter = 0
    net.ipv4.conf.default.accept_source_route = 0
    kernel.sysrq = 0
    kernel.core_uses_pid = 1
    net.ipv4.tcp_syncookies = 1
    error: "net.bridge.bridge-nf-call-ip6tables" is an unknown key
    error: "net.bridge.bridge-nf-call-iptables" is an unknown key
    error: "net.bridge.bridge-nf-call-arptables" is an unknown key
    kernel.msgmnb = 65536
    kernel.msgmax = 65536
    kernel.shmmax = 68719476736
    kernel.shmall = 4294967296
    net.ipv6.conf.all.disable_ipv6 = 1
    net.ipv6.conf.default.disable_ipv6 = 1
    net.ipv4.neigh.default.gc_stale_time = 120
    net.ipv4.conf.default.arp_announce = 2
    net.ipv4.conf.all.arp_announce = 2
    net.ipv4.conf.lo.arp_announce = 2
    fs.file-max = 6553600
    kernel.shmmax = 64424509440
    kernel.shmall = 15728640
    kernel.shmmni = 4096
    kernel.sem = 2048 262144 2048 128
    net.ipv4.ip_local_port_range = 9000 65500
    net.core.rmem_default = 262144
    net.core.rmem_max = 4194304
    net.core.wmem_default = 262144
    net.core.wmem_max = 1048576

+ 5.用户登陆限制

    [root@localhost oracle]# grep limit /etc/pam.d/login 
    session required /lib64/security/pam_limits.so
+ 6.添加主机名

    [root@localhost oracle]# grep oracle /etc/hosts
    127.0.0.1 localhost oraclehost
+ 7.创建数据库文件夹

    [root@oraclehost ~]# mkdir -p /mnt/database/oracle/
    [root@oraclehost ~]# chmod -R 777 /mnt/database/
    [root@oraclehost ~]# chown -R oracle:oinstall /mnt/database/

+ 8.修改Response 文件

    [root@oraclehost oracle]# unzip linux.x64_11gR2_database_1of2.zip
    [root@oraclehost oracle]# unzip linux.x64_11gR2_database_2of2.zip 
    [root@oraclehost ~]# vi /mnt/tools/oracle/database/response/db_install.rsp 
    oracle.install.option=INSTALL_DB_SWONLY
    ORACLE_HOSTNAME=oraclehost
    UNIX_GROUP_NAME=oinstall
    INVENTORY_LOCATION=/mnt/database/oracle/inventory
    SELECTED_LANGUAGES=en,zh_CN
    ORACLE_HOME=/mnt/database/oracle/product/11.2.0/db_1
    ORACLE_BASE=/mnt/database/oracle
    oracle.install.db.InstallEdition=EE
    oracle.install.db.DBA_GROUP=oinstall
    oracle.install.db.OPER_GROUP=oinstall
    oracle.install.db.config.starterdb.type=GENERAL_PURPOSE
    oracle.install.db.config.starterdb.globalDBName=ora11g
    oracle.install.db.config.starterdb.SID=focusmail
    oracle.install.db.config.starterdb.memoryLimit=512
    oracle.install.db.config.starterdb.password.ALL=passwd
    oracle.install.db.config.starterdb.storageType=FILE_SYSTEM_STORAGE
    oracle.install.db.config.starterdb.fileSystemStorage.dataLocation=/mnt/database/oradata/ora11g
    DECLINE_SECURITY_UPDATES=true

+ 9.安装oracle

    [oracle@oraclehost database]$ ./runInstaller -silent -ignorePrereq -force -noconfig -responseFile /mnt/tools/oracle/database/response/db_install.rsp 
    Starting Oracle Universal Installer...
    
    Checking Temp space: must be greater than 120 MB.   Actual 6592 MB    Passed
    Checking swap space: must be greater than 150 MB.   Actual 3837 MB    Passed
    Preparing to launch Oracle Universal Installer from /tmp/OraInstall2013-09-21_01-51-31PM. Please wait ...[oracle@oraclehost database]$ [WARNING] [INS-32055] The 
    
    Central Inventory is located in the Oracle base.
       CAUSE: The Central Inventory is located in the Oracle base.
       ACTION: Oracle recommends placing this Central Inventory in a location outside the Oracle base directory.
    [WARNING] [INS-32055] The Central Inventory is located in the Oracle base.
       CAUSE: The Central Inventory is located in the Oracle base.
       ACTION: Oracle recommends placing this Central Inventory in a location outside the Oracle base directory.
    You can find the log of this install session at:
     /mnt/database/oracle/inventory/logs/installActions2013-09-21_01-51-31PM.log
    The following configuration scripts need to be executed as the "root" user. 
     #!/bin/sh 
     #Root scripts to run
    
    /mnt/database/oracle/inventory/orainstRoot.sh
    /mnt/database/oracle/product/11.2.0/db_1/root.sh
    To execute the configuration scripts:
             1. Open a terminal window 
             2. Log in as "root" 
             3. Run the scripts 
             4. Return to this window and hit "Enter" key to continue 
    
    Successfully Setup Software.
    
    [oracle@oraclehost database]$ exit
    exit
    [root@oraclehost swap]# /mnt/database/oracle/inventory/orainstRoot.sh
    Changing permissions of /mnt/database/oracle/inventory.
    Adding read,write permissions for group.
    Removing read,write,execute permissions for world.
    
    Changing groupname of /mnt/database/oracle/inventory to oinstall.
    The execution of the script is complete.
    [root@oraclehost swap]# /mnt/database/oracle/product/11.2.0/db_1/root.sh
    Check /mnt/database/oracle/product/11.2.0/db_1/install/root_oraclehost_2013-09-21_14-02-12.log for the output of root script
    [root@oraclehost swap]# 

## 创建数据库实例

+ 1.修改创建数据库实例参数

    [root@oraclehost ~]# vi /mnt/tools/oracle/database/response/dbca.rsp 
     RESPONSEFILE_VERSION = "11.2.0"  //不能更改
     OPERATION_TYPE = "createDatabase"
     GDBNAME = "focusmail.us.oracle.com"   //不允许_
     SID = "focusmail"    //对应的实例名字,实例名只允许使用字母
     TEMPLATENAME = "General_Purpose.dbc" //建库用的模板文件
     SYSPASSWORD = "Passwd"               //SYS管理员密码
     SYSTEMPASSWORD = "Passwd"            //SYSTEM管理员密码
     CHARACTERSET = "ZHS16GBK"            //字符集
     TOTALMEMORY = "5120"                 //oracle内存5120MB

+ 2.创建数据库实例

    [root@oraclehost response]# su oracle
    [oracle@oraclehost response]$ echo $ORACLE_BASE
    /mnt/database/oracle
    [oracle@oraclehost response]$ /mnt/database/oracle/product/11.2.0/db_1/bin/dbca -silent -responseFile /mnt/tools/oracle/database/response/dbca.rsp 
    Copying database files
    1% complete
    3% complete
    11% complete
    18% complete
    26% complete
    37% complete
    Creating and starting Oracle instance
    40% complete
    45% complete
    50% complete
    55% complete
    56% complete
    60% complete
    62% complete
    Completing Database Creation
    66% complete
    70% complete
    73% complete
    85% complete
    96% complete
    100% complete
    Look at the log file "/mnt/database/oracle/cfgtoollogs/dbca/focusmail/focusmai.log" for further details.

+ 3.修改数据库为归档模式(归档模式才能热备份，增量备份)

    [oracle@oraclehost ~]$ echo $ORACLE_SID
    focusmail
    [oracle@oraclehost ~]$ sqlplus / as sysdba
    SQL> shutdown immediate;
    SQL> startup mount;
    SQL> alter database archivelog;
    SQL> alter database flashback on;
    SQL> alter database open;
    SQL> execute utl_recomp.recomp_serial();
    SQL> alter system archive log current;
    SQL> exit

+ 4.修改oracle启动配置文件

    [oracle@oraclehost ~]$ vi /etc/oratab 
    focusmail:/mnt/database/oracle/product/11.2.0/db_1:Y
    [oracle@oraclehost response]$ dbstart /mnt/database/oracle/product/11.2.0/db_1
    Processing Database instance "focusmail": log file /mnt/database/oracle/product/11.2.0/db_1/startup.log
    [oracle@oraclehost response]$ lsnrctl status
    
    LSNRCTL for Linux: Version 11.2.0.1.0 - Production on 21-SEP-2013 14:35:35
    
    Copyright (c) 1991, 2009, Oracle.  All rights reserved.
    
    Connecting to (ADDRESS=(PROTOCOL=tcp)(HOST=)(PORT=1521))
    STATUS of the LISTENER
    ------------------------
    Alias                     LISTENER
    Version                   TNSLSNR for Linux: Version 11.2.0.1.0 - Production
    Start Date                21-SEP-2013 14:35:23
    Uptime                    0 days 0 hr. 0 min. 12 sec
    Trace Level               off
    Security                  ON: Local OS Authentication
    SNMP                      OFF
    Listener Log File         /mnt/database/oracle/diag/tnslsnr/oraclehost/listener/alert/log.xml
    Listening Endpoints Summary...
      (DESCRIPTION=(ADDRESS=(PROTOCOL=tcp)(HOST=localhost)(PORT=1521)))
    Services Summary...
    Service "focusmail.us.oracle.com" has 1 instance(s).
      Instance "focusmail", status READY, has 1 handler(s) for this service...
    Service "focusmailXDB.us.oracle.com" has 1 instance(s).
      Instance "focusmail", status READY, has 1 handler(s) for this service...
    The command completed successfully

+ 5.建立表空是及用户

    [oracle@oraclehost ~]$  mkdir -p /mnt/database/oradata/mail_dev
    [oracle@oraclehost ~]$ echo $ORACLE_SID
    focusmail
    [oracle@oraclehost ~]$ sqlplus / as sysdba;
    SQL> startup
    SQL> create temporary tablespace user_temp tempfile '/mnt/database/oradata/mail_dev/user_temp.dbf' size 50m autoextend on next 50m maxsize 20480m extent management local;
    //创建数据表空间
    SQL> create tablespace user_data logging datafile   '/mnt/database/oradata/mail_dev/user_data.dbf' size 50m autoextend on next 50m maxsize 20480m extent management local;  
    //创建用户并指定表空间
    SQL> create user IntFocus identified by Focus_01 default tablespace user_data temporary tablespace user_temp;  
    SQL> grant connect,resource to IntFocus;
    SQL> create table STUDENT(ID int, NAME varchar(20));
    SQL> insert into STUDENT values(1, 'intfocus');
    SQL> insert into STUDENT values(2, '中文');
    SQL> select * from student;
    SQL> exit

## tnsname.ora

      FocusMail =
       (DESCRIPTION =
         (ADDRESS = (PROTOCOL = TCP)(HOST = 192.0.0.1)(PORT = 1521))
         (CONNECT_DATA =
           (SERVER = DEDICATED)
           (SERVICE_NAME = focusmail.us.oracle.com)
         )
       )

## shell操作oracle

    [root@oraclehost oracle]# cat dbora 
    #!/bin/sh -e
    
    # chkconfig: 3 56 10
    # description: Oracle 10G custom start/stop script
    
    DAEMON=oracle
    ORACLE_HOME=/mnt/database/oracle/product/11.2.0/db_1
    ORACLE_OWNER=oracle
    
    restart() {
        stop
        start
    }
    
    case $1 in
        'start')
            su - ${ORACLE_OWNER} -c "${ORACLE_HOME}/bin/lsnrctl start"
            su - ${ORACLE_OWNER} -c "${ORACLE_HOME}/bin/dbstart"
            su - ${ORACLE_OWNER} -c "${ORACLE_HOME}/bin/emctl start dbconsole"
            su - ${ORACLE_OWNER} -c "${ORACLE_HOME}/bin/isqlplusctl start"
        ;;
        'stop')
            su - ${ORACLE_OWNER} -c "${ORACLE_HOME}/bin/isqlplusctl stop"
            su - ${ORACLE_OWNER} -c "${ORACLE_HOME}/bin/emctl stop dbconsole"
            su - ${ORACLE_OWNER} -c "${ORACLE_HOME}/bin/dbshut"
            su - ${ORACLE_OWNER} -c "${ORACLE_HOME}/bin/lsnrctl stop"
        ;;
        restart)
            restart
        ;;
        *)
            echo "Usage: $0 {start|stop}"
            exit
        ;;
    esac
    
    exit $?

## 转载

1. [CentOS-6 64位安装oracle 11g](http://www.centos.bz/2012/04/centos-6-64-install-oracle-11g/)
2. [Installing Oracle on Centos 6 64 bits](http://wiki.linuxwall.info/doku.php/en:ressources:dossiers:database:oracle10g_centos55)
