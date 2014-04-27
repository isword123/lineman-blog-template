在 Objective-C 里，有一些方法会返回 id 类型，有些方法会返回 instancetype，但是用起来的时候，基本没有区别，那它们之间到底有何区别呢？

#### id
在 Objective-C 中， id 表示类类型，可以表示类，也可以表示某个类的实例。
<br />

#### 相关结果类型（Related Result Types）
根据 Cocoa 的转换规则，带有特殊名字（像 alloc, init）的 Objective-C 的方法会返回消息接受者类的实例，我们就称这样的方法具有**相关结果类型**，意味着消息接受者是具有相同的类的实例的静态类型（应该是说，消息接受者都是同一个类的实例）。  

在方法的名称中的第一个字满足以下条件时，方法默认会具有*相关结果类型*  
* 第一个字是 alloc 或者 init，而且该方法是一个类方法
* 第一个字是 init, retain, autorelease 或者 self，而且该方法是一个实例方法

相关结果类型只会影响到消息发送和或者通过给定方法访问的属性的类型，其他使用 id 定义的返回类型仍然被认做是 id 类型。   
<br />

#### instancetype 和 id 使用建议
* 对于类构造方法，建议使用 instancetype，因为事实上这种方法跟 init 很像，都是创建了一个新的实例
* 在可以用 instancetype 的地方，尽量使用 instancetype。
<br />

#### 尽量都使用 instancetype的好处
* 显式，或者说明显，代码描述的就是其本来的样子
* 模式，或者说保持了良好的习惯
* 保持一致，代码看起来更清晰

所以在定义返回类型为 id 时，先想想可不可以用 instancetype。
<br />

#### 例子
对于以下两种使用方式
    
    [[[NSArray alloc] init] mediaPlaybackAllowsAirPlay]; // (Error)

    [[NSArray array] mediaPlaybackAllowsAirPlay]; // (No error)

第一种方法会报错，而第二种不会，这里的前提是`NSArray`并没有`mediaPlaybackAllowsAirPlay`这个方法  
但是第一种由于返回了`NSArray`的实例，而在`NSArray`的方法表中并没有找到相关的方法，所以，报错。  
而第二种，只是被认为是`id`类型，然后在全局的方法表中可以找到`mediaPlaybackAllowsAirPlay`这个方法，所以，不报错。  
<br />

#### 总结
简单来看，instancetype 是 id 的一种子集表示，可以限定方法的返回类型，避免出错；在可以使用 instancetype 的地方，尽量使用，有很多好处...
<br />

#### 引用
>
> [Stakoveflow](http://stackoverflow.com/a/14652187/1847934)  
> [CLang language extensions](http://clang.llvm.org/docs/LanguageExtensions.html#related-result-types)  
> [instancetype](http://nshipster.com/instancetype/)  
<br />

#### Further Reading
> [Typed collections with self types](http://www.jonmsterling.com/posts/2012-02-05-typed-collections-with-self-types-in-objective-c.html)
