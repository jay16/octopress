---
layout: post
title: 解析JQuery插件 - bootstrap scrollspy
date: 2013-10-09 23:59:28
comments: true
categories: [java,bi,html,jquery,css,bootstrap]
---
## 代码框架

1. 定义函数`ScrollSpy()`来监听处理对滚动条的动作。

   ~~~~ js
    function ScrollSpy(element, options) {
       //  监听处理对滚动条的动作
    }
   ~~~~
  
2. 扩充`jquery`函数，定义`scrollspy`插件，调用`ScrollSpy()`函数

   ~~~~ js
    // 保存已经存在的scrollspy函数
    var old = $.fn.scrollspy
  
    //  扩充`jquery`函数，定义`scrollspy`插件
    //  现在代码可以通过$(selector).scrollspy(option)调用 
    $.fn.scrollspy = function (option) {
      return this.each(function () {
        var $this   = $(this)
        var data    = $this.data('bs.scrollspy')
        var options = typeof option == 'object' && option
     
        // 注意下面对new ScrollSpy(this, options)的调用
        if (!data) $this.data('bs.scrollspy', (data = new ScrollSpy(this, options)))
        if (typeof option == 'string') data[option]()
      })
    }
  
    $.fn.scrollspy.Constructor = ScrollSpy
    
    //避免冲突
    $.fn.scrollspy.noConflict = function () {
      $.fn.scrollspy = old
      return this
   }
   ~~~~
   
3. 加载页面时调用`scrollspy`插件

   ~~~~ js
    $(window).on('load', function () {
      // 所有[data-spy="scroll"]元素调用插件
      $('[data-spy="scroll"]').each(function () {
        var $spy = $(this)
        $spy.scrollspy($spy.data())
      })
    })
   ~~~~

## jQuery.proxy

> jQuery.proxy(),接受一个函数，然后返回一个新函数，并且这个新函数始终保持了特定的上下文(context )语境。

    // 调用方法一:
    jQuery.proxy( function, context )
    
    // function将要改变上下文语境的函数。
    // context函数的上下文语境(`this`)会被设置成这个 object 对象。
    
    // 调用方法二
    jQuery.proxy( context, name )
    
    // context函数的上下文语境会被设置成这个 object 对象。
    // name将要改变上下文语境的函数名(这个函数必须是前一个参数 ‘context’ 对象的属性)

这个方法通常在向一个元素上附加事件处理函数时，上下文语境实际是指向另一个对象的情况下使用。

