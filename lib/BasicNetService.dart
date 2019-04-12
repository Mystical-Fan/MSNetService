
library basicnetservice;
export 'package:msnetservice/NetService/MSNetService.dart';
import 'package:msnetservice/NetService/MSNetService.dart';


class BasicNetService extends MSNetService {

  String url;
  Method method;

  @override
  request(String url, {Method method, Object params, var file, String fileName,String fileSavePath}) {
    // TODO: implement request
    this.url = url;
    this.method = method;
    /// 传参进行统一处理
    Map newParams = {};
    return super.request(url,method: method, params: newParams, file: file, fileName: fileName,fileSavePath: fileSavePath);
  }

  @override
  getBasicUrl() {
    // TODO: implement getBasicUrl
    String baseUrl;
//    switch (this.method) {
      /// 根据不同的请求方式 或者url设置不同baseUrl
//    }
    return baseUrl;
  }

  @override
  getHeaders() async{
    // TODO: implement getHeaders
    Map<String, dynamic> headers;
    switch (this.url) {
      /// 根据不同的Url 判断是否添加headers
    }
    return null;
  }
}
