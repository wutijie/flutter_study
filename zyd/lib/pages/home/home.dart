import 'dart:convert';
import 'package:toast/toast.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zyd/maps/maps.dart';
import 'package:zyd/pages/home/deviceCard.dart';
import 'package:zyd/pages/home/renderBottom.dart';
import 'package:zyd/request/request.dart';
import 'package:zyd/utils/storage_util.dart';

class Home extends StatefulWidget {
  final Map arguments;
  Home({Key key, String list, this.arguments}) : super(key: key);
  @override
  _HomeState createState() => _HomeState(arguments:this.arguments);
}

class _HomeState extends State<Home> {
  Map arguments;
  _HomeState({this.arguments});

//存放列表
  List<DeviceList> deviceList = [];
//当前页
  int pageSize = 1;
//判断是否还有数据
  bool isOver = false;
//搜索值
  static String searchValue;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getInitData();
//     给列表添加滚动监听
    scrollController.addListener((){
//       滑动到底部的关键判断
      if(
      !isLoading &&
          scrollController.position.pixels >= scrollController.position.maxScrollExtent
      ){
//         开始加载数据
//        print('over');
        if(!isOver) {
          setState(() {
            pageSize += 1;
          });
          isLoading = true;
          getInitData();
        }
      }

    });
  }


  @override
  void deactivate() {
    // TODO: implement deactivate
    super.deactivate();
    StorageUtil.getStringItem('fresh').then((data){
      if(data != null) {
        setState(() {
          pageSize = 1;
        });
        getInitData();
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    scrollController.dispose();
  }

//获取列表数据
  Future<void> getInitData() async {
     List<DeviceList> data = [];
//     print('getInitData---$searchValue');
     await Request.post(
      '/APPService.asmx/GetDeviceInfo',
      (res){
//        print(res);
        res = jsonDecode(res);
        print('length${res['data'].length}');
        if(res['data'].length == 0 || res['data'].length < 10) {
          setState(() {
            isOver = true;
          });
        }else{
          setState(() {
            isOver = false;
          });
        }
        res['data'].forEach( (item){
          data.add(
            DeviceList(
              item['c_name'],
              item['d_alarmcount'],
              item['d_id'],
              item['d_image'],
              item['d_model'],
              item['d_name'],
              item['d_number'],
              item['deviceid'],
              item['linestatus']
            )
          );
        });
        isLoading = false;
      },params: {
      'searchvalue': searchValue == null ? '' : searchValue,
      'page': pageSize.toString()
    });

     setState(() {
       if(pageSize == 1) {
         deviceList = data;
       }else{
         deviceList.addAll(data);
       }
     });
  }

//  是否在加载中
  bool isLoading = true;
//  滚动控制
  ScrollController scrollController = ScrollController();
//  上拉刷新
  Future onRefresh(){
    return Future.delayed(Duration(seconds: 1),(){
      setState(() {
        pageSize = 1;
      });
      getInitData();
      Toast.show('当前已是最新数据', context);
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('首页'),
        centerTitle: true,
        backgroundColor: Colors.teal[400],
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 0,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 6.0, horizontal: 5.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: OutlineButton(
                      onPressed: () async {
                        dynamic result = await Navigator.pushNamed(context, '/search');
                        if(result != null) {
                          searchValue = result['searchValue'];
                          getInitData();
                        }
                      },
                      child: Text('搜索'),
                      shape: StadiumBorder(
                        side: BorderSide(
                          color: Colors.grey,
                          width: 1.0,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 10,
            child: RefreshIndicator(
              onRefresh: onRefresh,
              child: ListView.separated(
                controller: scrollController,
                itemCount: deviceList.length + 1,
                itemBuilder: (context, index) {
                  if(index < deviceList.length){
                    return DeviceCard(deviceList[index]);
                  }else{
                    return RenderBottom(isLoading, isOver);
                  }
                },
                separatorBuilder: (context, index){
                  return Divider(height: 0.5, color: Colors.grey);
                },
              ),
              /*child: ListView.builder(
                itemCount: deviceList.length,
                itemBuilder: (context, index) {
                  return DeviceCard(deviceList[index]);
                },
              )*/
            ),
          )
        ],
      )
    );
  }
}



