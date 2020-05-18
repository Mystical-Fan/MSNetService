import 'package:dio/dio.dart';

class LogInterceptors extends InterceptorsWrapper {
  @override
  Future onRequest(RequestOptions options) {
    print("url========= " + options.baseUrl + options.path);
    print("method======" + options.method);
    print("headers:==== ");
    print(options.headers);
    print("parameters======");
    if (options.queryParameters == null){
      print(options.data);
    }else{
      print(options.queryParameters);
    }
    return super.onRequest(options);
  }

  @override
  Future onResponse(Response response) {
    print("code======== ${response.statusCode}");
    print("data======== ${response.data}");
    return super.onResponse(response);
  }

  @override
  Future onError(DioError err) {
    print("error========");
    print(err.response.statusCode);
    print(err.response.data);
    return super.onError(err);
  }
}