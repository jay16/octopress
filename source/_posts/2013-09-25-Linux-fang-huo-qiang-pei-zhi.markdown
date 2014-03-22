---
layout: post
title: Linux 防火墙配置
date: 2013-09-25 22:38:17
comments: true
categories: linux
---
## 认识防火墙

网络安全除了随时注意套件的漏洞，以及网络上的安全通报之外，你最好能够依据自己的环境来订定防火墙机制， 这样对于你的网络环境，会比较有保障一点！**防火墙**就是在**管制进入到我们网域内的主机(或者可以说是网域)的数据封包的一种机制**， 例如`iptables`就是一种防火墙机制了。更广义的来说，**只要能够分析与过滤进出我们管理之网域的封包数据，就可以称为防火墙**。


防火墙又可以分为**硬件防火墙**与本机的**软件防火墙**。硬件防火墙是由**厂商设计好的主机硬件**。软件防火墙本身就是在**保护系统网络安全的一套软件(或称为机制)**，例如 `iptables`与 `TCP Wrappers` 都可以称为软件防火墙。

## 为何需要防火墙

基本上，如果你的系统具有下列条件,那么你的系统实际上已经颇为安全了！要不要架设防火墙？那就见仁见智！

+ (1)已经关闭不需要而且危险的服务； 
+ (2)已经将整个系统的所有套件都保持在最新的状态； 
+ (3)权限设定妥当且定时进行备份工作； 
+ (4)已经教育用户具有良好的网络、系统操作习惯。 

不过，毕竟网络的世界是很复杂的，而 Linux 主机也不是一个简单的东西， 说不定哪一天你在进行某个软件的测试时，主机突然间就启动了一个网络服务， 如果你没有管制该服务的使用范围，那么该服务就等于对所有 Internet 开放， 那就麻烦了！因为该服务可能可以允许任何人登入你的系统，那不是挺危险？

防火墙能作什么呢？防火墙最大的功能就是帮助你**『限制某些服务的存取来源』**！ 防火墙最主要功能:

+ (1)你可以限制文件传输服务 (FTP) 只在子域内的主机才能够使用，而不对整个 Internet 开放； 
+ (2)你可以限制整部 Linux 主机仅可以接受客户端的 WWW 要求，其他的服务都关闭； 
+ (3)你还可以限制整部主机仅能主动对外联机，对我们主机主动联机的封包状态 (TCP 封包的 SYN flag) 就予以抵挡等等。



防火墙最重要的任务就是在规划出：

+ (1)切割被信任(如子域)与不被信任(如 Internet)的网段；
+ (2)划分出可提供 Internet 的服务与必须受保护的服务；
+ (3)分析出可接受与不可接受的封包状态； 

## Linux 系统上防火墙的主要类别

除了以软件及硬件作为防火墙的分类之外，我们也可以使用**防火墙对于数据封包的取得方式来进行分类**。主要可以分为两大类， 分别是**代理服务器(Proxy)** 以及 **IP Filter**。在代理服务器方面，代理服务器仅是`代理 Client 端`去向 `Internet` 要求数据，所以 Proxy 其实已经将可代理的协议限制的很少很少，并且由于内部与外部计算机的并不能直接互通， 所以可以达到良好的保护效果；另一种则是上面提到的`IP fileter`啦！**利用封包过滤的方式来达到防火墙的目的**！

1. IP filter (封包过滤机制)

  直接使用进入本机的 TCP/IP 上面的封包协议来进行过滤分析，例如利用 TCP/IP 封包表头的 IP 来源、 Port number 等数据进行过滤，以判断该封包是否能够进入本机取得本机资源。由于这种方式可以直接分析最底层的封包表头数据， 所以包括硬件地址(MAC), 软件地址 (IP), TCP, UDP, ICMP 等封包的信息都可以进行过滤分析的功能， 因此用途非常的广泛。

  在 Linux 上面我们使用核心内建的 iptables 软件来作为防火墙封包过滤的机制， 由于 iptables 是核心内建的功能，因此他的效率非常的高！非常适合于一般小型环境的设定呢！ 他利用一些封包过滤的规则设定，来定义出什么数据可以接收，什么数据需要剔除，以达到保护主机的目的喔！

