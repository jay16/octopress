---
layout: post
title: rails router - 简单路由与嵌套路由
date: 2013-11-30 18:46:00
comments: true
categories: Rails,router,Ruby
---
使用rails搭建个人网站，功能杂，一不小心router代码就写的杂乱无章，想要优化router代码就要好好学习rails的router.

## 简单路由

网址url是如何指向到我们想让它去的代码块中，router就是用来干这个的,比如router中这样写：

    get '/members/:id', to: 'members#show'

`GET /members/17`这个请求会被路由分配到members控制器的show方法中，`{ id: '17' }`会作为参数在show方法中被调用。

如果视图中所有url链接都使用`/members/:id`这种写法来拼出来就太繁琐了，使用路由的name helper方法来生成url链接就方便很多。

    get '/members/:id', to: 'members#show', as: 'member'
    
    # 另一种写法
    
    match '/members/:id' => 'members#show', :as => :member, :via => :get

上面路由代码中的as指定helper方法名称，默认加_path后缀，`as: 'member'`就会生成name heper 方法`member_path(id)`，在视图中它就会生成`/members/:id`。

    #controller
    @member = Member.find(17)
    
    #view
    <%= link_to 'Member Detail', member_path(@member) %>
    #等同于
    <%= link_to 'Member Detail', @member %>
    #=> /members/17

`resources :member`会自动生成以下几条路由，满足基本的CRUD操作:

    HTTP Verb       Path             Action         Used for
    GET            /members           index         display a list of all members
    GET            /members/new       new           return an HTML form for creating a new member
    POST           /members           create        create a new member
    GET            /members/:id       show          display a specific member
    GET            /members/:id/edit  edit          return an HTML form for editing a member
    PATCH/PUT      /members/:id       update        update a specific member
    DELETE         /members/:id       destroy       delete a specific member

但我们的需求肯定不止CRUD操作，有新添加的方法后，如何配置路由让它起作用？最简单的方法是使用match.

    #定义mx方法，查看用户邮箱的mx记录
    match '/members/:id/mx'       => 'members#mx',       :as => :mx_member

如果每个控制器都需要添加很多新的方法，都使用match来配置路由，router代码就会显得太乱，不便于日后管理，这时可以resources内部配置新方法，无论添加再多的新方法，对于所属关系就一目了然。

    resources :members do
      get 'validate', on: :memebr
      get 'mx', on:member
    end
    
    # 会生成下面的路由
    #validate_member GET    /members/:id/validate(.:format)                      members#validate
    #mx_member GET          /members/:id/mx(.:format)                            members#mx  
    
    # 另一种更简洁的写法
    
    resources :members do
      member do
        get 'validate'
        get 'mx'
      end
    end


## 嵌套路由
 
### 第一种

url链接前带/admin前缀即/admin/posts，指向Admin::PostsController控制器。

    namespace :admin do
      resources :posts
    end
    
    #生成的对应name helper
    
    #     admin_posts GET    /admin/posts(.:format)                               admin/posts#index
    #                 POST   /admin/posts(.:format)                               admin/posts#create
    #  new_admin_post GET    /admin/posts/new(.:format)                           admin/posts#new
    # edit_admin_post GET    /admin/posts/:id/edit(.:format)                      admin/posts#edit
    #      admin_post GET    /admin/posts/:id(.:format)                           admin/posts#show
    #                 PUT    /admin/posts/:id(.:format)                           admin/posts#update
    #                 DELETE /admin/posts/:id(.:format)                           admin/posts#destroy

### 第二种

url链接中不带有/admin，像简单路由那样，指向 Admin::PostsController控制器。

    scope module: 'admin' do
      resources :posts
    end
    
    #等价于
    
    resources :posts, module: 'admin'
    
    #生成的对应name helper
    
    #     posts GET    /posts(.:format)                                     admin/posts#index
    #           POST   /posts(.:format)                                     admin/posts#create
    #  new_post GET    /posts/new(.:format)                                 admin/posts#new
    # edit_post GET    /posts/:id/edit(.:format)                            admin/posts#edit
    #      post GET    /posts/:id(.:format)                                 admin/posts#show
    #           PUT    /posts/:id(.:format)                                 admin/posts#update
    #           DELETE /posts/:id(.:format)                                 admin/posts#destroy

