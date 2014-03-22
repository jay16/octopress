---
layout: post
title: Rails model - many to many
date: 2013-08-29 08:35:20
comments: true
categories: code
---
## 苦头

在本站搭建中多对多的模型使用,真是吃尽了苦头,也煎熬了好久,本站已搭建了近两个月,直到今天才把这个问题解决了,把错误的原因及教训好好总结一番。

## 应用

多对多模型在本站的应用就是文章(segment)与标签(tag)的通过桥梁(segments_tags)关联。

如果关联成功了就可以`segment.tags`这样调用文章的标签。

但之前没有关联成功,就要分段的一节一节的关联,需要写在Help方法中,代码很臃肿

    def tags_list
      sts = segment.segments_tags
      tags = []
      sts.each { |st| tags.push(Tag.find(st.tag_id)) }
      return tags
    end

## 原因

`rails`创建模型的默认约定,模型名称要**单数**,数据库中自动创建**复数**表名

而我创建关联的模型`segments_tags`时直接写成了复数,那么数据库中创建的**表名与模型名称相同**

应该就是这里出的问题了,每次调用`segment.tags`都会报错误`uninitialized constant Segment::SegmentsTag`,这就证明**创建模型时名称不可以为复数.**

即`rails`是通过`model`中关联名`segments_tags`称反推出来单数名称`segments_tag`的。

    class Segment < ActiveRecord::Base
      has_many :segments_tags
      has_many :tags , :through => :segments_tags
    end

## 解决方法

把`SegmentsTags`类修改为`SegmentTag`同时把`model`文件名称修改为`segments_tag.rb`,这样困扰我好久的问题就解决了。

## 完整代码

`model`代码:

    class Segment < ActiveRecord::Base
      has_many :segments_tags
      has_many :tags , :through => :segments_tags
    end
    
    [root@allentest solife]# cat app/models/tag.rb 
    class Tag < ActiveRecord::Base
      has_many :segments_tags
      has_many :segments, :through => :segments_tags
    end
    
    [root@allentest solife]# cat app/models/segments_tag.rb 
    class SegmentsTag < ActiveRecord::Base
      belongs_to :segment
      belongs_to :tag

`migration`代码:


        create_table :segments_tags do |t|
          t.integer :segment_id
          t.integer :tag_id
    
          t.timestamps
        end

## 参考

[每天一剂Rails良药之具有数据的多对多关系](http://hideto.iteye.com/blog/76556)
