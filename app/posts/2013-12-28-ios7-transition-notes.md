### 迁移到 iOS7 的学习记录
最近需要升级 iOS 的 App 到 iOS7，所以，学习了下如何迁移到新的版本
  

#### 建议使用 auto layout  
建议先只支持iOS7，然后对iOS6做微小调整
  

#### 应用类型（从界面来看）  
*  标准  
*  定制化  
*  混合类型  
  

#### 需要做的改动

##### 每个App 都必须做的：  
更新应用图标，iOS7的mask的圆角尺寸和之前的有区别；更新启动图片来使得其包含了状态栏的高度  

##### 每个App 都需要做的：  
保证所有元素在半透明的背景下是清晰可见的  
重新设计工具栏或者导航栏上的 icon  
重新设计按钮的背景  
检查代码中的hard code的UI代码，尽量使用计算得到的值（或者采用auto layout会更好）  
检查控件的尺寸，有些控件在iOS7中的大小发生了变化，可能有些部分需要调整  
使用动态类型的字体  
重新思考阴影和梯度颜色的使用，因为iOS不再是拟物的了，而是扁平话的了  
确认被弃用的API不再被使用  
  

#### 对iOS6的支持  
使用IB来支持多版本的App
  

#### 在混合模式的App里管理许多的图片
Use Asset Catalog to manage resources
  

#### 条件式地载入资源
```objective-c
if (floor(NSFoundationVersionNumber) <= NSFoundationVersionNumber_iOS_6_1) {
    //Load resource for iOS6.1 or earlier
} else {
    //Load resource for iOS7 or later
}
```
(barTintColor or tintColor)
  

#### 外观和行为
wantsFullScreenLayout 不再被支持  

改变layout方式的属性： edgesForExtendedLayout (UIRectEdge), extendedLayoutIncludesOpaqueBars, autuomaticallyAdjustsScrollViewInsets, topLayoutGuide, bottomLayoutGuide  

iOS7中view controller可以动态地改变状态栏的样式，preferredStatusStyle（在动画的block中设置），然后调用setNeedsStatusBarApperanceUpdate  
如果更希望用view controller来控制状态栏的样式，可以在 Info.plist 里设置 UIViewControllerBasedStatusBarApperance 为 YES, 否则，设置为 NO  
  

#### tintColor 的使用  
在 iOS7 中，当指定了 view 的 tintColor 后，这个 tint 会自动传播到它的子视图中，所以，要指定全局的 tint 时，可以先设置 window 的tint
还可重载 tintColorDidChange 方法来响应 tint 的改变  
  

#### 字体的使用
iOS7 引入了动态类型
  

#### 手势的使用
新的delegate方法来阻止手势的传播
  

#### 栏和栏上的按钮
iOS7 引入了 barPosition 属性来标定 bar 的位置， UIBarPositionTopAttached, UIBarPositionTop  
status bar style: UIStatusBarStyleDefault, UIStatusBarStyleLightContent  

*  navigation bar  
*  tool bar
*  tab bar,  selectedImage
*  search bar
  

#### 不同的图片渲染类型  
UIImage property for rendering: UIImageRenderingModeAlwaysTemplate / UIImageRenderingModeAlwaysOriginal
  

#### 内容视图
活动，两种 icon 类型，自定义的 icon： 黑白的，有透明度的，不要阴影，使用抗锯齿  
Collection View, Image View, Map View, Page ViewController, Scroll View, Split View Controller, Table View, Text View  
WebView, iOS7 中支持分页的布局  
  

#### 控件
*  Date Picker  
*  System Defined Buttons  
*  Page Control  
*  Picker  
*  Progress View  
*  Refresh Control  
*  Rounded Rectangle Button  
*  Segmented Control  
*  Slider  
*  Stepper  
*  Switch  
*  Text Field  
  

#### 临时视图
Action Sheet, UIActionSheetStyle 在 iOS7 中被无视掉了  
Alert  
Modal View  

* * *
> 原文：[iOS 7 UI Transition Guide](https://developer.apple.com/library/ios/documentation/userexperience/conceptual/transitionguide/)
