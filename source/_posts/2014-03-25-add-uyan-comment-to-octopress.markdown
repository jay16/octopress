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

1. 在_config.yml中添加一个配置项，比如uyan_comment: true

``` ruby _config.yml
# Disqus Comments
disqus_short_name: 
disqus_show_comment_count: false
 
# 添加下面代码
# Uyan Comments
uyan_comment: true
```

2. 添加一个被include的文件，用来存放友言提供给我们的插入代码，比如：source/_include/post/uyan_comments.html

在[友言](http://www.uyan.cc/)注册后创建站点就可获得js代码。


``` javascript source/_include/post/uyan_comments.html
<!-- UY BEGIN -->
<div id="uyan_frame"></div>
<script type="text/javascript" src="http://v2.uyan.cc/code/uyan.js?uid=1908046"></script>
<!-- UY END -->
```

3. 修改source/_layout/post.html，在disqus代码下方添加友言代码。

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

### 参考

[在Octopress中使用友言，替换Disqus](http://markzhang.cn/blog/2013/11/05/add-uyan-comment/)
