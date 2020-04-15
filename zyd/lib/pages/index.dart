import 'package:flutter/material.dart';
import 'package:zyd/pages/home/home.dart';
import 'package:zyd/pages/mycenter/mycenter.dart';
class Index extends StatefulWidget {
  @override
  _IndexState createState() => _IndexState();
}

class _IndexState extends State<Index> {

  int currentIndex = 0;
  List<Widget> pageLists = [
    Home(),
    Mycenter()
  ];


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        body: IndexedStack(
          index: currentIndex,
          children: pageLists,
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: (index) {
            setState(() {
              currentIndex = index;
            });
          },
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.home),
                title: Text('首页')
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.person),
                title: Text('我的')
            ),
          ],
        ),
      ),
    );
  }
}
