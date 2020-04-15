import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zyd/utils/storage_util.dart';

class Mycenter extends StatefulWidget {
  @override
  _MycenterState createState() => _MycenterState();
}

class _MycenterState extends State<Mycenter> {

  String userNumber = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('userInfo');
    StorageUtil.getStringItem('userInfo').then((data){
      print(data);
      if(data != null){
        data = jsonDecode(data);
        setState(() {
          userNumber = data['user'];
        });
      }else{
        userNumber = '';
      }


    });
  }
//未登录
  Widget notLogin() {
    return Center(
      child: RaisedButton(
        onPressed: () async {
          await Navigator.pushNamed(context, '/login');
          StorageUtil.getStringItem('userInfo').then((data){
            if(data != null) {
              data = jsonDecode(data);
              setState(() {
                userNumber = data['user'];
              });
            }else{
              userNumber = '';
            }

          });
        },
        child: Text('登录', style: TextStyle(
            color: Colors.white
        ),),
        color: Colors.teal[400],
      ),
    );
  }
//已登录
  Widget hasLogin() {
    return Padding(
      padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('用户：$userNumber'),
          RaisedButton(
            onPressed: (){
              print('not');
              StorageUtil.remove('userInfo');
              setState(() {
                userNumber = '';
              });
              Navigator.pushNamed(context, '/login');
            },
            child: Text('退出登录', style: TextStyle(
              color: Colors.white
            ),),
            color: Colors.teal[400],
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('个人中心'),
        centerTitle: true,
        backgroundColor: Colors.teal[400],
      ),
      body: userNumber != '' ? hasLogin() : notLogin(),
    );
  }
}
