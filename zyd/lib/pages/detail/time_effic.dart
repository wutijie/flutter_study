import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_echarts/flutter_echarts.dart';
import 'package:zyd/request/request.dart';

class TimeEffic extends StatefulWidget {
  final Map arguments;
  TimeEffic({Key key, String list, this.arguments}) : super(key: key);
  @override
  _TimeEfficState createState() => _TimeEfficState(arguments:this.arguments);
}

class _TimeEfficState extends State<TimeEffic> {
  Map arguments;
  _TimeEfficState({this.arguments});

  List timeLists;
  Future<void> getInitData() async {
    List lists;
    await Request.post(
      '/APPService.asmx/GetDeviceDetail_TimeStatistics',
      (res) {
        res = jsonDecode(res);
//        print(res);
        if(res['code'] == 200) {
          lists = res['data']['TimeStatistics'];
        }
      },
      params: {
        'did': arguments['did'].toString()
      }
    );
    setState(() {
      timeLists = lists;
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getInitData();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.0),
      child: Echarts(
        option: '''{
          title: {
            text: '时间效率分析',
            x: 'center'
          },
          legend: {
            data: ['待机', '关机', '工作', '报警'],
            bottom: 0
          },
          grid: {
            left: '5%',
            bottom: '20%',
            containLabel: true
          },
          xAxis: {
            name: '时',
            type: 'value',
            min: 0,
            max: 86400,
            interval: 7200,
            boundaryGap: true,
            axisLine: {
              show: true
            },
            axisLabel: {
              formatter: function(val) {
                val =
                  val % (60 * 60) == 0
                    ? (val / 60 / 60 > 24 ? val / 60 / 60 - 24 : val / 60 / 60) + ':00'
                    : parseInt(val / 60 / 60) > 24
                    ? parseInt(val / 60 / 60) - 24 + ':' + (val % (60 * 60)) / 60
                    : parseInt(val / 60 / 60) + ':' + (val % (60 * 60)) / 60;
                return val.substring(0,val.length-3);
              }
            }
          },
          yAxis: {
            type: 'category',
            axisLine: {
              onZero: false
            },
            boundaryGap: true,
          },
          series: ${jsonEncode(timeLists)}
        }''',
      ),
      height: 200.0,
    );
  }
}
