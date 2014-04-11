---
layout: post
title: "ruby 元编程一简单实例"
date: 2014-04-06 17:51:12 +0800
comments: true
categories: [ruby]
---


本篇文章通过ruby元编程实现把csv文件映射成一个类，文件中的记录映射成这个类的实例。

csv文件即以逗号分隔的文本文档，默认以第一行的内容作为类的属性。以文中提供的Friends.csv文件为例生成的类则会有属性`name,gender,age,dept`。

``` ruby Friends.csv
name,gender,age,dept.
Li Lei,M,23,edw
Han Mei-mei,F,22,b2b
Jim Green,M,23,TRH
```

传统的实现思路如下:

``` ruby Friends.rb
class Friends
  attr_reader :name, :gender, :age, :dept

  # 类变量@@data用来存储所有记录
  @@data = []

  def initialize name, gender, age, dept
    @name, @gender, @age, @dept = name, gender, age, dept
  end

  def self.find_by_name name
    @@data.select {|data| data.name == name}[0]
  end

  # 填充@@data
  File.open('Friends.csv') do |file|
    file.readline  # Skip fist row
    file.each_line do |line|
      @@data << self.new(*line.chomp.split(','))
    end
  end

end
```

``` ruby Find_Friend.rb
require "./Friends.rb"

lilei = Friends.find_by_name("Li Lei")
puts lilei.dept # => edw
```

上述代码就针对Friens.csv文件生成了一个类，并对其内容进行查询。

如果有很多的csv文件，要手工实现几乎差不多的类，就太无聊了。使用ruby的元编程可以优雅的解决这样的问题，即根据不同csv文件动态生成对应的类。

``` ruby Meta_Friends.rb
#encoding: utf-8
module Tool
  def self.csv2class csv_name
    klass_name = csv_name.downcase.gsub(".csv","").capitalize
    klass = Object.const_set(klass_name, Class.new)

    File.open(csv_name) do |file|
      attributes = file.readline.chomp.split(",")

      klass.class_eval do
        attr_accessor *attributes

        define_method :initialize do |*args|
          attributes.each_with_index do |attribute, i|
            instance_variable_set("@#{attribute}", args[i])
          end
        end

        define_method :to_s do |*args|
          attributes.map { |attribute| attribute + ":" + instance_variable_get("@#{attribute}").to_s }.join(",")
        end

        class_variable_set("@@data", [])

        file.each_line do |line|
          class_variable_get("@@data") << self.new(*line.chomp.split(","))
        end

        meta_class = (class << self; self; end)
        meta_class.class_eval do
          define_method :find_by do |*args|
            class_variable_get("@@data").select { |data| data.instance_variable_get("@#{args[0]}") == args[1] }[0]
          end
        end
      end
    end
  end
end
```

``` ruby Meta.rb
require "./Meta_Friends"

Tool.csv2class "Friends.csv"
new_friend = Friends.new("new friend", "M", 26, "Worker")
puts new_friend.to_s # => name:new friend,gender:M,age:26,dept:Worker

lilei = Friends.find_by(:name, "Li Lei")
puts lilei.to_s  # => name:Li Lei,gender:M,age:23,dept:edw
puts lilei.dept  # => dw
```

### 参考

[Ruby元编程起步 ](http://www.cxyclub.cn/n/15932/)

