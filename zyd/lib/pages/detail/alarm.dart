import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_echarts/flutter_echarts.dart';

class Alarm extends StatelessWidget {

  List alarmLists;
  Alarm(this.alarmLists);

  @override
  Widget build(BuildContext context) {
    print(alarmLists);
    return Container(
      padding: EdgeInsets.all(10.0),
      child: Echarts(
        option: '''{
          title: {
            text: '报警统计',
            x: 'center'
          },
          legend: {
            data: ['报警次数0次'],
            bottom: '0'
          },
          xAxis: {
            name: '时',
            data: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24],
            type: 'category'
          },
          yAxis: {
            name: '次',
            type: 'value'
          },
          series: [
            {
              name: '报警次数0次',
              symbolSize: 10,
              symbol: 'circle',
              data: ${jsonEncode(alarmLists)},
              type: 'line'
            }
          ]
        }''',
      ),
      height: 200.0,
    );
  }
}
