---
layout: post
title: "Octopress使用[友言]作为评论"
date: 2014-03-25 08:00:44 -0400
comments: true
categories: [ruby,octopress,java,html,disqus,uyan]
---

在Octopress中默认的评论系统是Disqus,打开配置文件_config.yml搜索disqus可看到相关代码，只是没有启用。

只是Disqus作为国外比较流行的评论系统，基于国内外网速、社交不同，不是国人博客很好的选择。

国内的友言评论系统支持常用社交网站账号作为第三方登陆来评论是比较接无地气的，加载速度完全没有问题。

具体配置步骤:

1.在_config.yml中添加一个配置项，比如uyan_comment: true

``` ruby _config.yml
# Disqus Comments
disqus_short_name: 
disqus_show_comment_count: false
 
# 添加下面代码
# Uyan Comments
uyan_comment: true
```

2.添加一个被include的文件，用来存放友言提供给我们的插入代码，比如：source/_include/post/uyan_comments.html

在[友言](http://www.uyan.cc/)注册后创建站点就可获得js代码。


``` javascript source/_include/post/uyan_comments.html
<!-- UY BEGIN -->
<div id="uyan_frame"></div>
<script type="text/javascript" src="http://v2.uyan.cc/code/uyan.js?uid=uyan_uid"></script>
<!-- UY END -->
```

3.修改source/_layout/post.html，在disqus代码下方添加友言代码。

``` javascript source/_layout/post.html
{% if site.disqus_short_name and page.comments == true %}
  <section>
    <h1>Comments</h1>
    <div id="disqus_thread" aria-live="polite">{% include post/disqus_thread.html %}</div>
  </section>
{% endif %}
<!-- 添加下面代码 -->
{% if site.uyan_comment and page.comments == true %}
  <section>
    <h1>Comments</h1>
    {% include post/uyan_comments.html %}
  </section>
{% endif %}
```

4.侧边栏添加最近评论

登陆友言，切换到指定域名的控制面板->安装设置->嵌入组件,分别有评论热榜、最新评论、评论记数的html代码。把对应的代码放在`source/_include/custom/aside`目录下，在_config.yml中配置加载就可以了。

``` ruby  source/_includes/custom/asides/recent_comments.html
<section>
  <h1>Rencent Comments</h1>
  <!-- UYAN NEW COMMENT BEGIN -->
  <div id="uyan_newcmt_unit"></div>
  <script type="text/javascript" src="http://v2.uyan.cc/code/uyan.js?uid=uyan_uid"></script> <!-- 如果已经过加载此行JS，即可不用重复加载 -->
  <!-- UYAN NEW COMMENT END -->
</section>
```

在_config.yml中的配置项default_asides数组中添加source/_includes/custom/asides/recent_comments.html就可以了。

``` ruby _config.yml
# list each of the sidebar modules you want to include, in the order you want them to appear.
# To add custom custom/asides/recommand.htmlasides, create files in /source/_includes/custom/asides/ and add them to the list like 'custom/asides/custom_aside_name.html'
default_asides: [custom/asides/about_me.html,asides/recent_posts.html,custom/asides/recommand.html,custom/asides/recent_comments.html]
```

5.更新octopress样式并发布

``` bash
[root@solife octopress]# bundle exec rake update_source
## Removed existing source.old directory
rm -r source.old
mkdir source.old
cp -r source/. source.old
## Copied source into source.old/
cp -r --remove-destination .themes/classic/source/. source
cp -r --remove-destination source.old/_includes/custom/. source/_includes/custom/
cp source.old/favicon.png source
## Updated source ##
[root@solife octopress]# bundle exec rake generate
## Generating Site with Jekyll
overwrite source/stylesheets/screen.css
Configuration from /home/work/octopress/_config.yml
Building site: source -> public
Successfully generated site: source -> public
```

### 参考

[在Octopress中使用友言，替换Disqus](http://markzhang.cn/blog/2013/11/05/add-uyan-comment/)
