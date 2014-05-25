### 关于 white-space 的学习笔记
看完之后，不再那么迷糊，但是有些地方，还是不太了解

`white-space` 决定了两个内容：
* 在元素内的空白格是否要折叠，以及如何折叠
* 行是否会在非受迫性软换行条件下换行

(软换行条件：指只允许在一个被允许的断点处进行换行） 
强制换行：由于明显的换行控制或者一个区块的开始和结束而导致的换行
  
<br />
#### white-space的属性：
* `normal`: 会在软换行条件下换行，会折叠一连串的空格为单个空格
* `pre`: 不会折叠任何空格，但是会发生强制换行
* `nowrap`: 会折叠空格，但是不会换行
* `pre-wrap`: 会保留空格，但是允许换行
* `pre-line`: 会折叠连续的空格，允许换行，但是会保留源里的区块断点作为强制换行

<br />
#### 属性行为的总结列表
```
              New Lines   Spaces and Tabs Text Wrapping
    normal    Collapse    Collapse    Wrap
    pre       Preserve    Preserve    No wrap
    nowrap    Collapse    Collapse    No wrap
    pre-wrap  Preserve    Preserve    Wrap
    pre-line  Preserve    Collapse    Wrap
```

<br />
#### 折叠空格的额外总结
*  连续的区块断点和连个中文，日文，Yi文字之间的的其他空格不会折叠（不懂这个区块断点指的是什么）
*  一个包含了区块断点的连续空格序列的之前或之后的零宽度的空间会导致整个空格序列折叠成为一个零宽度的空间
*  否则，连续的空格会折叠成一个单独的空格

  
<br />
#### 空格处理的细节
Segments could be separated by a particular newline seqence (such as a line feed or CRLF pair), or delimited by some other mechanism  

CRLF sequence (U+000D U+000A), carriage return (U+000D), and line feed (U+000A) in the text is treated as a segment break  

Control characters (Unicode class Cc) other than tab (U+0009), line feed (U+000A), and carriage return (U+000D) are ignored for the purpose of rendering.  

(line feed: 换行)  


<br />
#### 空格处理的规则
只处理 spaces (U+0020), tabs (U+0009), and segment breaks  

##### 第一阶段：折叠和变换

当 'white-space' 的属性设置为 'normal | nowrap | pre-line' 时，空格字符会被折叠，处理的步骤如下：

* 直接在区块断点前面或者跟在区块断点后面的所有空格和 tab 会被移除
* 区块断点会按照区块断点的转换规则被转换，然后用来渲染
* 每个 tab 会被转换成一个空格 (U+0020)
* 任何直接跟在另一个可被折叠的的空格后的空格，就算包含在该内联空间的边界之外，只要它们同时在同一行内格式化上下文中，就会被折叠成只有超过零的宽度（不可见，但是保留了软换行条件）
  
如果 'white-space' 被设置为 'pre-wrap'，则所有空格序列都会被看成不可折断的空格，但是在序列的末尾保留着软换行条件
  
然后，整个区块会被渲染，在考虑了双向性的前提下内联被布局，然后根据 'white-space' 的属性来进行换行处理  

##### 区块断点的转换规则
  
当 'white-space' 的属性被设置为 'pre | pre-wrap | pre-line' 时，区块断点不会被折叠，反而，它们会被转换成保留的换行符 (U+000A)

对于其他 'white-space' 的值，区块断点会被折叠，不是转换成空格 (U+0020) 就是被移除掉，取决于它们的上下文

* 如果在区块断点直接之前或直接之后的是零宽度的空格字符 (U+200B)，则区域断点会被移除，只剩下零宽度的空格  
* 否则， if the East Asian Width property [UAX11] of both the character before and after the line feed is F, W, or H (not A), and neither side is Hangul，就会吧区块断点移除
* 再否则，区块断点会被转换成一个空格 (U+0020)
  
需要注意的是在上面的步骤发生之前，空格处理规则已经将区块断点之后的 tab 和空格都移除掉了

##### 第二阶段，截断和定位

当每一行都被布局了之后，

* 每一行最开始的可折叠空格序列被移除  
* Each tab is rendered as a horizontal shift that lines up the start edge of the next glyph with the next tab stop  
* 每一行最后的可折叠空格序列被移除  
* 如果行尾的 tab 或者空格不是可折叠的，但是 'white-space' 的属性被设置为了 'pre-wrap'，the UA may visually collapse their character advance widths  

在空格处理步骤没有移除或者折叠的空格被称作**保留空格**

##### 引用
> [Quiksmode](http://quirksmode.org/css/text/whitespace.html "quiks mode")  
> [W3C CSS Text](http://www.w3.org/TR/css3-text/)

