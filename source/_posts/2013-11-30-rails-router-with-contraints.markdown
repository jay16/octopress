---
layout: post
title: rails router - 路由过滤
date: 2013-11-30 21:39:08
comments: true
categories: Rails,router
---
有时由于一些原因需要限制url链接中传过来的参数符合我们定制的规则，对参数的限制在路由配置时使用**constraints**关键定。

例如限制参数id的值以A开头，应该这样写：

    get 'photos/:id', to: 'photos#show', constraints: { id: /[A-Z]\d{5}/ }
    
    #等同于
    
    get 'photos/:id', to: 'photos#show', id: /[A-Z]\d{5}/
    
    #/photos/A12345 => 可以正常访问
    #/photos/893    => 会被路由过滤掉，而访问失败

## 基础用法

上面的用法也属于基础用法，使用constraints还可以限制约束url的结构，例如管理文章的url中约束为admin/*，可以这样写:

    get 'photos', constraints: {subdomain: 'admin'}
    
    #等同于
    
    namespace :admin do
      constraints subdomain: 'admin' do
        resources :photos
      end
    end

## 高级用法

可以像rails实现router约束的原理一样，提供一个含`matches?`方法的对象来使用constraints的高级用法。

举个实例来说明constraints的高级用法,假如我们有一个用户ip列表，只有这个列表中的ip才可以访问我们指定的网页。

先介绍它的简洁用法，是直接在constraints里调用`lambda`。

    TwitterClone::Application.routes.draw do
      get '*path', to: 'blacklist#index',
        constraints: lambda { |request| Blacklist.retrieve_ips.include?(request.remote_ip) }
    end

如果约束的条件比较多，都写在router里会显示臃肿，这时可以写一个module文件专门来写定义约束，这个文件放在`config/initializers`路径下，rails启动时会自动加载这个module,可以在router里直接调用。

    #config/initializers/self_router.rb
    class SelfRouter
      def initialize
        @ips = Blacklist.retrieve_ips
      end
     
      def matches?(request)
        @ips.include?(request.remote_ip)
      end
    end
     
    #config/router
    get '*path', to: 'blacklist#index',
      constraints: SelfRouter.new


## 微信实例

微信消息的接收就符合使用constraints。先说明一下微信消息接收的规则，它只对一个url(假设为http://xsolife.com/weixin)发送验证、文本、语音、位置等微信消息，不同微信消息的区分是微信服务器在触发url时传过的参数**type**.

无论是在控制器的方法中，还是在router中针对type来作判断，都会让代码非丑陋，而需求有改变时调整代码也是很痛苦的，constraints可以优美的化解这个窘迫处境。

    #config/initializers/weixin_router.rb 
    #encoding : utf-8
    module Weixin
      # 微信内部路由规则类，用于简化配置
      class Router
    
        # 支持以下形式
        def initialize(options, &block)
          @type       = options[:type]    if options[:type]
          @content    = options[:content] if options[:content]
          @constraint = block if block_given?
        end
    
        def matches?(request)
          xml = request.params[:xml]
          result = true
          result = result && (xml[:MsgType] == @type) if @type
          result = result && (xml[:Content] =~ @content) if @content.is_a? Regexp
          result = result && (xml[:Content] == @content) if @content.is_a? String
          result = result && @constraint.call(xml) if @constraint
    
          return result
        end
      end
    
      module ActionController
        # 辅助方法，用于简化操作，weixin_xml.content 比用hash舒服
        def weixin_xml
          @weixin_xml ||= WeixinXml.new(params[:xml])
          return @weixin_xml
        end
    
        class WeixinXml
          #对微信所有消息类型都做了定义
          attr_accessor :to_user_name, :from_user_name, :create_time, :msg_type, :msg_id
          attr_accessor :content                                 #text
          attr_accessor :pic_url, :media_id                      #image
          attr_accessor :media_id, :format                       #voice
          attr_accessor :media_id, :thumb_media_id               #video
          attr_accessor :location_x, :location_y, :scale, :label #location
          attr_accessor :title, :description, :url               #link
          attr_accessor :event, :event_key, :ticket              #event, scan
          attr_accessor :event, :latitude, :longitude, :precision
    
          def initialize(hash)
            @to_user_name = hash[:ToUserName]
            @from_user_name = hash[:FromUserName]
            @create_time = hash[:CreateTime]
            @msg_type = hash[:MsgType]
            @msg_id = hash[:MsgId]
            @content = hash[:Content]
            @pic_url = hash[:PicUrl]
            @media_id = hash[:MediaId]
            @format = hash[:Format]
            @thumb_media_id = hash[:ThumbMediaId]
            @location_x = hash[:Location_X]
            @location_y = hash[:Location_Y]
            @scale = hash[:Scale]
            @label = hash[:Label]
            @title = hash[:Title]
            @description = hash[:Description]
            @url = hash[:Url]
            @event = hash[:Event]
            @event_key = hash[:EventKey]
            @ticket = hash[:Ticket]
            @latitude = hash[:Latitude]
            @longitude = hash[:Longitude]
            @precision = hash[:Precision]
          end
        end
      end
    end
    
    #让方法weixin可以直接在ActionController、ActionView被直接调用
    ActionController::Base.class_eval do
      include ::Weixin::ActionController
    end
    ActionView::Base.class_eval do
      include ::Weixin::ActionController
    end
    
    ####################################################
    ####################################################
    
    #config/router 
    #处理weixin消息
    scope :path => "/weixin", :via => :post, :defaults => {:format => "xml"} do 
        #接收事件推送
        root :to => "weixin#event", :constraints => Weixin::Router.new(:type => "event")
        #接收普通消息
        root :to => "weixin#receive", :constraints => Weixin::Router.new(:type => "text")
        root :to => "weixin#receive", :constraints => Weixin::Router.new(:type => "image")
        root :to => "weixin#receive", :constraints => Weixin::Router.new(:type => "voice")
        root :to => "weixin#receive", :constraints => Weixin::Router.new(:type => "video")
        root :to => "weixin#receive", :constraints => Weixin::Router.new(:type => "location")
        root :to => "weixin#receive", :constraints => Weixin::Router.new(:type => "link")
        root :to => "weixin#other" #没有被处理到的事件
    end
    match "/weixin" => "weixin#authen", :via => :get
    
    ####################################################
    ####################################################
    
    class WeixinController < ApplicationController
      skip_before_filter :verify_authenticity_token
      before_filter :receve_xml,   except: [:authen]
      respond_to :xml, :html, :js
    
      def event; end
      def receive; end
      def other; end
      
      #weixin开发模式验证
      def authen
        if params[:nonce] #weixin服务器验证url
          array = [Rails.configuration.weixin_token, params[:timestamp], params[:nonce]].sort
          if params[:signature] == Digest::SHA1.hexdigest(array.join)
            render :text => params[:echostr]
          else
            render :text => "Forbidden", :status => 403 
          end
        else              #个人访问
          render :template => "weixin/index"
        end
      end
    
      def receve_xml
        @weixin = weixin_xml
      end
    end
    
    ####################################################
    ####################################################
    
    #app/view/weixin/receive.xml.erb
    <xml>
    <ToUserName><![CDATA[<%= @weixin.from_user_name %>]]></ToUserName>
    <FromUserName><![CDATA[<%= @weixin.to_user_name %>]]></FromUserName>
    <CreateTime><%= Time.now.to_i %></CreateTime>
    <MsgType><![CDATA[news]]></MsgType>
    <Content><![CDATA[]]></Content>
    <ArticleCount>3</ArticleCount>
    <Articles>
      <item>
        <Title><![CDATA[MailHok 邮件确达服务]]></Title>
        <Description><![CDATA[IntFocus 企业级群发邮件服务]]></Description>
        <PicUrl><![CDATA[http://xsolife.com/photos/f6326272-2513-304e-83a8-c39f5063ca71/bd4d432b-6cab-389a-a0fe-e20d7b7e7fb5.png]]></PicUrl>
        <Url><![CDATA[http://main.intfocus.com]]></Url>
      </item>
      <item>
        <Title><![CDATA[SOLife 微信]]></Title>
        <Description><![CDATA[SOLife微主测试明细]]></Description>
        <PicUrl><![CDATA[http://xsolife.com/photos/f6326272-2513-304e-83a8-c39f5063ca71/a09c60fb-f73e-300a-9fce-49e4c0d0165e.jpg]]></PicUrl>
        <Url><![CDATA[http://xsolife.com/weixin]]></Url>
      </item>
      <item>
        <Title><![CDATA[<%= "您的[#{@weixin.msg_type}]消息详情" %>]]></Title>
        <Description><![CDATA[<%= "您的[#{@weixin.msg_type}]消息已收到.\n查看详情清点击: http://xsolife.com/weixin/#{@record.id}" %>]]></Description>
        <PicUrl><![CDATA[http://xsolife.com/photos/f6326272-2513-304e-83a8-c39f5063ca71/a09c60fb-f73e-300a-9fce-49e4c0d0165e.jpg]]></PicUrl>
        <Url><![CDATA[<%= "http://xsolife.com/weixin/#{@record.id}" %>]]></Url>
      </item>
    <Articles>
    </xml>
    
    ####################################################
    
    #app/view/weixin/event.xml.erb
    <xml>
    <ToUserName><![CDATA[<%= @weixin.from_user_name %>]]></ToUserName>
    <FromUserName><![CDATA[<%= @weixin.to_user_name %>]]></FromUserName>
    <CreateTime><%= Time.now.to_i %></CreateTime>
    <MsgType><![CDATA[text]]></MsgType>
    <Content><![CDATA[<%= @weixin.event == "subscribe" ? "欢迎关注SOLife微信./::~" : "谢谢您的使用./::~" %>]]></Content>
    </xml>
    
    ####################################################
    
    #app/view/weixin/other.xml.erb
    <xml>
    <ToUserName><![CDATA[<%= @weixin.from_user_name %>]]></ToUserName>
    <FromUserName><![CDATA[<%= @weixin.to_user_name %>]]></FromUserName>
    <CreateTime><%= Time.now.to_i %></CreateTime>
    <MsgType><![CDATA[text]]></MsgType>
    <Content><![CDATA[<%= "hi,\n已收到您的信息[但未能正确判断消息类型]" %>]]></Content>
    </xml>

## 参考

1. [Rails Routing from the Outside In](http://guides.rubyonrails.org/routing.html)
2. [用 Rails 搭建微信公众平台 API](http://chaoskeh.com/blog/create-weixin-api-by-rails.html)
