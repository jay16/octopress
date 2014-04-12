---
layout: post
title: ruby 中的dollar - $
date: 2013-09-09 15:47:22
comments: true
categories: [ruby]
---
## 正则匹配三剑客

**说明**

正则匹配式中的保留关键符号: `.`, `|`, `(`, `)`, `[`, `]`, `{`, `}`, `+`, `\`, `^`, `$`, `*`, and `?`

### &#36;&#91;&#180;,&#38;,&#39;&#93;

> `$&` receives the part of the string that was matched by the pattern, [&#36;&#180;] receives the part of the string thatpreceded the match, and `$'` receives the string after the match


###  &#36;[&#126;,1 - 9]

> The variable `$~ `is a MatchData object  that holds everything you
may want to know about the match. `$1`, and so on, hold the values of parts of the match.


    [root@allentest script]# cat dollar.rb 
    "ruby $ learning" =~ /(\$)/
    puts "#{$`}<<#{$&}>>#{$'}"
    puts $~
    [root@allentest script]# ruby dollar.rb 
    ruby <<$>> learning
    $
