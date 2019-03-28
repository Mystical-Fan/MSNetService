import 'package:dio/dio.dart';
import 'dart:io';

class MSSessionManager extends Dio {

  static const String CONTENT_TYPE_JSON = "application";
  static const String CONTENT_TYPE_FORM = "x-www-form-urlencoded";
  static const String CONTENT_CHART_SET = 'utf-8';

  // 工厂模式
  factory MSSessionManager() =>_getInstance();
  static MSSessionManager get instance => _getInstance();
  static MSSessionManager _instance;
  MSSessionManager._internal() {
    // 初始化
  }

  static MSSessionManager _getInstance() {
    if (_instance == null) {
      _instance =  MSSessionManager._internal();
      BaseOptions options = BaseOptions(
        // 15s 超时时间
          connectTimeout:15000,
          receiveTimeout:15000,
          responseType: ResponseType.json,
          contentType: ContentType(CONTENT_TYPE_JSON, CONTENT_TYPE_FORM,charset: CONTENT_CHART_SET)
      );
      _instance.options = options;
    }
    return _instance;
  }
}