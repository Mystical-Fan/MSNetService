import 'package:flutter/material.dart';
import 'BasicNetService.dart';

void main() {
  return runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      color: Colors.white,
      child: FlatButton(onPressed: (){
      _startNetWork();
    }, child: Text('开始网络请求'),
    ));
  }

  _startNetWork() async{
    ResultData resultData = await BasicNetService().post('',params: {});
  }
}

