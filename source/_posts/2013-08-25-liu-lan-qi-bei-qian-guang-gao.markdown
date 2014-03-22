---
layout: post
title: 浏览器被嵌广告
date: 2013-08-25 15:33:35
comments: true
categories: other
---
## 起因

使用FireFox浏览器浏览网页时，浏览器顶部莫名的出现`设置`按钮,难道电脑中毒,浏览器被植入广告?


    <!-- 多出来的html代码-->
    <div class="ad-dialog ad_ style0" id="ad_id" style="width: 800px; display: block; height: 68px;">
      <div class="title tt_"></div>
    
      <div class="icon">
        <a class="icon-min min_" style="display: none;">
           <span></span>
        </a>
        <a class="icon-max max_" style="display: block;">
          <span></span>
        </a>
        <a class="icon-close close_">
          <span>Χ</span>
        </a>
        <a class="" href="" style="width:auto;" target="_blank">
          <span>设置</span>
        </a>
      </div>
    
      <div class="content ct_">
        <iframe class="ct_adframe" frameborder="no" id="adframe" name="adframe" scrolling="no" src="http://222.186.14.117/55ba7f208e79481089ec9769a509d738.html" style="width: 800px; height: 50px;">
        </iframe>
      </div>
    
      <div class="arrow ar_">
        <a class="drop-arrow drop_" style="display: none;">∧</a>
        <a class="up-arrow up_" style="display: block;">∨</a>
      </div>
    </div>

## 疑问

查看html代码中出现的ip: **220.186.14.117** ,竟然是正规网站[江苏音符](www.jsinfo.net),到底是谁在捣鬼?!


    [root@localhost ~]# whois 222.186.14.117
    [Querying whois.apnic.net]
    [whois.apnic.net]
    % [whois.apnic.net]
    % Whois data copyright terms    http://www.apnic.net/db/dbcopyright.html
    
    % Information related to '222.184.0.0 - 222.191.255.255'
    
    inetnum:        222.184.0.0 - 222.191.255.255
    netname:        CHINANET-JS
    descr:          CHINANET jiangsu province network
    descr:          China Telecom
    descr:          A12,Xin-Jie-Kou-Wai Street
    descr:          Beijing 100088
    country:        CN
    admin-c:        CH93-AP
    tech-c:         CJ186-AP
    mnt-by:         APNIC-HM
    mnt-lower:      MAINT-CHINANET-JS
    mnt-routes:     MAINT-CHINANET-JS
    remarks:        This object can only modify by APNIC hostmaster
    remarks:        If you wish to modify this object details please
    remarks:        send email to hostmaster@apnic.net with your
    remarks:        organisation account name in the subject line.
    changed:        hm-changed@apnic.net 20040223
    status:         ALLOCATED PORTABLE
    source:         APNIC
    
    role:           CHINANET JIANGSU
    address:        260 Zhongyang Road,Nanjing 210037
    country:        CN
    phone:          +86-25-86588231
    phone:          +86-25-86588745
    fax-no:         +86-25-86588104
    e-mail:         ip@jsinfo.net
    remarks:        send anti-spam reports to spam@jsinfo.net
    remarks:        send abuse reports to abuse@jsinfo.net
    remarks:        times in GMT+8
    admin-c:        CH360-AP
    tech-c:         CS306-AP
    tech-c:         CN142-AP
    nic-hdl:        CJ186-AP
    remarks:        www.jsinfo.net
    notify:         ip@jsinfo.net
    mnt-by:         MAINT-CHINANET-JS
    changed:        dns@jsinfo.net 20090831
    changed:        ip@jsinfo.net 20090831
    changed:        hm-changed@apnic.net 20090901
    source:         APNIC
    changed:        hm-changed@apnic.net 20111114
    
    person:         Chinanet Hostmaster
    nic-hdl:        CH93-AP
    e-mail:         anti-spam@ns.chinanet.cn.net
    address:        No.31 ,jingrong street,beijing
    address:        100032
    phone:          +86-10-58501724
    fax-no:         +86-10-58501724
    country:        CN
    changed:        dingsy@cndata.com 20070416
    mnt-by:         MAINT-CHINANET
    source:         APNIC
    
    % This query was served by the APNIC Whois Service version 1.68 (WHOIS3)

## 截图

![浏览器被植入广告](/photos/2013-08-25-23-add_id.png)

## 相同受害者

[冷血verycd被电信嵌入广告，怎么办?](http://www.oschina.net/question/203053_123075)
