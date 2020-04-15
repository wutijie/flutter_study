import 'package:flutter/material.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {

  TextEditingController _searchValueController=new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('搜索'),
        centerTitle: true,
        backgroundColor: Colors.teal[400],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 1.0, horizontal: 10.0),
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 3,
              child: TextField(
                controller: _searchValueController,
                autofocus: true,
                decoration: InputDecoration(
                    hintText: '输入查询设备编号、型号、名称、企业名',
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: FlatButton(
                child: Text('搜索', style: TextStyle(
                  fontSize: 16.0,
                ),),
                onPressed: () {
                  Navigator.pop(context, {
                    'searchValue': _searchValueController.text
                  });
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
