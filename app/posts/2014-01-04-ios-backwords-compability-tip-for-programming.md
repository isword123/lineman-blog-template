在使用 iOS 新特性的时候如何保证对老版本的支持呢？以下会介绍在使用 iOS7 新特性的时候如何保持对 iOS6 以及更低版本的支持。

主要包括了通过什么来进行特性检测和保持向后兼容时比较通用的做法。

<br />
#### 首先，你需要使用新的 SDK，即 iOS7 的SDK，并且指定部署目标 

##### 基础的SDK：
* 技术性的基础
* 包含了所有的特性集合
* 会被编译到 APP 的二进制文件里
* 应该是最新的 SDK

##### 部署目标：
* 指定最小需要支持的系统版本

在使用某个特性前，先检查特性是否存在  
<br />

#### 使用新的
* 框架和类
      可选择的框架（设置框架为可选的）(如果涉及到新的标志和新的类，需要在使用前检查该名字或对应的部分是否为空，eg: `if (!kName != nil)`    
* 方法的检查： 
      `respondToSelector`  
* 是否具有某种特性或能力：
      eg: `[MFMailComposeViewController canSendMail]`，有许多检测放在类方法中  
      还有：[CMMotionActivityManager isActivityAvailable]
* 设计
      版本检测， `NSFoundationVersionNumber`  
* 架构
      不同的 `CPU` 对应不同的代码，eg: `#if __LP64__ #else  #endif` （检测是否是 64 位处理器）
<br />

#### 特性检测需要注意的地方

尽量不要到处使用 if else 的检测，否则会导致代码很乱而且比较难维护，尽量把这些检测封装起来，可用的方式有 集群（cluster），数据源（data source），策略 (category）。  

#### 解决方法

* 类集群：指只有一个 `@interface`，但是对应有多个 `@implementation`  

      这种方式在 cocoa 中很常见，可以把特性检测封装在类里，之后也可以很方便地把不需要的代码移除掉  
      (创建一个类方法来获取真正需要的类实例） 

* 数据源： 定义一个实现了某种 delegate（接口）的类，相当与面向接口编程的方式  

* 策略：增加方法到默认的类中或者把特性检测放到某个方法里，相当于重新定义一个类似接口，在接口中做特性检测

      之后可通过 Xcode 的 refactor 功能把接口名字改成本来的名字即可移除该策略
<br />

#### 其他

摘自[SDK Compability Guide](https://developer.apple.com/library/mac/documentation/DeveloperTools/Conceptual/cross_development/Introduction/Introduction.html)
```
    检测某个类是否存在，首先需要确保部署对象是弱连接的
    if ([ABC class]) {
        //存在
    } else {
        //不存在
    }

    或者
    Class cls = NSClassFromString (@"NSRegularExpression");
    if (cls) {
        // Create an instance of the class and use it.
    } else {
        // Alternate code path to follow when the	
        // class is not available.
    }

    检测一个类是否有某个方法
    if ([abc instancesRespondToSelector:@selector(xxxx)]) {
    } else {
    }

    或者使用respondToSelector

    检测一个C函数是否存在，if (functionA != NULL)，函数的名字和地址在代码中表示的是同一个意思

    获取系统版本NSString *osVersion = [[UIDevice currentDevice] systemVersion];

    在Mac中，NSAppKitVersionNumber表示当前系统版本，可以通过与其他值比较来检测版本
```


#### 引用 
> [Tech Talks](https://developer.apple.com/tech-talks/videos/index.php?id=5)