2. Proxy (代理服务器)

	其实代理服务器是一种网络服务 (service, daemon)，他可以『代理』用户的需求， 而代为前往服务器取得相关的资料。

	当 Client 端想要前往 Internet 取得 WWW 的数据时，他取得数据的流程是这样的：

    1. 他会向 proxy server 要求数据，请 proxy 帮忙处理；
    2. Proxy 可以分析使用者的 IP 来源是否合法？使用者想要去的 WWW 服务器是否合法？ 如果这个 client 的要求都合法的话，那么 Proxy 就会主动的帮忙 client 前往 WWW 服务器取得数据；
    3. Internet 所回传的数据是传给 Proxy server 的喔，所以 WWW 服务器上面看到的是 Proxy Server 的 IP 啰；
    4. 最后 Proxy 将 client 的要求传回给 client。 

	这样了解了吗？没错， client 并没有直接连上 Internet ，所以在实线部分(步骤 1, 4)只要 Proxy 与 Client 可以联机就可以了！此时 client 甚至不需要拥有 public IP 哩！而当有人想要攻击 client 端的主机时， 除非他能够攻破 Proxy server ，否则是无法与 client 联机！

	另外，一般 proxy 主机通常仅开放`port 80, 21, 20`等`WWW`与`FTP`的埠口而已， 而且通常 Proxy 就架设在 Router 上面，因此可以完整的掌控局域网络内的对外联机！ 让你的 LAN 变的更安全啊！

## Linux 的封包过滤机制：iptables

Linux 的防火墙为什么功能这么好？这是因为他本身就是由 Linux kernel 所提供， 由于直接经过核心来处理，因此效能非常好！不过，不同核心版本所使用的防火墙软件是不一样的！ 因为核心支持的防火墙是逐渐演进来的嘛！

+ Version 2.0：使用 ipfwadm 这个防火墙机制；
+ Version 2.2：使用的是 ipchains 这个防火墙机制；
+ Version 2.4 与 2.6 ：主要是使用 iptables 这个防火墙机制，不过在某些早期的 Version 2.4 版本的 distributions 当中，亦同时支持 ipchains (编译成为模块)，好让用户仍然可以使用来自 2.2 版的 ipchains 的防火墙规划。不过，不建议在 2.4 以上的核心版本使用 ipchains.

** 『防火墙规则』 ** 即iptables 是利用封包过滤的机制，『根据封包的分析资料 "比对" 你预先定义的规则内容， 若封包数据与规则内容相同则进行动作，否则就继续下一条规则的比对！』 重点在那个『比对与分析顺序』，再强调一下『规则是有顺序的』。

实例:

假设您的 Linux 主机提供了 WWW 的服务，那么自然就要针对 port 80 来启用通过的封包规则，但是您发现 IP 来源为 192.168.100.100 老是恶意的尝试入侵您的系统，所以您想要将该 IP 拒绝往来，最后，所有的非 WWW 的封包都给他丢弃，就这三个规则来说，您要如何设定防火墙检验顺序呢？

    Rule 1 先抵挡 192.168.100.100 ；
    Rule 2 再让要求 WWW 服务的封包通过；
    Rule 3 将所有的封包丢弃。 

这样的排列顺序就能符合您的需求，不过，万一您的顺序排错了，变成：

    Rule 1 先让要求 WWW 服务的封包通过；
    Rule 2 再抵挡 192.168.100.100 ；
    Rule 3 将所有的封包丢弃。 

此时，那个 192.168.100.100 『可以使用您的 WWW 服务』！因为只要他对您的主机送出 WWW 要求封包，就可以使用您的 WWW 主机功能了，**因为您的规则顺序定义第一条就会让他通过， 而不去考虑第二条规则！**这样可以理解规则顺序的意义了吗！现在再来想一想，如果 Rule 1 变成了『将所有的封包丢弃』，Rule 2 才设定『WWW 服务封包通过』，请问，我的 client 可以使用我的 WWW 服务吗？呵呵！答案是『否～』想通了吗？

