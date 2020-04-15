import 'package:flutter/material.dart';

class RenderBottom extends StatelessWidget {

  bool isLoading;
  bool isOver;
  RenderBottom(this.isLoading, this.isOver);

  @override
  Widget build(BuildContext context) {
    //    加载中
    if(isLoading){
      return Container(
        padding: EdgeInsets.symmetric(vertical: 15.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "努力加载中",
              style: TextStyle(
                fontSize: 14.0,
                color: Color(0xFF333333),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 10.0),
            ),
            SizedBox(
                width: 20.0,
                height: 20.0,
                child: CircularProgressIndicator(strokeWidth: 3.0,)
            )
          ],
        ),
      );
    }else{
//      没有数据
      if(isOver) {
        return Container(
          padding: EdgeInsets.symmetric(vertical: 15.0),
          alignment: Alignment.center,
          child: Text(
            "已经到底啦",
            style: TextStyle(
              fontSize: 14.0,
              color: Color(0xFF333333),
            ),
          ),
        );
      }else{
//        还有数据
        return Container(
          padding: EdgeInsets.symmetric(vertical: 15.0),
          alignment: Alignment.center,
          child: Text(
            "上拉加载更多",
            style: TextStyle(
              fontSize: 14.0,
              color: Color(0xFF333333),
            ),
          ),
        );
      }

    }
  }
}
