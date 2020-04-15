import 'package:flutter/material.dart';
import 'package:zyd/maps/maps.dart';

class DeviceCard extends StatelessWidget {
  final DeviceList device;
  DeviceCard(this.device);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () {
            Navigator.pushNamed(context, '/detail', arguments: {
              'did': device.dId
            });
          },
          child: Row(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Image(
                      height: 80.0,
                      image: device.deviceImage.isEmpty ? AssetImage('assets/none.png') : NetworkImage(device.deviceImage)
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 10.0, 0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('编号：${device.deviceNumber}'),
                      Text('型号：${device.deviceModel}'),
                      Text('名称：${device.deviceName}'),
                      Text('企业：${device.companyName}',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        softWrap: false,
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
//        Divider(
//          color: Colors.grey,
//        )
      ],
    );
  }
}