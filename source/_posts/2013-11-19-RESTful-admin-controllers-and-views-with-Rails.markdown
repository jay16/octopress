---
layout: post
title: RESTful admin controllers and views with Rails
date: 2013-11-19 12:31:48
comments: true
categories: code
---
有没有给Rails程序开发过后台管理系统？我觉得最差的选择就是给公共页面和管理后台采用同一个controller。刚开始，这样做或许很自然。我这意思是，假如有一个“books”资源，把所有与books相关的方法都放到同一个controller是很符合逻辑的吧？但是，不管是否符合逻辑，我建议永远不要这样做，因为程序将马上变得一团糟。

## 反面示例

一个非常糟的controller示例：

    def index
      if administrator?
        @books = Book.all
      else
        @books = Book.published
      end

一个非常糟的view示例：

    <%if administrator?%>
        <%=render :partial => "admin_index"%>
    <%else%>
        <h1>Published books</h1>
        bla bla bla
    <%end%>

当你开始走这条路的时候，准备好把手指敲出血，哈哈，因为你将敲无数个巨丑的“if”语句。但大多时候，公共端和管理后端对资源的操作是完全不同的，所以你最好把它们分开。

## 正确做法

*第一步 : 生成 controllers*

生成公共端的controller:
  
    rails generate controller books

生成管理后端的controller:

    rails generate controller admin/books

Rails将会在生成controllers/admin/books_controller.rb 和一个views文件夹views/admin/books

*第二步：配置 routes*

公共端routes:

    resources :books, :only => [:index, :show]

这里只给公共端读取的权限。

管理后端routes:

    namespace :admin do |admin|
      resources :books
      resources :some_other_resource
    end

这里会生成一些带namespace的helpers：admin_books_url, edit_admin_book_url 等等

*第三步：修改`form_for` url*

    <%form_for [:admin, @book] do |f|%>
       <%=f.text_field :title%>
       <%=f.submit "Save"%>
    <%end%>

这样一来，当请求update/create方法时Rails就能正确的调用controllers/admin/books_controller.rb 而不是controllers/books_controller.rb。

## 结论

controllers和views最好保持分离，而model要共用并在程序中保持惟一。

## 转载

1. [Rails中添加RESTful风格的admin controllers和views](http://rubyer.me/blog/589/)

2. [RESTful admin controllers and views with Rails](http://www.rubyfleebie.com/restful-admin-controllers-and-views-with-rails/)
