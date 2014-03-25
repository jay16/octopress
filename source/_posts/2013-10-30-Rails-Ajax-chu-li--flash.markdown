---
layout: post
title: Rails Ajax 处理 flash
date: 2013-10-30 00:13:06
comments: true
categories: [error,rails,html,jquery]
---
## 困惑

controller在做html响应处理时是**跳转**动作即全页面刷新，flash临时变量即可显示。但使用ajax做局部刷新时，要实现显示flash信息，难道要一个一个的手工在controller对应js.erb文件中做处理？！还是不要吧！


## 实现方案

view(layout/application.html.erb)中添加临时信息的div容器。

      <div class="row-fluid flash">
        <div class="span12">
            <div class="notice"><%= notice %></div>
            <div class="alert"><%= alert %></div>
            <div class="error"></div>
            <div class="loading"><%= t("layout.loading") %>...</div>
        </div>
      </div>

controller(app/conroller/application.rb)中监听flash信息并赋值给response。

      after_filter :flash_to_headers
      
      def flash_to_headers
         return unless request.xhr?
         response.headers['X-Message'] = flash_message
         response.headers["X-Message-Type"] = flash_type.to_s
    
         flash.discard
      end
    
      private
    
      def flash_message
         [:error, :warning, :notice, nil].each do |type|
           return "type is null" if type.nil?
           return flash[type] unless flash[type].blank?
         end
      end
    
      def flash_type
         [:error, :warning, :notice, nil].each do |type|
             return "" if type.nil?
             return type unless flash[type].blank?
         end
      end

js(app/assets/application.coffee)监听response，并做出响应在view中做处理。

    $ ->
      #使用ajax响应动作时，处理flash信息
      #默认隐藏flash-div
      $(".#{type}").hide("fast") for type in ['notice', 'alert', 'error', 'loading']
    
      #显示函数
      show_ajax_flash=(msg,type) ->
        t = $(".#{type}")
        t.show(0).delay(5000).hide("slow").fadeOut("slow");
    
      #监视ajax动作
      $(document).ajaxComplete((event, request) ->
        msg = request.getResponseHeader('X-Message');
        type = request.getResponseHeader('X-Message-Type');
    
        show_ajax_flash(msg,type) unless type.blank?
      );

coffeescript对应的jquery代码:

    $(function() {
      var show_ajax_flash, type, _i, _len, _ref;
        #默认隐藏flash-div
      _ref = ['notice', 'alert', 'error', 'loading'];
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        type = _ref[_i];
        $("." + type).hide("fast");
      }
      #显示函数
      show_ajax_flash = function(msg, type) {
        var t;
        t = $("." + type);
        return t.show(0).delay(5000).hide("slow").fadeOut("slow");
      };
      #监视ajax动作
      return $(document).ajaxComplete(function(event, request) {
        var msg;
        msg = request.getResponseHeader('X-Message');
        type = request.getResponseHeader('X-Message-Type');
        if (type.blank == null) {
          return show_ajax_flash(msg, type);
        }
      });
    });

controller中可以这样写:

      respond_to :html, :js
      
      def chk_flash
        flash[:notice] = 'deal flash msg with ajax!'
      end

而此时chk_flash.js.erb中不必为显示flash信息而多写代码。

## 参考

1. [How do you handle Rail's flash with Ajax requests?](http://stackoverflow.com/questions/366311/how-do-you-handle-rails-flash-with-ajax-requests)
2. [Simple jQuery show/hide + fadeIn/fadeOut Example](http://samscode.com/index.php/2009/12/simple-jquery-showhide-fadeinfadeout-example/)
