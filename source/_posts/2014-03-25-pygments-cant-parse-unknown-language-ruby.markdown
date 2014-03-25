---
layout: post
title: "Pygments can't parse unknown language: ruby"
date: 2014-03-25 08:32:08 -0400
comments: true
categories: [octopress,error]
---

在Octopress上写了篇文章，执行发布命令`bundle exec rake generate`时，出现如下报错：

``` bash error log
[root@solife octopress]# bundle exec rake generate
## Generating Site with Jekyll
identical source/stylesheets/screen.css 
Configuration from /home/work/octopress/_config.yml
Building site: source -> public
/home/work/octopress/plugins/pygments_code.rb:27:in `rescue in pygments': Pygments can't parse unknown language: java. (RuntimeError)
        from /home/work/octopress/plugins/pygments_code.rb:24:in `pygments'
        from /home/work/octopress/plugins/pygments_code.rb:14:in `highlight'
        from /home/work/octopress/plugins/backtick_code_block.rb:37:in `block in render_code_block'
        from /home/work/octopress/plugins/backtick_code_block.rb:13:in `gsub'
        from /home/work/octopress/plugins/backtick_code_block.rb:13:in `render_code_block'
        from /home/work/octopress/plugins/octopress_filters.rb:12:in `pre_filter'
        from /home/work/octopress/plugins/octopress_filters.rb:28:in `pre_render'
        from /home/work/octopress/plugins/post_filters.rb:112:in `block in pre_render'
        from /home/work/octopress/plugins/post_filters.rb:111:in `each'
        from /home/work/octopress/plugins/post_filters.rb:111:in `pre_render'
        from /home/work/octopress/plugins/post_filters.rb:166:in `do_layout'
        from /root/.rbenv/versions/1.9.3-p392/lib/ruby/gems/1.9.1/gems/jekyll-0.12.0/lib/jekyll/post.rb:195:in `render'
        from /root/.rbenv/versions/1.9.3-p392/lib/ruby/gems/1.9.1/gems/jekyll-0.12.0/lib/jekyll/site.rb:200:in `block in render'
        from /root/.rbenv/versions/1.9.3-p392/lib/ruby/gems/1.9.1/gems/jekyll-0.12.0/lib/jekyll/site.rb:199:in `each'
        from /root/.rbenv/versions/1.9.3-p392/lib/ruby/gems/1.9.1/gems/jekyll-0.12.0/lib/jekyll/site.rb:199:in `render'
        from /root/.rbenv/versions/1.9.3-p392/lib/ruby/gems/1.9.1/gems/jekyll-0.12.0/lib/jekyll/site.rb:41:in `process'
        from /root/.rbenv/versions/1.9.3-p392/lib/ruby/gems/1.9.1/gems/jekyll-0.12.0/bin/jekyll:264:in `<top (required)>'
        from /root/.rbenv/versions/1.9.3-p392/bin/jekyll:23:in `load'
        from /root/.rbenv/versions/1.9.3-p392/bin/jekyll:23:in `<main>'
```

在网上找一些与此相关的文章，解决方法就是把`mentos.py`文件中第一行代码中的`python`替换为`python2`。

查找`mentos.py`文件方法有两种，通过bundler或暴力搜索。

``` bash bundle show pygments
[root@solife octopress]# bundle show pygments
/root/.rbenv/versions/1.9.3-p392/lib/ruby/gems/1.9.1/gems/pygments.rb-0.3.4
[root@solife octopress]# ls /root/.rbenv/versions/1.9.3-p392/lib/ruby/gems/1.9.1/gems/pygments.rb-0.3.4/lib/pygments/mentos.py 
/root/.rbenv/versions/1.9.3-p392/lib/ruby/gems/1.9.1/gems/pygments.rb-0.3.4/lib/pygments/mentos.py
[root@solife octopress]# find / -name "mentos.py"
/root/.rbenv/versions/1.9.3-p392/lib/ruby/gems/1.9.1/gems/pygments.rb-0.3.4/lib/pygments/mentos.py
[root@solife octopress]# ls /root/.rbenv/versions/1.9.3-p392/lib/ruby/gems/1.9.1/gems/pygments.rb-0.3.4/lib/pygments/mentos.py 
/root/.rbenv/versions/1.9.3-p392/lib/ruby/gems/1.9.1/gems/pygments.rb-0.3.4/lib/pygments/mentos.py
[root@solife octopress]# 
```

``` bash python => python2
#!/usr/bin/env python
# 替换为
#!/usr/bin/env python2
```

做了上述操作后，再次发布文章时，依然报错...

然后就是再搜索，查找到的差不多都是这种解决方法，很是郁闷。终于在某个帖子里看到有人贴出了自己系统的python版本号，感觉自己的问题应该就在python版本上。

系统上安装的python版本是2.4的，于是就升级，然后报错问题就解决了...

总结一下：上述解决方法有效的前堤是python版本要跟上。


``` bash python 2.4.3 升级到 2.6.8
[root@solife octopress]# python -V
Python 2.4.3
[root@solife octopress]# python2 -V
Python 2.4.3 
[root@solife octopress]# cd /home/tools/
[root@solife tools]# yum install libffi 
[root@solife tools]# yum install python26 
[root@solife tools]# rm -f /usr/bin/python
[root@solife tools]# ln -s /usr/bin/python26 /usr/bin/python
[root@solife tools]# python -V
Python 2.6.8
[root@solife tools]# cd /home/work/octopress/
[root@solife octopress]# bundle exec rake generate
## Generating Site with Jekyll
identical source/stylesheets/screen.css 
Configuration from /home/work/octopress/_config.yml
Building site: source -> public
Successfully generated site: source -> public
```

### 参考

1. [Pygments can't parse unknown language: ruby #1173](https://github.com/imathis/octopress/issues/1173)
2. [Octopress Syntax Highlighting Issue on Arch Linux](http://www.techbeat.in/)
3. [Arch Linux, Octopress, and Misbehaving Pygments](http://nonsenseby.me/blog/2013/04/13/arch-linux/)
