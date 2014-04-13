---
layout: post
title: "24条JavaScript最佳实践"
date: 2014-04-13 12:24:56 +0800
comments: true
categories: [jquery,js]
---

1.使用`===`代替`==`

JavaScript有两种不同的比较操作符：`===` `!==`与`==` `!=`,推荐前者。

> "如果使用这两种操作符比较两个相同类型与数值的结果，`===`肯定返回true,`!==`返回false.” 
> - JavaScript: 精华部分

然而，当你使用`==`与`!=`来比较不同类型的对象时，会带来很多不便。不幸的是，在这些情况下，你必须强制转换它们的类型。

2.避免使用`eval`

对于不是很熟悉JavaScript的开发者，`evel`函数给我们提供途径可以直接访问JavaScript编译器。毫无疑问，我们可以执行任何字符串，通过把它作为参数传递给`evel`函数。

这样做，不仅会极大的降低脚本的执行效果，而且它可能带来巨大的安全风险，因为它赋予了太多权力对传入的文本。避免使用它 ！

3.不要使用缩写

从技术层面上，你可以避免使用大量的大括号与分号。大多数浏览器也会正确的解释下面的脚本代码：

``` javascript
if(someVariableExists)
   x =false
```

但是，考虑一下如下代码：

``` javascript
if(someVariableExists)
   x =false
   anotherFunctionCall();
```

如果你认为上面的代码等价下面代码：

``` javascript
if(someVariableExists) {
   x =false;
   anotherFunctionCall();
}
```

很抱歉的告诉你，你错了，实际上它相当于：

``` javascript
if(someVariableExists) {
   x =false;
}
anotherFunctionCall();
```

不要试图通过缩进的方式来省去写大括号的麻烦。唯一推荐省略大括号的情况是，代码只有一行：

``` javascript
if(2 + 2 === 4)return'nicely done';
```

