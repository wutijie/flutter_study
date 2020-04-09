## Flutter

32909334bc1324e40bdce82acf617a5a4977fd74

****

##### What Is Flutter

​	Flutter是由谷歌开发的一个使用一套编程语言（Dart）实现跨平台（iOS,Android）原生开发的“工具”。

****

##### 插件库

https://pub.flutter-io.cn/

##### 学习网页

https://juejin.im/post/5b3c8a4be51d4519935860d5?utm_source=flutterzhihu&utm_medium=flutter

****

##### 安装

​	https://flutterchina.club/setup-windows/

1. Git
2. Flutter SDK
3. Android Studio
4. AVD Manager  =>  Nexus 6  => Q 、Pie  =>  Hardware - GLES 2.0
5. Plugins  =>  Flutter

flutter doctor 检测安装

****

##### 新建项目

​	flutter create test_app

****

## Dart

```dart
  // 单行注释
  /**
   * 
   * 多行
   * 注释
   */
  // 所有代码都需要写在main函数
  // 变量 和 数据类型
  // Number: int /double
  // String
  // Boolean: bool
  // String 转义
  // String 拼接
  // 不同类型 不可拼接
  // $变量
  // ---------------------
  // 分支
  // ? : 表达式
  // ?? 表达式
  String name = 'wuthier';
  String nameTo = name ?? '1351351sd';
  print(nameTo);
  // switch
  // ---------------------
  // for
  // for in
  // while
  // do while
  // break 停止当前循环
  // 指定停止某个循环
  // continue
```

****

##### button

~~~
// 有阴影按钮
RaisedButton
// 无阴影按钮
FlatButton
// 带边框按钮
OutlineButton
~~~

##### padding/margin

~~~
padding/margin: EdgeInsets.all(90.0)
// left, top, right, bottom
padding/margin: EdgeInsets.fromLTRB(10.0, 20.0, 30.0, 40.0)
padding/margin: EdgeInsets.symmetric(vertical: 60.0, horizontal: 30.0)
~~~

##### Row/Column 横向

~~~
// 从中间开始
mainAxisAlignment: MainAxisAlignment.center
// 从左边开始
mainAxisAlignment: MainAxisAlignment.start
// 从右边开始
mainAxisAlignment: MainAxisAlignment.end
// 两边有padding
mainAxisAlignment: MainAxisAlignment.spaceAround/spaceAround
// 两边无padding
mainAxisAlignment: MainAxisAlignment.spaceBetween
~~~

##### Row/Column 纵向

~~~
// 从中间开始
crossAxisAlignment: CrossAxisAlignment.center
// 从上边开始
crossAxisAlignment: CrossAxisAlignment.start
// 从下边开始
crossAxisAlignment: CrossAxisAlignment.end
// 撑满
crossAxisAlignment: CrossAxisAlignment.stretch
~~~

##### Flex

```
Expanded(
	flex: 1,
)
```

##### 静态图片

```
AssetImage
```

##### 网络图片

```
NetworkImage
```

##### 圆圈容器

```
CircleAvatar(
	radius: 40.0,
	backgroundImage: AssetImage()
)
```

##### 分割线

```
Divider(
	height: 60.0,
	color: Colors.gray[800]
)
```

##### 距离

```
SizedBox(
	width: 10.0,
	height: 10.0
)
```

##### 路由

```
// 默认路由
initialRoute: '/home',
routes: {
    "/": (context) => Loading(),
    "/home": (context) => Home(),
    "/location": (context) => ChooseLocation(),
}
```

```
// 路由跳转
Navigator.pushNamed(context, "/location", arguments: {});
// 返回
Navigator.pop(context);
```

##### Widget生命周期

1. 无状态Widget
   - 整个周期所定义的状态不会发生变化
   - 所创建的函数只会运行一次
2. 有状态Widget
   - 整个周期状态是可以发生变化的
   - 可以通过setState实现状态更新
3. 生命周期方法
   - initState()
     - widget被创建是执行一次
   - build()
     - 构建渲染widget
     - 一旦使用setState()，就会执行Build()
   - dispose()
     - 一旦widget被删除，就会触发Dispose()
   - deactivate()
     - 路由变化时触发

****

##### 异步

~~~
void getData() async {
    await Future.delayed(Duration(seconds: 3), () {
    	print('3s后打印');
    });
    print('3s啦');
}
~~~

##### http

https://pub.flutter-io.cn/packages/http#-installing-tab-

****

### 打包

****

![image-20200407164019053](C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20200407164019053.png)

https://www.cnblogs.com/niceyoo/p/11046253.html