### 第三种

url链接前带/admin前缀即/admin/posts，但指向PostsController控制器.

    scope '/admin' do
      resources :posts
    end
    
    #等价于
    
    resources :posts, path: '/admin/posts'
    
    #生成的对应name helper
    
    #     posts GET    /admin/posts(.:format)                               posts#index
    #           POST   /admin/posts(.:format)                               posts#create
    #  new_post GET    /admin/posts/new(.:format)                           posts#new
    # edit_post GET    /admin/posts/:id/edit(.:format)                      posts#edit
    #      post GET    /admin/posts/:id(.:format)                           posts#show
    #           PUT    /admin/posts/:id(.:format)                           posts#update
    #           DELETE /admin/posts/:id(.:format)                           posts#destroy

### 第四种

resources的嵌套,会为主子资源生成两套路由，父资源的路由属于简单路由，子资源的路由属于嵌套路由，现在主要研究子资源的路由配置。

    #router
    resources :magazines do
      resources :ads
    end
    
    #生成的对应name helper
    
    #     magazine_ads GET    /magazines/:magazine_id/ads(.:format)                ads#index
    #                  POST   /magazines/:magazine_id/ads(.:format)                ads#create
    #  new_magazine_ad GET    /magazines/:magazine_id/ads/new(.:format)            ads#new
    # edit_magazine_ad GET    /magazines/:magazine_id/ads/:id/edit(.:format)       ads#edit
    #      magazine_ad GET    /magazines/:magazine_id/ads/:id(.:format)            ads#show
    #                  PUT    /magazines/:magazine_id/ads/:id(.:format)            ads#update
    #                  DELETE /magazines/:magazine_id/ads/:id(.:format)            ads#destroy
    #        magazines GET    /magazines(.:format)                                 magazines#index
    #                  POST   /magazines(.:format)                                 magazines#create
    #     new_magazine GET    /magazines/new(.:format)                             magazines#new
    #    edit_magazine GET    /magazines/:id/edit(.:format)                        magazines#edit
    #         magazine GET    /magazines/:id(.:format)                             magazines#show
    #                  PUT    /magazines/:id(.:format)                             magazines#update
    #                  DELETE /magazines/:id(.:format)                             magazines#destroy

特别说明,在视图中的name helper方法也有相关的约束简洁写法，让name helper方法名称更容易理解、记忆、书写。

    #特别说明 - 在view中
    #情况一,查看某父资源的子资源明细情况时:
    
    <%= link_to 'Ad details', magazine_ad_path(@magazine, @ad) %>
    
    #等同于
    
    <%= link_to 'Ad details', url_for([@magazine, @ad]) %>
    <%= link_to 'Ad details', [@magazine, @ad] %>
    
    ###########################################
    #情况二，编辑某父资源的子资源信息
    
    <%= link_to 'Ad details', edit_magazine_ad_path(@magazine, @ad) %>
    
    #等同于
    
    <%= link_to 'Edit Ad', [:edit, @magazine, @ad] %>
    
    ###########################################
    #情况三，查看某父资源的明细情况，其实就是简单路由配置
    
    <%= link_to 'Magazine details', @magazine %>


## 父子权力分配

需要理解的是，路由上的嵌套改变不了这样一个事实: **子资源在数据库实体表中的主键id是唯一的**。

创建 、显示子资源时需要父资源来作所属关系，在编辑、删除子资源时是完全可以脱离父资源，尤其是在统一管理子资源时(个人需求，不知道这样合不合理)，显示特别怪异，套用原来的路由配置是需要通过子资源调用出它的父资源才能编辑、更新子资源本身。

