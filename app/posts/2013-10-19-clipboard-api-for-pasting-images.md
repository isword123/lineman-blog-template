###HTML5相关的学习与记录
HTML5里面提供了很多的新接口，虽说现在不一定用得上，但是先学习记录下来，以备不时只需。

###ClipBoard API
简单而言，就是在网页上监听'paste'事件，获取在事件对象中的剪贴板内容，遍历一下，寻找到图片对象，然后创建相应data URI，再用URI赋值到新创建的img DOM元素上，就可以完成对剪贴板中图片内容的获取并显示。

####简单的代码示例
```javascript
window.addEventListener('paste', function (e) {
    //这是一个用于展现图片的容器，从剪贴板里获取的图片都显示在这里
    var imgContainer = document.querySelector('#img-container');

    //遍历剪贴板里所有的项
    for (var i = 0; i < e.clipboardData.items.length; i++) {
        var clipItem = e.clipboardData.items[i];
        var type = clipItem.type;

        //寻找是图片的项
        if (type.indexOf('image') > -1) {
            //创建data URI
            var blob = clipItem.getAsFile();
            var blobUrl = window.webkitURL.createObjectURL(blob);

            //创建img元素，并设置src为以上创建的data URI
            var img = new Image();
            img.src = blobUrl;
            imgContainer.appendChild(img);//添加图片到显示区域
        } else {
            window.console.log('not supported');
        }
    }
});
```

从[此处](http://www.smartjava.org/content/copy-and-paste-images-your-browser-using-w3c-clipboard-api)学习。