## iptables 的表格与链 (chain)

什么是链呢？这得由 iptables 的名称说起。为什么称为 ip"tables" 呢？ 因为这个防火墙软件里面有多个表格 (table) ，每个表格都定义出自己的默认政策与规则， 且每个表格都用途都不相同。

而预设的情况下,Linux 的 iptables 至少就有三个表格，包括**管理本机进出的 `filter`** 、**管理后端主机 (防火墙内部的其他计算机) 的`nat`**、 **管理特殊旗标使用的`mangle`** (较少使用) 。更有甚者，我们还可以自定义额外的链呢！每个表格与其中链的用途分别是这样的：

1. filter：主要跟 Linux 本机有关，这个是预设的 table 喔！

	+ INPUT：主要与封包想要进入我们 Linux 本机有关；
    + OUTPUT：主要与我们 Linux 本机所要送出的封包有关；
    + FORWARD：这个咚咚与 Linux 本机比较没有关系，他可以封包『转递』到后端的计算机中，与 nat 这个 table 相关性很高。

2. nat：这个表格主要在用作来源与目的之 IP 或 port 的转换， 与 Linux 本机较无关，主要与 Linux 主机后的局域网络内的计算机较有相关。

	+ PREROUTING：在进行路由判断之前所要进行的规则(DNAT/REDIRECT)
    + POSTROUTING：在进行路由判断之后所要进行的规则(SNAT/MASQUERADE)
    + OUTPUT：与发送出去的封包有关

3. mangle：这个表格主要是与特殊的封包的路由旗标有关，由于这个表格与特殊旗标相关性较高,较少使用 mangle 这个表格。 


事实上与本机最有关的其实是** `filter`这个表格内的`INPUT`与`OUTPUT`这两条链**，如果你的 iptables 只是用来防备 Linux 主机本身的话，那 nat 的规则根本就不需要理他，直接设定为开放即可。

## 本机的 iptables 语法

+ 规则的清除与观察

    [root@linux ~]# iptables [-t tables] [-L] [-nv]
    参数：
    -t ：后面接 table ，例如 nat 或 filter ，若省略此项目，则使用默认的 filter
    -L ：列出目前的 table 的规则
    -n ：不进行 IP 与 HOSTNAME 的反查，显示讯息的速度会快很多！
    -v ：列出更多的信息，包括通过该规则的封包总位数、相关的网络接口等
    
    范例：列出 filter table 三条链的规则
    [root@linux ~]# iptables -L -n
    Chain FORWARD (policy ACCEPT)
    target     prot opt source               destination
    
    Chain INPUT (policy ACCEPT)
    target     prot opt source               destination
    
    Chain OUTPUT (policy ACCEPT)
    target     prot opt source               destination
    
    范例：列出更多的信息
    [root@linux ~]# iptables -L -nv
    Chain INPUT (policy ACCEPT 5748 packets, 746K bytes)
     pkts bytes target     prot opt in     out     source               destination

仔细看到上面表格的输出，因为没有加上 -t 的参数，所以默认就是 filter 这个表格内的 INPUT, OUTPUT, FORWARD 三条链的规则。由于没有规则嘛！所以每个链内部的规则都是空的。 同时注意一下，在每个 chain 后面括号内的 policy 项目，那就是『默认动作(政策)』咯！以上面来看， 虽然我们启动了 iptables ，但是我们没有设定规则，然后政策又是 ACCEPT， 所以是『任何封包都会接受』的意思！至于如果加上 -v 的参数时， 则连同该规则所通过的封包总位数也会被列出来啊。底下则是 nat 表格的规则项目： 

    [root@linux ~]# iptables -t nat -L -n
    Chain OUTPUT (policy ACCEPT)
    target     prot opt source               destination
    
    Chain POSTROUTING (policy ACCEPT)
    target     prot opt source               destination
    
    Chain PREROUTING (policy ACCEPT)
    target     prot opt source               destination

