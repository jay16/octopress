---
layout: post
title: Rails  - render
date: 2013-08-22 05:39:07
comments: true
categories: code
---
>render模板时传入参数

    <%= render :partial => campaign, :locals => { :is_admin => is_super, :anther => "anther"}  %>

在`_campaign.html.erb`模板中就可以使用`is_amdin`,`anther`这两个实例变量。

> render模板时不加载rails项目框架

    <%= render :partial => campaign, :layout => false  %>

> render 常见用法

    render :action => "long_goal", :layout => "spectacular"
    render :partial => "person", :locals => { :name => "david" }
    render :template => "weblog/show", :locals => {:customer => Customer.new}
    render :file => "c:/path/to/some/template.erb", :layout => true, :status => 404
    render :text => "Hi there!", :layout => "special"
    render :text => proc { |response, output| output.write("Hello from code!") }
    render :xml => {:name => "David"}.to_xml
    render :json => {:name => "David"}.to_json, :callback => 'show'
    render :inline => "<%= 'hello ' + name %>", :locals => { :name => "david" }
    render :js => "alert('hello')"
    render :xml => post.to_xml, :status => :created, :location => post_url(post)
