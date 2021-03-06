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

***

在下班的路上，又想到了自己的这种不作为行为，因为自己懂得了一点皮毛知识，掌握了常用的或很笨的实现方法，就放弃了对更高效或更便捷实现方法的追求。

最终明白了其中的原因，那就是畏惧！学习知识的过程也算是驾驭知识的过程。学习的很顺利，所有需求可以信手拈来把所学知识运用其中，那说明你学习、理解能力强，驾驭知识的能力强，则会越学越有信心越有想学更多知识的冲动和欲望，是一种良性循环；反之，学习受阻，理不清，弄不明，对这一部分知识的定位也很模糊，不知道应该在什么情况下使用它，或用它会有什么样的未知结果，这时就会对这部分知识产生畏惧，在能找到自己信得过的实现方法时决不会使用它。

拿上面的代码来解释，正则匹配，顾名思义，是一种模糊匹配，虽然它实现了对空格的匹配，但不止对空格有效，在ruby中的定义是对空格、制表符、回车、换行等符号匹配。

>  /\s/ - A whitespace character: /[ \t\r\n\f]/

如果你仅仅是想对字符串的空格进行替换，而对换行符等保存不变，则上面的正则匹配方法会出现误伤。


``` ruby irb
irb(main):001:0> "a   \nb   \nc    ".gsub(/\s+/," ")
=> "a b c "
irb(main):002:0> "a   \nb   \nc\t\n\f".gsub(/\s+/," ")
=> "a b c "
```

所以首先要理解清楚自己的需求是什么，然后就是自己要对知识精益求精，才能找到最合适的方法恰到好处的实现自己的需求。


***

补充一下ruby中split的用法：

``` ruby irb
irb(main):001:0> str="hello,world,,,"
=> "hello,world,,,"
irb(main):002:0> str.split(",")
=> ["hello", "world"]
irb(main):003:0> str.split(",",-1)
=> ["hello", "world", "", "", “"]
```
