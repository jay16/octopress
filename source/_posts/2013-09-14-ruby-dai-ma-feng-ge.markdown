---
layout: post
title: ruby 代码风格
date: 2013-09-14 09:57:07
comments: true
categories: Ruby
---
## 源代码风格

> 几乎每个人都坚信除了他们自己的书写风格外其他书写风格都是丑陋并且不易阅读的。把[除了他们自己的书写风格]字眼拿去，这种说法应该是正确的....

> -- Jerry Coffin (论代码缩排)

+ 1.源代码文件编码格式设置为 `UTF-8`。

+ 2.在**缩进**时,使用**两个空格**. **鼓励不使用`tab`**(应该是因为不同编辑器设置的`tab`代表4或8个空格,会很被动)

    # 不推荐 - 使用4个空格或tab
    def some_method
        do_something
    end
    
    # 鼓励 - 使用两个空格
    def some_method
      do_something
    end
    
    
+ 3.使用类Unix风格换行符 (BSD/Solaris/Linux/OSX系统会自动转换, Windows users用户需要额外注意.)

  如果你使用`Git`,你可以在配置档设置上添加下面一行代码来避免你项目中使用`windows`换行号


     $ git config --global core.autocrlf true

+ 4.不推荐在一行代码中使用`;`来分隔声明代码或静态式代码.鼓励**一行代码写一个表达式**。

    # 不推荐 - 下面两种用法 
    # 1.此处的分号;显示得多余
    puts 'foobar'; 
    
    # 2.一行代码中使用`;`来分隔声明代码或静态式代码
    puts 'foo'; puts 'bar' 
    
    # 鼓励 - 一行代码写一个表达式
    puts 'foobar'
    
    puts 'foo'
    puts 'bar'
    
    # 特殊情况下可以这样写
    puts 'foo', 'bar'

+ 5.在定义**空**`class`时鼓励写成**单行格式**。


    # 不推荐
    class FooError < StandardError
    end
    
    # 一般
    class FooError < StandardError; end
    
    # 鼓励
    FooError = Class.new(StandardError)

+ 6.应避免把`method`定义代码写成**单行格式**。

    # 不推荐 - 把method定义代码写成单行格式
    def too_much; something; something_else; end
    
    # okish - notice that the first ; is required
    def no_braces_method; body end
    
    # okish - notice that the second ; is optional
    def no_braces_method; body; end
    
    # okish - valid syntax, but no ; make it kind of hard to read
    def some_method() body end
    
    # good
    def some_method
      body
    end

**定义空方法时**例外

    # 鼓励 - 定义空方法时写成单行格式
    def no_op; end

+ 7.在逗号`,`、分号`;`、冒号`:`等运算符号**后面**留一个空格、左中括号`{`**前后**各留一个空格、右中括号`}`**前**留下一个空格。

    sum = 1 + 2
    a, b = 1, 2
    1 > 2 ? true : false; puts 'Hi'
    [1, 2, 3].each { |e| puts e }

**唯一例外**:指数符号`**`前后不需要空格

    # 不推荐
    e = M * c ** 2
    
    # 鼓励 - 指数符号**前后不需要空格
    e = M * c**2

**特殊说明**：

左中括号`{`，右中括号`}`需要特殊说明一下,由于它们经常使用在**块**`block`与**哈希**`hash`遍历,还有在字符串`string`中嵌套表达式。对于哈希`hash`有两种表现方式都可以接受


    # 鼓励 - 在{后}前各留空格
    { one: 1, two: 2 }
    
    # 同要鼓励- 在{后}前不留空格
    {one: 1, two: 2}

至于**嵌套表达式**,有两种可以接受的方式：

第一种变量的写法在Ruby社区很受欢迎，第二种写法阅读性更好。

    # 鼓励 - 不使用空格
    "string#{expr}"
    
    # 一般 - 也许这样写阅读性更可好
    "string#{ expr }"

在运算符号`(`, `[`**后面**或在运算符号`]`, `)`**前面**不使用**空格**

    some(arg).other
    [1, 2, 3].length
   
`when`与`case`相同缩进对齐。

    case
    when song.name == 'Misty'
      puts 'Not again!'
    when song.duration > 120
      puts 'Too long!'
    when Time.now.hour > 21
      puts "It's too late"
    else
      song.play
    end
    
    kind = case year
           when 1850..1889 then 'Blues'
           when 1890..1909 then 'Ragtime'
           when 1910..1929 then 'New Orleans Jazz'
           when 1930..1939 then 'Swing'
           when 1940..1950 then 'Bebop'
           else 'Jazz'
           end

使用**空格**分隔定义方法`def`及方法中逻辑代码段。

    def some_method
      data = initialize(options)
    
      data.manipulate!
    
      data.result
    end
    
    def some_method
      result
    end

在方法`method`参数`parameters`设置默认值时的赋值符号`=`前后各留一空格。

    # 不推荐
    def some_method(arg1=:default, arg2=nil, arg3=[])
      # do something...
    end
    
    # 鼓励
    def some_method(arg1 = :default, arg2 = nil, arg3 = [])
      # do something...
    end

避免在不必要时使用断行符号`\`，在实践中,除了在**字符串拼接**时使用断行符号，其他情况都不推荐。
    
    # 不推荐
    result = 1 - \
             2
    
    # 鼓励 (看起来同样很丑陋)
    result = 1 \
             - 2
    
    long_string = 'First part of the long string' \
                  ' and second part of the long string'

若调用**方法**链时换行,需要保留`.`在第二行

    # 不推荐 - 需要查看了第一行代码才明白第二行代码什么意思
    one.two.three.
      four
    
    # 鼓励 - 一目了然第二行的意思
    one.two.three
      .four

如果调用方法的参数出现在多行，则将它们相同缩进对齐;由于行宽的限制而调整参数前后的空格是不可以合适的，参数每行代码使用一个缩进是可以接受的。

    # 不推荐 - 一目了然 (行太长了)
    def send_mail(source)
      Mailer.deliver(to: 'bob@example.com', from: 'us@example.com', subject: 'Important message', body: source.text)
    end
    
    # 不推荐 - 双缩进
    def send_mail(source)
      Mailer.deliver(
          to: 'bob@example.com',
          from: 'us@example.com',
          subject: 'Important message',
          body: source.text)
    end
    
    # 鼓励 - 与第一个参数对齐
    def send_mail(source)
      Mailer.deliver(to: 'bob@example.com',
                     from: 'us@example.com',
                     subject: 'Important message',
                     body: source.text)
    end
    
    # 鼓励 - 正常缩进
    def send_mail(source)
      Mailer.deliver(
        to: 'bob@example.com',
        from: 'us@example.com',
        subject: 'Important message',
        body: source.text
      )
    end

大数字使用下划线`_`分隔改善阅读性。   
    
    # 不推荐 - 满眼的0
    num = 1000000
    
    # 鼓励 - 便于阅读
    num = 1_000_000

在ruby文档及相关的API文档中，不在注释行与定义方法`def`行之间留空行。

1. 每行字符数量限制在80个以内。
2. 避免在行尾留空格
3. 不要使用块注释`block comments`

    # 不推荐
    == begin
    comment line
    another comment line
    == end
    
    # 鼓励
    # comment line
    # another comment line

## 翻译&参考

1. [Ruby Style Guide](https://github.com/bbatsov/ruby-style-guide)
2. [Ruby&Rails风格指导](http://stylesror.github.io/)
