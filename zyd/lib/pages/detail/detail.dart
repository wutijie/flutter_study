import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:zyd/pages/detail/alarm.dart';
import 'package:zyd/pages/detail/time_effic.dart';
import 'package:zyd/pages/detail/uph.dart';
import 'package:zyd/request/request.dart';

class Detail extends StatefulWidget {
  final Map arguments;
  Detail({Key key, String list, this.arguments}) : super(key: key);
  @override
  _DetailState createState() => _DetailState(arguments:this.arguments);
}

class _DetailState extends State<Detail> {
  Map arguments;
  _DetailState({this.arguments});

  Map deviceDetail = {
    'deviceimg': null,
    'deviecid': '',
    'devicemodel': '',
    'devicename': '',
    'custname': '',
  };
  Map chartData = {
    'uph': [],
    'alarmStatistics': [],
  };

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getInitData();
  }

  Future<void> getInitData() async{
    Map data;
    Map chart;
    await Request.post(
      '/APPService.asmx/GetDeviceDetail',
      (res){
        res = jsonDecode(res);
        if(res['code'] == 200) {
          data = {
            'deviceimg': res['data']['deviceimg'],
            'deviecid': res['data']['deviecid'],
            'devicemodel': res['data']['devicemodel'],
            'devicename': res['data']['devicename'],
            'custname': res['data']['custname'],
          };
          chart = {
            'uph': res['data']['UPH'],
            'alarmStatistics': res['data']['AlarmStatistics'],
          };
        }
      },
      params: {
        'did': arguments['did'].toString()
      }
    );
    setState(() {
      deviceDetail = data;
      chartData = chart;
    });
  }

  @override
  Widget build(BuildContext context) {
//    print(deviceDetail);
    return Scaffold(
      appBar: AppBar(
        title: Text('详情'),
        centerTitle: true,
        backgroundColor: Colors.teal[400],
      ),
      body: Container(
        color: Colors.white,
        child: ListView(
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Image(
                        height: 80.0,
                        image: deviceDetail['deviceimg'] == null || deviceDetail['deviceimg'] == '' ? AssetImage('assets/none.png') : NetworkImage(deviceDetail['deviceimg'])
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('编号：${deviceDetail['deviecid']}'),
                      Text('型号：${deviceDetail['devicemodel']}'),
                      Text('设备：${deviceDetail['devicename']}'),
                      Text('企业：${deviceDetail['custname']}'),
                    ],
                  ),
                )
              ],
            ),
            Divider(color: Colors.grey),
            Uph(chartData['uph']),
            Divider(color: Colors.grey),
            TimeEffic(arguments: {
              'did': arguments['did'].toString()
            }),
            Divider(color: Colors.grey),
            Alarm(chartData['alarmStatistics']),
            Divider(color: Colors.grey),
          ],
        ),
      ),
    );
  }
}