为了让子资源脱离父资源的束缚，可以使用**shallow**

    resources :magazines do
      resources :ads, shallow: true
    end
    
    #等价于
    #resources :magazines do
    #  resources :ads, only: [:index, :new, :create]
    #end
    #resources :ads, only: [:show, :edit, :update, :destroy]
    
    #生成的对应name helper
    
    #    magazine_ads GET    /magazines/:magazine_id/ads(.:format)                ads#index
    #                 POST   /magazines/:magazine_id/ads(.:format)                ads#create
    # new_magazine_ad GET    /magazines/:magazine_id/ads/new(.:format)            ads#new
    #         edit_ad GET    /ads/:id/edit(.:format)                              ads#edit
    #              ad GET    /ads/:id(.:format)                                   ads#show
    #                 PUT    /ads/:id(.:format)                                   ads#update
    #                 DELETE /ads/:id(.:format)                                   ads#destroy
    #       magazines GET    /magazines(.:format)                                 magazines#index
    #                 POST   /magazines(.:format)                                 magazines#create
    #    new_magazine GET    /magazines/new(.:format)                             magazines#new
    #   edit_magazine GET    /magazines/:id/edit(.:format)                        magazines#edit
    #        magazine GET    /magazines/:id(.:format)                             magazines#show
    #                 PUT    /magazines/:id(.:format)                             magazines#update
    #                 DELETE /magazines/:id(.:format)                             magazines#destroy
                             
    #其他写法
    
    resources :magazines, shallow: true do
      resources :ads
    end
    
    shallow do
      resources :magazines do
        resources :ads
      end
    end

使用shadow还可指定url链接前缀、name helper方法名前缀。

+ 指定url链接前缀/edm

    scope shallow_path: "edm" do
      resources :magazines do
        resources :ads, shallow: true
      end
    end
    
    #生成的对应name helper
    
    #    magazine_ads GET    /magazines/:magazine_id/ads(.:format)                ads#index
    #                 POST   /magazines/:magazine_id/ads(.:format)                ads#create
    # new_magazine_ad GET    /magazines/:magazine_id/ads/new(.:format)            ads#new
    #         edit_ad GET    /edm/ads/:id/edit(.:format)                          ads#edit
    #              ad GET    /edm/ads/:id(.:format)                               ads#show
    #                 PUT    /edm/ads/:id(.:format)                               ads#update
    #                 DELETE /edm/ads/:id(.:format)                               ads#destroy
    #       magazines GET    /magazines(.:format)                                 magazines#index
    #                 POST   /magazines(.:format)                                 magazines#create
    #    new_magazine GET    /magazines/new(.:format)                             magazines#new
    #   edit_magazine GET    /magazines/:id/edit(.:format)                        magazines#edit
    #        magazine GET    /magazines/:id(.:format)                             magazines#show
    #                 PUT    /magazines/:id(.:format)                             magazines#update
    #                 DELETE /magazines/:id(.:format)                             magazines#destroy

+ 指定name helper路径的前缀

    scope shallow_prefix: "edm" do
      resources :magazines do
        resources :ads, shallow: true
      end
    end
    
    #生成的对应name helper
    
    #    magazine_ads GET    /magazines/:magazine_id/ads(.:format)                ads#index
    #                 POST   /magazines/:magazine_id/ads(.:format)                ads#create
    # new_magazine_ad GET    /magazines/:magazine_id/ads/new(.:format)            ads#new
    #     edit_edm_ad GET    /ads/:id/edit(.:format)                              ads#edit
    #          edm_ad GET    /ads/:id(.:format)                                   ads#show
    #                 PUT    /ads/:id(.:format)                                   ads#update
    #                 DELETE /ads/:id(.:format)                                   ads#destroy
    #       magazines GET    /magazines(.:format)                                 magazines#index
    #                 POST   /magazines(.:format)                                 magazines#create
    #    new_magazine GET    /magazines/new(.:format)                             magazines#new
    #   edit_magazine GET    /magazines/:id/edit(.:format)                        magazines#edit
    #        magazine GET    /magazines/:id(.:format)                             magazines#show
    #                 PUT    /magazines/:id(.:format)                             magazines#update
    #                 DELETE /magazines/:id(.:format)                             magazines#destroy

## 参考

[Rails Routing from the Outside In](http://guides.rubyonrails.org/routing.html)
