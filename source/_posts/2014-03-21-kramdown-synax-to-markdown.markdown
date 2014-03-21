---
layout: post
title: "kramdown代码语法转换成markdown"
date: 2014-03-21 16:33:12 -0400
comments: true
categories: kramdown,markdown
---


kramdown是个转换mardown语法ruby gem,在kramdown界定代码的标签是`~~~~ ruby`,而目前知道octopress识别的代码语法是每行有四个空格，于是把原来的写东西放到octopress里就需要转换一上。

kramdown代码语法是这样:

    ~~~~ ruby
      def ruby_method
        do something
      end
    ~~~~

需要做的就是正则匹配出代码，把规则换成octopress的markdown语法。

语法转换的脚本代码如下:

    FENCED_CODEBLOCK_MATCH = /^(~{3,})\s*?(\w+)?\s*?\n(.*?)^\1~*\s*?\n/m

    def kramdown_to_markdown(content)
      while content =~ FENCED_CODEBLOCK_MATCH
        lines = $&.split("\n")
        lines.delete_at(0)
        lines.delete_at(lines.size-1)

        newstr = ""
        lines.each do |line|
          newstr << "    " + line +"\n"
        end
        content.gsub!(match,newstr)
      end
      content
    end

    Dir.foreach("/home/tools/segments").each do |file|
      next unless file =~ /\.markdown$/
      puts file
      content = IO.readlines(file).join
      File.open(file,"w") do |f|
        f.puts kramdown_to_markdown(content)
      end
    end
