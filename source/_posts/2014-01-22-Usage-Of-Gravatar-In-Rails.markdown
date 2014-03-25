---
layout: post
title: rails中使用gravatar头像
date: 2014-01-22 15:59:31
comments: true
categories: [ruby,rails]
---
 Gravatar是Globally Recognized Avatar的缩写,是gravatar推出的一项服务，意为“全球通用头像”。如果在Gravatar的服务器上放置了你自己的头像，那么在任何支持 Gravatar的blog或者留言本上留言时，只要提供你与这个头像关联的email地址，就能够显示出你的Gravatar头像来。

 Gravatar的概念首先是在国外的独立WordPress博客中兴起的，当你到任何一个支持Gravatar的网站留言时，这个网站都就会根据你所提 供的Email地址为你显示出匹配的头像。当然，这个头像，是需要你事先到Gravatar的网站注册并上传的，否则，在这个网站上，就只会显示成一个默 认的头像。

在使用rails搭建个人网站solife过程中有些地方需要显示头像比如自我介绍、评论留言等。不可避免的需要通过email关联到gravatar头像，下面介绍两个ruby gem。

## [gravtastic](https://github.com/chrislloyd/gravtastic)

    gem "gravtastic"

这个gem包要与一个model关联，当然了，这个model中必然有email的属性。

    class User < ActiveRecord::Base
      include Gravtastic
      gravtastic
    end

可以通过`is_gravtastic!`,`is_gravtastic`或者`has_gravatar`来判断当前登陆用户是否有gravatar头像。

在视图中显示时直接调用`gravatar_url`属性即可。

    <%= image_tag @user.gravatar_url(:rating => 'G', :secure => false) %>

## [gravatar_image_tag](https://github.com/mdeering/gravatar_image_tag)

    gem "gravatar_image_tag"

这个gem包直接关联到邮箱地址，操作简单，是评论系统中基本需求的最简单可行方案。它提供了不同的helper method，可以根据自身情况选择调用其中的方法。

方法一，直接生成image_tag,

    
    <%= gravatar_image_tag('solife.jay@gmail.com', :alt => 'jay') %>
    

方法二，生成url在image中套用

    
    <%= image_tag(gravatar_image_url('solife.jay@gmail.com', :alt => 'jay')) %>
    

对gravatar_image_tag初始化默认设置。

    
    # config/initializers/gravatar_image_tag.rb
    GravatarImageTag.configure do |config|
      config.default_image           = nil  # 当gravatar头像不存在时显示的头像 [:identicon, :monsterid, :wavatar, 404 ].
      config.filetype                = nil  # 设置头像的图像格式['gif', 'jpg' or 'png']，默认为png
      config.include_size_attributes = true  # 此处设置为false,下面的size设置则无效
      config.rating                  = nil  # 设置头像的敏感度级别['G', 'PG', 'R', 'X']，默认为普通G
      config.size                    = nil  # 设置头像显示大小（1..512),默认为80
      config.secure                  = false # Set this to true if you require secure images on your pages.
    end
    
