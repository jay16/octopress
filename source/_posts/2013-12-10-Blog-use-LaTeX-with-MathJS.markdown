---
layout: post
title: 博文中写公式 - LaTeX & MathJS
date: 2013-12-10 12:36:06
comments: true
categories: [kramdown,java,html]
---
## 使用方法

在网页添加下面`js`代码：

    <!-- mathjax config similar to math.stackexchange -->
    <script type="text/x-mathjax-config">
      MathJax.Hub.Config({
        tex2jax: {
          inlineMath: [ ['$','$'], ["\(","\)"] ],
          processEscapes: true
        }
      });
    </script>
    
    <script type="text/x-mathjax-config">
        MathJax.Hub.Config({
          tex2jax: {
            skipTags: ['script', 'noscript', 'style', 'textarea', 'pre', 'code']
          }
        });
    </script>
    
    <script type="text/x-mathjax-config">
        MathJax.Hub.Queue(function() {
            var all = MathJax.Hub.getAllJax(), i;
            for(i=0; i < all.length; i += 1) {
                all[i].SourceElement().parentNode.className += ' has-jax';
            }
        });
    </script>
    
    <script type="text/javascript"
       src="http://cdn.mathjax.org/mathjax/latest/MathJax.js?config=TeX-AMS-MML_HTMLorMML">
    </script>
    

在文章中使用`latex`语法写入公式代码:

    $$
    \begin{align*}
      & \phi(x,y) = \phi \left(\sum_{i=1}^n x_ie_i, \sum_{j=1}^n y_je_j \right)
      = \sum_{i=1}^n \sum_{j=1}^n x_i y_j \phi(e_i, e_j) = \
      & (x_1, \ldots, x_n) \left( \begin{array}{ccc}
          \phi(e_1, e_1) & \cdots & \phi(e_1, e_n) \
          \vdots & \ddots & \vdots \
          \phi(e_n, e_1) & \cdots & \phi(e_n, e_n)
        \end{array} \right)
      \left( \begin{array}{c}
          y_1 \
          \vdots \
          y_n
        \end{array} \right)
    \end{align*}
    $$

测试的最简单方法就是把上面代码直贴到`html`文件中,使用浏览器打开就会看到效果。

## 网页效果

$$
\begin{align*}
  & \phi(x,y) = \phi \left(\sum_{i=1}^n x_ie_i, \sum_{j=1}^n y_je_j \right)
  = \sum_{i=1}^n \sum_{j=1}^n x_i y_j \phi(e_i, e_j) = \\
  & (x_1, \ldots, x_n) \left( \begin{array}{ccc}
      \phi(e_1, e_1) & \cdots & \phi(e_1, e_n) \\
      \vdots & \ddots & \vdots \\
      \phi(e_n, e_1) & \cdots & \phi(e_n, e_n)
    \end{array} \right)
  \left( \begin{array}{c}
      y_1 \\
      \vdots \\
      y_n
    \end{array} \right)
\end{align*}
$$

## 参考

1. [MathJax官方网站](http://www.mathjax.org/)
2. [Kramdown & LatTeX](http://kramdown.gettalong.org/syntax.html#extensions)
