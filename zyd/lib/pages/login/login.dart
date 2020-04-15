import 'dart:convert';

import 'package:toast/toast.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zyd/request/request.dart';
import 'package:zyd/utils/storage_util.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  TextEditingController _usernameController=new TextEditingController();
  TextEditingController _passwordController=new TextEditingController();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('登录'),
        centerTitle: true,
        backgroundColor: Colors.teal[400],
      ),
      body: Container(
        child: ListView(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 80.0, 0, 50.0),
                  child: Image(
                    image: NetworkImage('http://zyd.nbmade2025.com/zydNBMADE/static/logo.png'),
                    width: 100.0,
                    height: 100.0,
                  ),
                )
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.0),
              child: TextField(
                controller: _usernameController,
                decoration: InputDecoration(
                  hintText: '手机号',
                  prefixIcon: Icon(Icons.person)
                ),
              ),
            ),
            SizedBox(height: 10.0,),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.0),
              child: TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: '密码',
                  prefixIcon: Icon(Icons.lock)
                ),
              ),
            ),
            SizedBox(height: 10.0,),
            Padding(
              padding: EdgeInsets.all(30.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: RaisedButton(
                      padding: EdgeInsets.symmetric(vertical: 10.0),
                      onPressed: () {
                        print(_usernameController.text);
                        print(_passwordController.text);
                        if(_usernameController.text == ''){
                          return showToast("请输入手机号", duration: Toast.LENGTH_LONG);
                        }
                        if(_passwordController.text == ''){
                          return showToast("请输入密码", duration: Toast.LENGTH_LONG);
                        }
                        Request.post(
                          'http://j.api.zyd.nbmade2025.com/japi/2_1/zhiyunduan/user/login',
                          (res){
//                            print(res);
                            res = jsonDecode(res);
                            if(res['code'] == 200) {
                              StorageUtil.setStringItem('userInfo', json.encode({
                                'user': _usernameController.text,
                                'passworld': _passwordController.text,
                                'token': res['data']
                              }));
                              StorageUtil.setStringItem('fresh', 'ok');
                              Navigator.pop(context);
                            }else{
                              showToast(res['msg'], duration: Toast.LENGTH_LONG);
                            }
                          },params: {
                            'userName': _usernameController.text,
                            'password': _passwordController.text
                          },errorCallback: (err){
                            print(err);
                          }
                        );
                        

                      },
                      child: Text('登录', style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0
                      ),),
                      color: Colors.teal[400],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
  void showToast(String msg, {int duration, int gravity}) {
    Toast.show(msg, context, duration: duration, gravity: gravity);
  }
}
