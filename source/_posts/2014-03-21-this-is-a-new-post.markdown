---
layout: post
title: 部署Octopress到你的VPS 
date: 2014-03-21 08:07:04 -0400
comments: true
categories:  octopress,nginx,vps
---

## 准备工作

提到octopress，就不能不提到Ruby。因为octopress需要用到ruby的运行时环境，所以，搭建ruby环境是第一步。

安装Ruby，可以用RVM来安装和管理，方便又好用。安装步骤，可以参考官网上的介绍，安装好后，直接用RVM来安装和管理各种版本的Ruby。

Octopress默认使用的Ruby 1.9.3, 所以，得安装一个Ruby 1.9.3先……

    rvm install 1.9.3

装好后，直接去Github clone一个octopress到你的机器：

    git clone https://github.com/imathis/octopress.git

Clone好后，需要先安装一下octopress所需要用到的gem包。先进入到clone下来的octopress目录，运行命令：

    bundle install

如果提示错误，有可能你还没有安装bundler，先安装bundler：

    gem install bundler

当必要的工作准备完毕，可以初始化octopress的默认主题了，用命令：

    rake install

当然，你想用其他的主题，可以自己安装。

## 导入和生成Markdown文件

这一步，其实就是生成新的文章了，在octopress中，每一篇文章，对应着一个Markdown文件。如果你是从WordPress转移到octopress，也可以用其他的转换工具，得到一大堆的Markdown文件。这些文件都放在octopress目录的source/_posts目录中。

用octopress单独生成一篇文章的命令是：

    rake new_post['This is a new post']

生成好后，你会得到一个时间加上文章标题的Markdown文件。接下来，就是写文章了。编辑Markdown文件的方式有很多，推荐Windows下使用MarkdownPad，Mac
OS下，有大名鼎鼎的Mou来编辑。当然，我也经常用Vim来编辑文章 :–)
(参考文章：Chrome中实时预览Markdown)

写完blog，保存好你的Markdown文件。这里不得不说一下，由于octopress的blog文章，全部是Markdown文件的方式保存，文本类型的。就连octopress本身的很多配置文件，也是文本方式的，所以，完全推荐你采用版本控制工具来保存和管理你的文章和octopress配置，比如用git。除此之外，用dropbox这类的工具保存也未尝不可。

哈哈，在这里得强烈推荐一下Bitbucket，跟Github不同的地方，是可以允许建立免费的私有reposiroty，这样你的blog文件可以以私有的方式push到Bitbucket的远程仓库保存了。我就是这么干的……

如果用bitbucket的私有仓库保存octopress的配置和blog文章，只需要你每次commit文章到本地仓库，再push到bitbucket就可以了，实在是方便啊……

## 部署blog到VPS

前面介绍到了文章的生成和保存，最后一步，就是发布你的blog到你自己的VPS了。众所周知，Github提供免费的Pages服务，可以直接deploy到github上托管你的网站，这类教程网上也很多，google一下就知道方法。这里主要介绍下如何deploy博客到自己的VPS。

发布blog到自己的VPS，有几种方式，这里介绍一种相对简单的方式，后面的文章，我打算再说说其他的几种方式。

写好了文章，保存好Markdown文件，下一步，就是发布了。我们都知道，octopress生成后的blog页面，全部是静态页面，不同于php一类的语言，需要服务端安装对应的组件来动态解析。因此，octopress的这种简单部署方式，只要求服务端有一个能支持展现静态页面的。如今都是二十一世纪了，哪个web服务端不支持静态页面呢？呵呵……

## 配置Nginx

在这里，我们选用处理静态页面性能比较出色的Nginx来作为host我们blog的服务端。
Nginx的安装比较简单，你可以直接去官网下载源代码编译安装，也可以用包管理来安装。这里以debian为例，使用apt来安装：

    apt-get install nginx

安装好后，你会在/etc/nginx/找到nginx的配置文件，可以在sites-avaialble中建立你的站点的配置文件。以我的blog为例：

    server {
            listen 80;

            root /home/username/octopress;
            index index.html index.htm;

            server_name xiaozhou.net www.xiaozhou.net;
    }

站点指向/home/timothy/octopress目录，也就是我的blog部署到VPS上的目标目录。

默认访问页面是index.html和index.htm

绑定的域名，是我的blog的域名，配置非常简单，省去了动态脚本解析的配置部分。

## 转载

[部署Octopress到你的VPS](http://www.xiaozhou.net/deploy-octopress-to-your-vps-2013-08-13.html)
