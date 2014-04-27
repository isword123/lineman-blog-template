### 学习下Web Worker的使用  
Web worker的出现是为了解决javascript总是在单线程里执行的问题，为了让javascript有能力做并行的事情

#### 基础使用方法

在主页面上

```javascript
var worker = new Worker('worker.js');
work.onmessage = function () {

};
worker.postMessage('some kind of messages');
```

在worker.js里 

```javascript
self.onmessage = function (e) {
    //e.data, handling for data
    self.postMessage('return back messages')
};
```

在页面上的JS首先创建一个Worker的实例，设置好获取从worker得到消息后的回调 (onmessage)，回调用于对worker传过来的消息进行响应，然后触发一个发送消息的操作 (postMessage)；  
在worker对应的JS里，定义好收到消息的回调 (onmessage)，在回调里处理传过来的数据，然后将消息传回到页面。

#### 需要注意的地方

使用postMessage的时候，传递的参数可以是 File, Blob, ArrayBuffer, JSON 对象，参数传递的过程中会产生一份拷贝 

对于比较大的对象，拷贝需要的资源消耗就会很大

Transferable Object 的使用，对象的传递是 'Zero-Copy' 的，即从一个上下文传递到另一个上下文，当传递之后，源上下文就无法再访问被传递的对象，而传递的过程中，并没有发生真正的拷贝操作。

```javascript
worker.postMessage(arrayBuffer, [arrayBuffer]);
window.postMessage(arrayBuffer, targetOrigin, [arrayBuffer]);
```

#### Worker使用的限制

在Woker对应的JS脚本里，JS只能有限的访问和操作一部分页面的对象

可以访问和操作的部分：
*  navigator 对象
*  location 对象
*  XMLHttpRequest
*  setTimeout() / clearTimeout() / setInterval() / clearInterval()
*  Application Cache (应用缓存)
*  使用 importScripts() 来引入外部的脚本
*  生成子的 web worker

不可操作或访问的部分：
*  DOM 对象 (不是线程安全的)
*  window 对象
*  document 对象
*  parent 对象

#### 子的 Web Worker

子的 Web Worker 必须跟父级处在同一个域名下，不可跨域；URI 的路径是相对于父级 worker的位置的

#### 内联的 Web Worker

例子：

```javascript
var blob = new Blob([
    "onmessage = function(e) { postMessage('msg from worker'); }"]);

// Obtain a blob URL reference to our worker 'file'.
var blobURL = window.URL.createObjectURL(blob);

var worker = new Worker(blobURL);
worker.onmessage = function(e) {
  // e.data == 'msg from worker'
  };
worker.postMessage(); // Start the worker.
```

当 blobURL 不再需要的时候，可以调用 `window.URL.revokeObjectURL(blobURL)` 来释放对 blobURL 的引用

当使用内联的 Web Worker，并且其中引用了外部的脚本时，必须提供绝对路径，因为内联的文本可能在任何路径下执行，如果不是绝对路径，浏览器会抛出一个安全的错误

#### 错误处理

Javascript 错误对象包含了
*  lineno, 出错的行数
*  filename, 出错的文件名
*  message, 错误的具体描述

示例代码：

```javascript
function onError(e) {
    document.getElementById('error').textContent = [
    'ERROR: Line ', e.lineno, ' in ', e.filename, ': ', e.message
    ].join('');
}

var worker = new Worker('workerWithError.js');
worker.addEventListener('error', onError, false);
worker.postMessage(); // Start worker without a message.
```

#### 原文
> http://www.html5rocks.com/en/tutorials/workers/basics/
