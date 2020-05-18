import 'package:flutter/material.dart';
import 'HttpManager/HttpManager.dart';
import 'package:rxdart/rxdart.dart';

void main() {
  return runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    httpManager.baseUrl = "";
    return MaterialApp(
      home: HomePage(),
    );
  }
}


class HomePage extends StatelessWidget {
  final HomePageProvider _provider = HomePageProvider();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      color: Colors.white,
      child: FlatButton(onPressed: (){
        _startRequest();
    }, child: Text('开始网络请求'),
    ));
  }

   _startRequest(){
    _provider.resultSubject.stream.listen((result){
      switch (result.validateType){

        case ValidateType.validating:
          /// 请求中提示
          break;
        case ValidateType.success:
          /// 请求成功
          break;
        case ValidateType.failed:
          /// 请求失败提示
          break;
      }
    });
    _provider.getDataSource();
  }
}

class HomePageProvider {
  PublishSubject<ValidateResult> resultSubject = PublishSubject<ValidateResult>();

  getDataSource()async{
    resultSubject.add(ValidateResult(ValidateType.validating));
    ValidateResult result = await HttpManager.instance.request(Api.apiDemo());
    switch (result.validateType) {

      case ValidateType.validating:
        break;
      case ValidateType.success:
        /// 对数据进行处理
        try {
          resultSubject.add(ValidateResult(ValidateType.success, data: "处理好的数据"));
        }catch(_){

        }
        break;
      case ValidateType.failed:
        resultSubject.add(ValidateResult(ValidateType.failed, errorMsg: "网络请求错误"));
        break;
    }
  }
}


