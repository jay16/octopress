---
layout: post
title: rails error - 重复提交
date: 2013-12-08 23:16:02
comments: true
categories: 
---
## 现场再现

在view中form属性设置`remote: true`即通过ajax提交时，controller会创建两次，查看log文件发现也确实提交了两次。

之前，还出现过在界面未刷新情况下，每通过ajax提交一次，controller中创建次数会增加一次,比如第一次创建提交会实质提交两次，第二次创建提交会提交三次...

这样的问题让人很无奈，因为在其他view中的创建提交都很正常，郁闷了好久，直到前段时间才发现原因，理解了为什么，心中不觉释然。

## 原因 & 解决方案

### 都是remote: true惹得祸...

在rails中想实现ajax功能需要调用**jquery_ujs**文件，view中form的ajax提交实质是**jquery_ujs**文件中的代码来处理的;

如果没有**jquery_ujs**文件就不会实现ajax提交，但如果当前view中有两个**jquery_ujs**文件，则每一次form提交会实质产生两次ajax提交....

建议: ajax处理中新render的内容里**不要再加载jquery_ujs文件**

### 其他情况

js代码中有没有监视功能的代码，到了某种场景会触发模糊对象(input[type="submit"])的click()事件？一般都js代码里出的问题，解决的方法很简单，提交后的input立即设置为disabled.

    <%= f.submit "发表", :id => "reply-submit", :class => "btn btn-primary btn-success",
                :onclick => "this.disabled = true", :data => { :disable_with => "发表中..."}  %>
