import 'package:flutter/cupertino.dart';
import 'package:zyd/pages/detail/detail.dart';
import 'package:zyd/pages/home/home.dart';
import 'package:zyd/pages/home/search.dart';
import 'package:zyd/pages/index.dart';
import 'package:zyd/pages/login/login.dart';
import 'package:zyd/pages/mycenter/mycenter.dart';

class RouterConfig {
  static final initRouteName = '/';
  static final Map<String, WidgetBuilder> router = {
    '/': (BuildContext context) => Index(),
    '/login': (BuildContext context) => Login(),
    '/home': (BuildContext context) => Home(),
    '/search': (BuildContext context) => Search(),
    '/mycenter': (BuildContext context) => Mycenter(),
    '/detail': (BuildContext context, { arguments }) => Detail(arguments: arguments)
  };
  static Route<dynamic> onGenerateRoute(RouteSettings settings){

    // 统一处理路由
    final String name = settings.name;
    final Function pageContentBuilder = router[name];

    //定义当前需要返回得route对象
    Route route;
    if (pageContentBuilder != null) {
      if (settings.arguments != null) {
        //带参数的处理方式
        switch(name){
          default:
            route = CupertinoPageRoute(
                builder: (context) => pageContentBuilder(context, arguments: settings.arguments)
            );
            break;
        }
      }else{
        //不带参数的处理方式
        switch(name){
          case '/login':
            route = CupertinoPageRoute(
                builder: (context) => pageContentBuilder(context),
                fullscreenDialog: true
            );
            break;
          default:
            route = CupertinoPageRoute(
                builder: (context) => pageContentBuilder(context)
            );
            break;
        }
      }
    }
    return route;
  }
}