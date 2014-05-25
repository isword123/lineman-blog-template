### 学习Media Query
IE7 / IE8 不支持 media query，如有需要，要注意适配

* * *  

#### 引用格式 1
```html
<link rel="stylesheet" type="text/css" meida="screen" href="example.css" />  
<link rel="stylesheet" media="screen and (color)" href="example.css" />
```

#### 引用格式 2
```css
@media screen {
    font-size: 14px;
}
@media all and (min-width:500px) { … }
@media (min-width:500px) { … }
@media (orientation: portrait) { … }
@media all and (orientation: portrait) { … }
```

#### 引用格式 3
```html
@import url(color.css) screen and (color);
```

#### Query Lists
* `width, height`: 允许min, max前缀
* `device-width, device-height`: 允许min, max前缀
* `orientation`: 有portrait和landscape两个值，不允许min, max前缀
* `aspect-ratio`: 表示 width/height 的值，允许min, max前缀
* `device-aspect-ration`: 表示 device-width/device-height 的值，允许min, max前缀
* `color`: 表示输出设备的每个颜色的bit的数目，取最小值，允许min, max前缀
* `color-index`: 表示输出设备的颜色的索引的个数，允许min, max前缀
* `monochrome`: 表示是单色输出设备每像素的bit的数目，允许min, max前缀
* `resolution`: 输出设备的分辨率(dpi, dpcm)，如16/9，允许min, max前缀
* `scan`: TV设备的扫描方式(progressive...)，不允许min, max前缀
* `grid`: 设备是否是grid的还是bitmap式的，不允许min, max前缀


#### Points
* 在Media Query中，逗号表示或（OR）的关系，and表示（AND）的关系，还有not / only
* 如果Media Query的列表为空，则总被认为是真的，即所定义的样式会总被应用到页面上
* 查询条件中，'min-'表示大于或等于，'max-'表示小于或等于


#### 引用
> [Media Queries](http://www.w3.org/TR/css3-mediaqueries/)  
