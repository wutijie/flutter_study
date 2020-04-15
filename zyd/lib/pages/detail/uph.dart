import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_echarts/flutter_echarts.dart';

class Uph extends StatelessWidget {

  List uphLists;
  Uph(this.uphLists);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.0),
      child: Echarts(
        option: '''{
          title: {
            text: 'UPH统计',
            x: 'center',
            subtext: '今日产量'
          },
          grid: {
            left: '10%',
            bottom: '10%',
          },
          color: ['#3398DB'],
          xAxis: {
            name: '时',
            data: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24],
            axisLine: {
              show: true
            },
            type: 'category',
            axisTick: {
              alignWithLabel: true
            }
          },
          yAxis: {
            name: '件',
            type: 'value',
            splitLine: {
              show: true,
              lineStyle: {
                width: 1,
                type: 'solid'
              }
            }
          },
          series: {
            type: 'bar',
            barWidth: '60%',
            data: ${jsonEncode(uphLists)}
          }
        }''',
      ),
//      width: 300.0,
      height: 200.0,
    );
  }
}
