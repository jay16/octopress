---
layout: post
title: "ruby中的星号*"
date: 2014-04-06 14:03:14 +0800
comments: true
categories: ruby
---


1. 乘法功能

``` ruby 乘法功能
  3 * 4 = => 12  # => true
```

2. Array * Integer

``` ruby
  [1,2,[3,[4,5]]] * 2 # => [1,2,[3,[4,5]],1,2,[3,[4,5]]]
```

3. String * Integer

``` ruby
  "hello" * 2 # => "hellohello"
```

4. Array作为参数传入时的前缀

``` ruby
  a = [1, 2]
  testFun(*a) == testFun(1, 2)  != testFun([1,2])
```

``` ruby irb
2.0.0-p451 :001 > Hash[:a,1,:b,2]
 => {:a=>1, :b=>2}
2.0.0-p451 :002 > array = [:a,1,:b,2]
 => [:a, 1, :b, 2]
2.0.0-p451 :003 > Hash[array]
 => {}
2.0.0-p451 :004 > Hash[*array]
 => {:a=>1, :b=>2}
2.0.0-p451 :005 >
```

``` ruby https://github.com/resque/redis-namespace/blob/master/lib/redis/namespace.rb#L412

  case key
  when Array
    key.map {|k| rem_namespace k}
  when Hash
    Hash[*key.map {|k, v| [ rem_namespace(k), v ]}.flatten]
  ….
# => array = key.map {|k, v| [ rem_namespace(k), v ]}.flatten
# => Hash[*array]
```

### 参考

1. [ruby 中星号（*）的作用](http://www.cxyclub.cn/n/34536/)