与 fiter 表格一模一样！只是三条链的内容不同。后当你设定每一条防火墙的规则时，记得瞧一瞧设定先！那如何清除规则？这样做：

    [root@linux ~]# iptables [-t tables] [-FXZ]
    参数：
    -F ：清除所有的已订定的规则；
    -X ：杀掉所有使用者 "自定义" 的 chain (应该说的是 tables ）啰；
    -Z ：将所有的 chain 的计数与流量统计都归零
    
    范例：清除本机防火墙 (filter) 的所有规则
    [root@linux ~]# iptables -F
    [root@linux ~]# iptables -X
    [root@linux ~]# iptables -Z


## 简单配置


    [root@localhost sh]# cat iptables.rule 
    #!/bin/bash
    
    EXTIF="eth0" # 这个是可以连上 Public IP 的网络接口
    INIF="eth0" # 内部 LAN 的连接接口
    export EXTIF INIF
    
    #清除规则
    iptables -F
    iptables -X
    iptables -Z
    
    #默认policy 
    iptables -t filter -P INPUT   DROP
    iptables -t filter -P OUTPUT  ACCEPT
    iptables -t filter -P FORWARD ACCEPT
    
    iptables -t filter -A INPUT -i lo -j ACCEPT
    iptables -t filter -A INPUT -m state --state RELATED,ESTABLISHED -j ACCEPT
    
    #拒绝指定ip进入本机
    #iptables -t filter -A INPUT -i ${EXTIF} -s 89.137.201.0/24 -j DROP
    
    #允许指定ip进入本机
    iptables -t filter -A INPUT -i ${EXTIF} -s 166.63.126.33 -j ACCEPT
    iptables -t filter -A INPUT -i ${EXTIF} -s 192.168.0.0/24 -j ACCEPT
    
    #防止syn攻击（DDOOS攻击的一种）
    iptables -I INPUT -p tcp --syn -m limit --limit 1/s -j ACCEPT
    iptables -I FORWARD -p tcp --syn -m limit --limit 1/s -j ACCEPT
    
    #防止各种端口扫描
    iptables -A FORWARD -p tcp --tcp-flags SYN,ACK,FIN,RST RST -m limit --limit 1/s -j ACCEPT
    
    #Ping洪水攻击（Ping of Death）
    iptables -A FORWARD -p icmp --icmp-type echo-request -m limit --limit 1/s -j ACCEPT
    
    #某些类型的 ICMP 封包进入
    AICMP="0 3 3/4 4 8 11 12 14 16 18"
    for tyicmp in $AICMP
    do
    iptables -t filter -A INPUT -i ${EXTIF} -p icmp --icmp-type $tyicmp -j ACCEPT
    done
    
    #拒绝某些服务的进入，依照环境开启
     iptables -t filter -A INPUT -p TCP -i ${EXTIF} --dport 22 -j ACCEPT # SSH
    #iptables -t filter -A INPUT -p TCP -i ${EXTIF} --dport 25 -j ACCEPT # SMTP
     iptables -t filter -A INPUT -p UDP -i ${EXTIF} --sport 53 -j ACCEPT # DNS
     iptables -t filter -A INPUT -p TCP -i ${EXTIF} --sport 53 -j ACCEPT # DNS
     iptables -t filter -A INPUT -p TCP -i ${EXTIF} --dport 80 -j ACCEPT # WWW
    #iptables -t filter -A INPUT -p TCP -i ${EXTIF} --dport 110 -j ACCEPT # POP3
     iptables -t filter -A INPUT -p TCP -i ${EXTIF} --dport 443 -j ACCEPT # HTTPS

## 转载

[ Linux 防火墙与 NAT 主机](http://vbird.dic.ksu.edu.tw/linux_server/0250simple_firewall/0250simple_firewall-centos4.php)
