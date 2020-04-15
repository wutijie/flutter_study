import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:zyd/utils/storage_util.dart';

class Request {

  static void get(String url, Function callback,
      {Map<String, String> params, Function errorCallback}) async {
    String publicUrl = 'http://j.api.zyd.nbmade2025.com/japi/2_1';
    if (params != null && params.isNotEmpty) {
      StringBuffer sb = new StringBuffer("?");
      params.forEach((key, value) {
        sb.write("$key" + "=" + "$value" + "&");
      });
      String paramStr = sb.toString();
      paramStr = paramStr.substring(0, paramStr.length - 1);
      url += paramStr;
      url = publicUrl + url;
    }
    try {
      http.Response res = await http.get(url);
      if (callback != null) {
        callback(res.body);
      }
    } catch (exception) {
      if (errorCallback != null) {
        errorCallback(exception);
      }
    }
  }

  static Future post(String url, Function callback,
      {Map<String, String> params, Function errorCallback}) async {
    String publicUrl = 'http://zyd.nbmade2025.com/zydservice';
    if(url.substring(0, 4) == 'http') {
      publicUrl = '';
    }
    url = publicUrl + url;
    String userToken = '';
    await StorageUtil.getStringItem('userInfo').then((data){
      print('data:$data');
      if(data != null) {
        data = jsonDecode(data);
        userToken = data['token'];
      }else{
        userToken = '';
      }
    });

    try {
      http.Response res = await http.post(url, body: params,headers: {
        'token': userToken != '' ? userToken : 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhdWQiOiJBUFAiLCJ1c2VyX2lkIjoiNjMiLCJpc3MiOiJTZXJ2aWNlIiwiY3VzdElkIjoiMDAwMDY2IiwiZXhwIjoxNTg2NzUzMDkxLCJpYXQiOjE1ODU4ODkwOTF9.1rFufW89fA1GcZWyp4eZ3UDOIllcUNLQpLJP2QnXUco'
      });

      if (callback != null) {
        callback(res.body);
      }
    } catch (e) {
      if (errorCallback != null) {
        errorCallback(e);
      }
    }
  }
}