4.充分利用[JS Lint](http://www.jslint.com/)

JSLint 是Douglas Crockford编写的一款JavaScript调度器. 只需要粘贴你的源代码，它就会快速分析你的代码，告诉你代码是否有总是。

> "JSLint takes a JavaScript source and scans it. If it finds a problem, it returns a message describing the problem and an approximate location within the source. The problem is not necessarily a syntax error, although it often is. JSLint looks at some style conventions as well as structural problems. It does not prove that your program is correct. It just provides another set of eyes to help spot problems." 
> - JSLint 文档

提交代码前，在JSLint中运行一下，它会告诉你是否有犯那些低级无意识的编程错误。

5.把脚本代码放在见面底部

主要目的就让网页加载速度更快，用户体验更好。

浏览器的渲染网页的顺序是html代码的先后顺序，网页上的可视化交互控件不会在前面的js文件加载完成前显示，如果你的js文件功能都是页面上按钮的点击功能时，推荐把它们放在最后加载。

6.在`for`循环外面声明变量

``` javascript
// Bad
for(vari = 0; i < someArray.length; i++) {
   varcontainer = document.getElementById('container');
   container.innerHtml +='my number: '+ i;
   console.log(i);
}

// Better
varcontainer = document.getElementById('container');
for(vari = 0, len = someArray.length; i < len;  i++) {
   container.innerHtml +='my number: '+ i;
   console.log(i);
}
```

7.快速生成字符串

``` javascript
vararr = ['item 1','item 2','item 3', ...];
varlist ='<ul><li>'+ arr.join('</li><li>') +'</li></ul>’;
```
8.少用全局变量

``` javascript
// Bad
varname ='Jeffrey';
varlastName ='Way';
functiondoSomething() {...}
console.log(name);// Jeffrey -- or window.nameBetter

// Better
varDudeNameSpace = {
   name :'Jeffrey',
   lastName :'Way',
   doSomething :function() {...}
}
console.log(DudeNameSpace.name);// Jeffrey
```

9.勤写注释

``` javascript
// Cycle through array and echo out each name.
for(vari = 0, len = array.length; i < len; i++) {
   console.log(array[i]);
}
```

10.Embrace Progressive Enhancement

Always compensate for when JavaScript is disabled. It might be tempting to think, "The majority of my viewers have JavaScript enabled, so I won't worry about it." However, this would be a huge mistake.
Have you taken a moment to view your beautiful slider with JavaScript turned off? (Download the Web Developer Toolbar for an easy way to do so.) It might break your site completely. As a rule of thumb, design your site assuming that JavaScript will be disabled. Then, once you've done so, begin to progressively enhance your layout!

11.在`SetInterval`或`SetTimeOut`中不要传递字符串

考虑下面代码:

``` javascript
setInterval(
"document.getElementById('container').innerHTML += 'My new number: ' + i", 3000
);
```

上述代码不仅无效，而且它的执行隐患与`evel`函数相同。绝对不要向`SetInterval`或`SetTimeOut`传递字符串，应该传递函数名。

``` javascript
setInterval(someFunction, 3000);
```

12.不要使用`with`声明

刚看到`with`声明时，感觉使用它很明智。它的基本理念是为访问嵌套很深的对象提供了简写。

``` javascript
with(being.person.man.bodyparts) {
   arms =true;
   legs =true;
}

// 等价于

being.person.man.bodyparts.arms =true;
being.person.man.bodyparts.legs=true;
```

不爽的是，经过很多测试，发现在`with`声明中添加新成员会出现很多问题，取而代之的是使用下述代码：

``` javascript
varo = being.person.man.bodyparts;
o.arms =true;
o.legs =true;
```

13.` {}`取代`New Object()`

在JavaScrip中有很多方式来创建对象，也许最传统的方式是使用`new`构建，像下面代码：

``` javascript
varo =newObject();
o.name ='Jeffrey';
o.lastName ='Way';
o.someFunction =function() {
   console.log(this.name);
}
```

然后，这种创建对象方式实践起来很差，推荐使用更可靠的方法。

``` javascript
// Better
varo = {
   name:'Jeffrey',
   lastName ='Way',
   someFunction :function() {
      console.log(this.name);
   }
};
```

请注意你是否仅仅想创建一个空对象，`{}`来实现它恰到好处。

``` javascript
varo = {};
```
> "Objects literals enable us to write code that supports lots of features yet still make it a relatively straightforward for the implementers of our code. No need to invoke constructors directly or maintain the correct order of arguments passed to functions, etc." -dyn-web.com

14.`[]`代替`New Array()`

``` javascript
// Okay
vara =newArray();
a[0] ="Joe";
a[1] ='Plumber';

// Better
vara = ['Joe','Plumber'];
```

> "A common error in JavaScript programs is to use an object when an array is required or an array when an object is required. The rule is simple: when the property names are small sequential integers, you should use an array. Otherwise, use an object." - Douglas Crockford15. 变量的列表长吗？

``` javascript
// Bad
varsomeItem ='some string';
varanotherItem ='another string';
varoneMoreItem ='one more string';

// Better
varsomeItem ='some string',
anotherItem ='another string',
oneMoreItem ='one more string';
```

效果是显而易见的。我怀疑它是否会真的改善执行速度，但真的使你的代码清爽了许多。

17.多使用分号`;`

``` javascript
// Bad
varsomeItem ='some string'
functiondoSomething() {
  return'something'
}

// Better
varsomeItem ='some string';
functiondoSomething() {
  return'something';
}
```

18.`For in`声明

当你筛选一个对象的属性时，同时也会遍历出来它的函数。为了更好的实现需求，使用`if`来过滤出来自己想要的信息。

``` javascript
for(keyinobject) {
   if(object.hasOwnProperty(key) {
      ...thendosomething...
   }
}
```

19.使用Firebug的"Timer” 优化代码 

需要一个快速和容易的方法来测试代码执行的效率吗？使用 Firebug 的 "计时器" 功能。

``` javascript
functionTimeTracker(){
 console.time("MyTimer");
 for(x=5000; x > 0; x--){}
 console.timeEnd("MyTimer");
}
```

20.阅读优秀的代码

   * [Object-Oriented JavaScript](http://www.packtpub.com/object-oriented-javascript-applications-libraries/book)
   * [JavaScript: The Good Parts](http://oreilly.com/catalog/9780596517748/)
   * [Learning jQuery 1.3](http://code.tutsplus.com/tutorials/www.packtpub.com/learning-jquery-1.3/boo)
   * [Learning JavaScript](http://oreilly.com/catalog/9780596527464/)

21.Self-Executing Functions

不需要通过调用来执行一个函数，可以通过非常简单的方式来实现：当网页加载完成时让函数自动执行，或它的父函数被调用。

只需要把你的函数包裹一层括号，再在函数后面追加一对括号。

``` javascript
(functiondoSomething() {
   return{
      name:'jeff',
      lastName:'way'
   };
})();
```

22.JavaScript原生代码比调用库函数执行速度更快

JavaScript库，如jQuery和Mootools,可以节省大量的时间,特别是与AJAX操作进行编码时.话虽如此,始终牢记,函数库中的代码永远不可能与JavaScript原生代码执行一样快（假设你的代码正确）。

jQuery 的each方法是非常棒的循环，但相比较使用for循环的执行速度而言则有些逊色。

23.Crockford's JSON.Parse

``` javascript
varresponse = JSON.parse(xhr.responseText);
 
varcontainer = document.getElementById('container');
for(vari = 0, len = response.length; i < len; i++) {
  container.innerHTML +='<li>'+ response[i].name +' : '+ response[i].email +'</li>';
}
```

24.移除"Language"

几年前，在脚本标签中很常见看到language属性.

``` javascript
<script type="text/javascript"language="javascript"]]>
...
</script>
```

然后，这个属性很久以来就废弃了，所以移除language属性。

### 翻译

[24 JavaScript Best Practices for Beginners](http://code.tutsplus.com/tutorials/24-javascript-best-practices-for-beginners--net-5399)
