---
layout: post
title: "kramdown代码语法转换成markdown"
date: 2014-03-21 16:33:12 -0400
comments: true
categories: [ruby,octopress,markdown,kramdown]
---


kramdown是个转换mardown语法的ruby gem,在kramdown语法中判断代码的标签是`~~~~ ruby`,而目前知道octopress识别的代码语法是每行有四个空格，于是把原来的写东西放到octopress里就需要转换一上。

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
        lines = $&.split("\n") # $&:匹配项
        lines.delete_at(0)
        lines.delete_at(lines.size-1)

        newstr = lines.map { |l| "    " + l + "\n" }.join
        content.gsub!($&,newstr)
      end
      content
    end

    Dir.foreach("/home/tools/segments").each do |file|
      next unless file =~ /\.markdown$/ #非markdown文档路过

      puts file
      content   = IO.readlines(file).join
      converter = kramdown_to_markdown(content)
      File.open(file,"w") { |f| f.puts converter }
    end

把转换好markdown格式的文章放到`/yourroute/octopress/source/_posts/`目录下，执行octopress命令`bundle exec rake generate`,文章就添加到octopress文章列表中了。

如果文章已经存在，只是更新文章而已则使用命令`bundle exec rake update_source`,则会更新octopress文章列表，同时会生成 source.old文件夹，可忽略。同时带一下，如果更新了octopress样式或图片，可以使用命令`bundle exec rake update_style`来刷新样式。
