---
layout: post
title: "空格引起的思考"
date: 2014-04-11 17:56:58 +0800
comments: true
categories: [ruby]
---



学弟问如何使用正则匹配把一个字符串的多个空格替换为一个。

当前没多想就随手写了一个循环，如果自己碰到这样需求也许就会使用这样的解决方法。

``` ruby irb
irb(main):001:0> str = "a   b    c    e"
=> "a   b    c    e"
irb(main):002:0> while str.include?("  ")
irb(main):003:1>   str.gsub!("  "," ")
irb(main):004:1> end
=> nil
irb(main):005:0> puts str
a b c e
=> nil
```

把代码发给学弟后，感觉这样太罗嗦了，想了一下，就有了逻辑有些罗嗦但代码简洁的实现方法。

``` ruby irb
irb(main):006:0> str = "a   b    c    e"
=> "a   b    c    e"
irb(main):007:0> str.split(" ").join(" ")
=> "a b c e"
```

学弟对我的回复不太满意，强调如何使用正则匹配来实现，我感觉都把问题解决了，何必拘束于使用那种方法，并反驳说正则匹配是用来匹配的，不是用来替换的。

但沉下心里来，明白自己正则匹配的能力有限，能用其他方法实现的情况下就不会去想去正则匹配，但感觉这样的需求很常见，是躲不开的，就尝试着正则匹配的方法。

只尝试了两次结果就出来了....问题不是想像中的那么难，但脑中首先想到就是躲避，但自己又不是那么怕它，这是属于什么惰性？

``` ruby irb
irb(main):001:0> "a  b   c d".split(" ")
=> ["a", "b", "c", "d"]
irb(main):002:0> "a  b   c d".split(" ").join(" ")
=> "a b c d"
irb(main):003:0> "a   b   ".gsub(/\s*/," ")
=> " a  b  "
irb(main):004:0> "a   b   ".gsub(/\s+/," ")
=> "a b "
irb(main):005:0> "a   b   c    d    e".gsub(/\s+/," ")
=> "a b c d e"
```

