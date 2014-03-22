---
layout: post
title: 初用CoffeeScript
date: 2013-09-12 08:15:08
comments: true
categories: other
---
## 系统环境

    [root@allentest ~]# lsb_release -a
    LSB Version:    :core-4.0-ia32:core-4.0-noarch:graphics-4.0-ia32:graphics-4.0-noarch:printing-4.0-ia32:printing-4.0-noarch
    Distributor ID: CentOS
    Description:    CentOS release 5.6 (Final)
    Release:        5.6
    Codename:       Final
    [root@allentest ~]# rails -v
    Rails 3.2.9
    [root@allentest ~]# ruby -v
    ruby 1.9.2p180 (2011-02-18 revision 30909) [i686-linux]

## 安装NodeJS

### 安装`openssl-devel`

需要`openssl-devel`编译node安装代码。

    yum install openssl-devel

### 安装Node

node最新版本为`node-v0.10.18-linux-x86.tar.gz`,[官网下载区](http://nodejs.org/download/)。最新版本是已经编译好的,倒不知道如何安装了，只好安装老版本的。

    [root@allentest ~]# cd /usr/local/src/
    [root@allentest src]# wget http://nodejs.org/dist/node-v0.6.2.tar.gz
    [root@allentest src]# tar zxvf node-v0.6.2.tar.gz
    [root@allentest src]# cd node-v0.6.2
    [root@allentest node-v0.6.2]# ./configure
    [root@allentest node-v0.6.2]# make
    [root@allentest node-v0.6.2]# make install
    [root@allentest node-v0.6.2]# node -v
    v0.6.2

### 安装npm

npg是Nodejs的包管理器,相当于Ruby的gem,Python的PyPL、setuptools，PHP的pear。

    [root@allentest node-v0.6.2]# curl https://npmjs.org/install.sh | sh
      % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                     Dload  Upload   Total   Spent    Left  Speed
    100  7882  100  7882    0     0   7121      0  0:00:01  0:00:01 --:--:--  274k
    tar=/bin/tar
    version:
    tar (GNU tar) 1.15.1
    install npm@1.1
    fetching: http://registry.npmjs.org/npm/-/npm-1.1.71.tgz
    0.6.2
    1.1.71
    cleanup prefix=/usr/local
    
    All clean!
    /usr/local/bin/npm -> /usr/local/lib/node_modules/npm/bin/npm-cli.js
    npm@1.1.71 /usr/local/lib/node_modules/npm
    It worked

## 安装coffee-script

    [root@allentest node-v0.6.2]# npm install -g coffee-script
    npm http GET https://registry.npmjs.org/coffee-script
    npm http 200 https://registry.npmjs.org/coffee-script
    npm http GET https://registry.npmjs.org/coffee-script/-/coffee-script-1.6.3.tgz
    npm http 200 https://registry.npmjs.org/coffee-script/-/coffee-script-1.6.3.tgz
    npm WARN engine coffee-script@1.6.3: wanted: {"node":">=0.8.0"} (current: {"node":"v0.6.2","npm":"1.1.71"})
    /usr/local/bin/coffee -> /usr/local/lib/node_modules/coffee-script/bin/coffee
    /usr/local/bin/cake -> /usr/local/lib/node_modules/coffee-script/bin/cake
    coffee-script@1.6.3 /usr/local/lib/node_modules/coffee-script

## 初试

在本地新建文本贴上如下代码，保存为`.html`格式，浏览器打开，直接来感受CoffeeScript不一样的简洁感 。此操作与上述`NodeJS`没有必然关系。

    <html>
    <head>
        <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.4.2/jquery.min.js"></script>
        <script src="http://jashkenas.github.com/coffee-script/extras/coffee-script.js">
     </script>
        <script type="text/coffeescript">
            gcd = (a,b) -> if (b==0) then a else gcd(b, a % b)
            $("#button").click ->
                a = $("#a").val()
                b = $("#b").val()
                $("#c").html gcd(a,b)
             
             this.a = (aa) -> alert aa
        </script>
    </head>
    <body>
        A: <input type="text" id="a"/>
        B: <input type="text" id="b"/>
        <input type="button" value="Calculate GCD" id="button"/>
        C: <span id="c"/><br>
        <input type="button" value="Function" onclick="a('this is my function')" />
    </body>
    </html>

上面`html`文件上的`coffescript`代码转换为`javascirpt`代码如下:


          var gcd;
          
          gcd = function(a, b) {
            if (b === 0) {
              return a;
            } else {
              return gcd(b, a % b);
            }
          };
          
          $("#button").click(function() {
            var a, b;
            a = $("#a").val();
            b = $("#b").val();
            return $("#c").html(gcd(a, b));
          });
          
          this.a = function(aa) {
            return alert(aa);
          };

## 参考

1. [Install coffee script compiler on CentOS](https://gist.github.com/adrienbrault/1401812)
2. [CentOS5安装CoffeeScript](http://qiita.com/taka0125/items/405e8fd443f0e65700e6)
3. [深入浅出Node.js（二）：Node.js&NPM的安装与配置 ](http://www.infoq.com/cn/articles/nodejs-npm-install-config)
4. [初步了解 CoffeeScript，第 1 部分: 入门](http://blog.jobbole.com/29190/)
