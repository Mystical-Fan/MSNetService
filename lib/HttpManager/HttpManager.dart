library httpmanager;

export 'TargetType.dart';
export 'Result.dart';
export 'Api.dart';

import 'package:dio/dio.dart';
import 'Log_Interceptors.dart';
import 'Result.dart';
import 'TargetType.dart';

/// 默认的content-type 为 application/json
/// 如果要修改直接修改传入的header
class HttpManager {
  Dio dio;

  /// 以下参数配置如需更改 可在main文件中统一处理
  /// 网络请求baseUrl
  var baseUrl;

  /// 超时时间
  var connectTimeout = 15000;

  /// 单例
  // 工厂模式
  factory HttpManager() => _getInstance();

  static HttpManager get instance => _getInstance();
  static HttpManager _instance;

  HttpManager._internal() {
    // 初始化
  }

  static HttpManager _getInstance() {
    if (_instance == null) {
      _instance = HttpManager._internal();
      _instance.dio = new Dio();
      _instance.dio.interceptors.add(LogInterceptors());
    }
    return _instance;
  }

  /// 请求功能
  request(TargetType targetType) async {
    if (baseUrl == null) {
      print("请在main文件中配置baseUrl");
      return;
    }
    try {
      Response response;
      final options = BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: connectTimeout,
      );
      if (targetType.headers != null) {
        options.headers = targetType.headers;
      }

      dio.options = options;
      switch (targetType.method) {
        case MSNetServiceMethod.POST:
          options.method = "POST";
          break;
        case MSNetServiceMethod.GET:
          options.method = "GET";
          break;
        case MSNetServiceMethod.PATCH:
          options.method = "PATCH";
          break;
        case MSNetServiceMethod.UPLOAD:
          options.method = "UPLOAD";
          break;
        case MSNetServiceMethod.DOWNLOAD:
          options.method = "DOWNLOAD";
          break;
        case MSNetServiceMethod.DELETE:
          options.method = "DELETE";
          break;
      }
      if (targetType.parameters != null) {
        switch (targetType.encoding) {
          case ParameterEncoding.URLEncoding:
            response = await dio.request(targetType.path,
                queryParameters: targetType.parameters);
            break;
          case ParameterEncoding.BodyEncoding:
            response = await dio.request(targetType.path,
                data: targetType.parameters);
            break;
        }
      } else {
        response = await dio.request(targetType.path);
      }
      return ValidateResult(ValidateType.success, data: response.data);
    } catch (exception) {
      try{
        DioError error = exception;
        Map dict = error.response.data;
        var message =  dict["message"] ;
        return ValidateResult(ValidateType.failed, errorMsg: (message == null) ? "网络请求失败, 请重试" : message);
      }catch (error) {
        return ValidateResult(ValidateType.failed, errorMsg: "网络请求失败, 请重试");
      }
    }
  }
}

final HttpManager httpManager = HttpManager.instance;