另外，jQuery 能够确保即使你绑定的函数是经过 jQuery.proxy() 处理过的函数，你依然可以用原先的函数来正确地取消绑定。

    var obj = {
    name: "John",
    test: function() {
    alert( this.name );
    $("#test").unbind("click", obj.test);
    }
    };
    
    $("#test").click( jQuery.proxy( obj, "test" ) );
    
    // 以下代码跟上面那句是等价的:
    // $("#test").click( jQuery.proxy( obj.test, obj ) );
    
    // 可以与单独执行下面这句做个比较。
    // $("#test").click( obj.test );
 
    /* jQuery 源码之 proxy:
     使用 apply 形式, 执行回调函数.
    */
    jQuery.proxy = function( fn, proxy, thisObject ) {
        if ( arguments.length === 2 ) {
            // jQuery.proxy(context, name);
            if ( typeof proxy === "string" ) {
                thisObject = fn;
                fn = thisObject[ proxy ];
                proxy = undefined;
    
                /* 转化结果：
                    thisObject -> context
                    fn -> name
                    proxy -> undefined
                 */
            }
            // jQuery.proxy(name, context);
            else if ( proxy && !jQuery.isFunction( proxy ) ) {
                thisObject = proxy;
                proxy = undefined;
            }
        }
        if ( !proxy && fn ) {
            /* 使用 proxy 保证 函数执行时, context 为指定值 */
            proxy = function() {
                return fn.apply( thisObject || this, arguments );
            };
        }
        // Set the guid of unique handler to the same of original handler, so it can be removed
        if ( fn ) {
            proxy.guid = fn.guid = fn.guid || proxy.guid || jQuery.guid++;
        }
        // So proxy can be declared as an argument
        return proxy;
    }

    /* ========================================================================
     * Bootstrap: scrollspy.js v3.0.0
     * http://twbs.github.com/bootstrap/javascript.html#scrollspy
     * ========================================================================
     * Copyright 2012 Twitter, Inc.
     *
     * Licensed under the Apache License, Version 2.0 (the "License");
     * you may not use this file except in compliance with the License.
     * You may obtain a copy of the License at
     *
     * http://www.apache.org/licenses/LICENSE-2.0
     *
     * Unless required by applicable law or agreed to in writing, software
     * distributed under the License is distributed on an "AS IS" BASIS,
     * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
     * See the License for the specific language governing permissions and
     * limitations under the License.
     * ======================================================================== */
    
    
    +function ($) { "use strict";
    
      // SCROLLSPY CLASS DEFINITION
      // ==========================
    
      function ScrollSpy(element, options) {
    
        var href
        var process  = $.proxy(this.process, this)
    
        this.$element       = $(element).is('body') ? $(window) : $(element)
        this.$body          = $('body')
        this.$scrollElement = this.$element.on('scroll.bs.scroll-spy.data-api', process)
        this.options        = $.extend({}, ScrollSpy.DEFAULTS, options)
        this.selector       = (this.options.target
          || ((href = $(element).attr('href')) && href.replace(/.*(?=#[^\s]+$)/, '')) //strip for ie7
          || '') + ' .nav li > a'
        //alert(this.selector);
        this.offsets        = $([])
        this.targets        = $([])
        this.activeTarget   = null
    
        this.refresh()
        this.process()
      }
    
      ScrollSpy.DEFAULTS = {
        offset: 10
      }
    
      ScrollSpy.prototype.refresh = function () {
        var offsetMethod = this.$element[0] == window ? 'offset' : 'position'
        //alert(offsetMethod);
    
        this.offsets = $([])
        this.targets = $([])
    
        var self     = this
        var $targets = this.$body
          .find(this.selector)
          .map(function () {
            var $el   = $(this)
            var href  = $el.data('target') || $el.attr('href')
            //alert(href);
            var $href = /^#\w/.test(href) && $(href)
    
            return ($href
              && $href.length
              && [[ $href[offsetMethod]().top + (!$.isWindow(self.$scrollElement.get(0)) && self.$scrollElement.scrollTop()), href ]]) || null
          })
          .sort(function (a, b) { return a[0] - b[0] })
          .each(function () {
            //alert(this.join("-"));
            self.offsets.push(this[0])
            self.targets.push(this[1])
          })
        
      }
    
      ScrollSpy.prototype.process = function () {
        var scrollTop    = this.$scrollElement.scrollTop() + this.options.offset
        var scrollHeight =  this.$body[0].scrollHeight //this.$scrollElement[0].scrollHeight || this.$body[0].scrollHeight
        var maxScroll    = scrollHeight// - this.$scrollElement.height()
        //alert("scrollTop-"+scrollTop+"-scrollHeight-"+scrollHeight+"-height-"+this.$scrollElement.height());
    
        var offsets      = this.offsets
        var targets      = this.targets
        var activeTarget = this.activeTarget
        var i
    
        if (scrollTop >= maxScroll) {
           //alert("MAX-"+scrollTop+"-"+maxScroll);
          return activeTarget != (i = targets.last()[0]) && this.activate(i)
        }
    
        for (i = offsets.length; i--;) {
    
        
          if( scrollTop >= offsets[i] && (!offsets[i + 1] || scrollTop <= offsets[i + 1])){
            //alert("yes-"+i);
            }
          activeTarget != targets[i]
            && scrollTop >= offsets[i]
            && (!offsets[i + 1] || scrollTop <= offsets[i + 1])
            && this.activate( targets[i] ) && alert(i)
        }
      }
    
      ScrollSpy.prototype.activate = function (target) {
        this.activeTarget = target
             //alert("active-"+target);
        $(this.selector)
          .parents('.active')
          .removeClass('active')
    
        var selector = this.selector
          + '[data-target="' + target + '"],'
          + this.selector + '[href="' + target + '"]'
    
        var active = $(selector)
          .parents('li')
          .addClass('active')
    
        if (active.parent('.dropdown-menu').length)  {
          active = active
            .closest('li.dropdown')
            .addClass('active')
        }
    
        active.trigger('activate')
      }
    
    
      // SCROLLSPY PLUGIN DEFINITION
      // ===========================
    
      var old = $.fn.scrollspy
    
      $.fn.scrollspy = function (option) {
        return this.each(function () {
          var $this   = $(this)
          var data    = $this.data('bs.scrollspy')
          //alert(data);
          var options = typeof option == 'object' && option
    
          if (!data) $this.data('bs.scrollspy', (data = new ScrollSpy(this, options)))
          //alert(data);
          if (typeof option == 'string') data[option]()
        })
      }
    
      $.fn.scrollspy.Constructor = ScrollSpy
    
    
      // SCROLLSPY NO CONFLICT
      // =====================
    
      $.fn.scrollspy.noConflict = function () {
        $.fn.scrollspy = old
        return this
      }
    
    
      // SCROLLSPY DATA-API
      // ==================
    
      $(window).on('load', function () {
        $('[data-spy="scroll"]').each(function () {
          var $spy = $(this)
          //alert($spy.data().target);
          //alert($spy.data().spy);
          $spy.scrollspy($spy.data())
        })
      })
    
    }(window.jQuery);
## 参考

1. [jQuery.proxy()代理、回调方法](http://www.css88.com/archives/4603)
