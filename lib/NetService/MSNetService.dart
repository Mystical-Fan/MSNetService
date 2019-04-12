library msnetservice;
export 'ResultData.dart';

import 'package:dio/dio.dart';
import 'dart:convert';
import 'ResultData.dart';
import 'MSSessionManager.dart';

enum Method {
  GET,
  POST,
  UPLOAD,
  DOWNLOAD,
}

class MSNetService {
  /// get请求
  get(String url, {Object params}) async {
    return await request(url, method: Method.GET, params: params);
  }

  /// post请求
  post(String url,
      {Object params}) async {
    return await request(url, method: Method.POST, params: params);
  }

  /// 附件上传
  upLoad (var file, String fileName, String url, {Object params,}) async{
    return await request(url,
        method: Method.UPLOAD,params: params, file: file, fileName: fileName);
  }

  /// 附件下载
  download (String url, String savePath) async{
    return await request(url, method: Method.DOWNLOAD, fileSavePath: savePath);
  }

  ///  请求部分
  request(String url,
      {Method method, Object params, var file, String fileName, String fileSavePath}) async {
    try {
      Response response;

      MSSessionManager sessionManager = MSSessionManager();
      var headers = await getHeaders();
      if (headers != null) {
        sessionManager.options.headers = headers;
      }
      var baseUrl = await getBasicUrl();
      sessionManager.options.baseUrl = baseUrl;

      switch (method) {
        case Method.GET:
          response = await sessionManager.get(url,queryParameters: params);
          break;
        case Method.POST:
          response = await sessionManager.post(url,data: params);
          break;
        case Method.UPLOAD:
          {
            FormData formData = new FormData();
            if (params != null) {
              formData = FormData.from(params);
            }
            formData.add("files", UploadFileInfo.fromBytes(file, fileName+'.png'));
            response = await sessionManager.post(url,data: formData);
            break;
          }
        case Method.DOWNLOAD:
          response = await sessionManager.download(url, fileSavePath);
          break;
      }
      return await handleDataSource(response, method);
    } catch (exception) {
      return ResultData(exception.toString(), false);
    }
  }

  /// 数据处理
  static handleDataSource (Response response, Method method){
    String errorMsg = "";
    int statusCode;
    statusCode = response.statusCode;
    if (method == Method.DOWNLOAD) {
      if (statusCode == 200) {
        /// 下载成功
        return ResultData('下载成功', true);
      }else{
        /// 下载失败
        return ResultData('下载失败', false);
      }
    }
    //处理错误部分
    if (statusCode < 0) {
      errorMsg = "网络请求错误,状态码:" + statusCode.toString();
      return ResultData(errorMsg, false);
    }
    try {
      Map data = json.decode(response.data);
      if (data['code'] == 0 ) {
        try {
          return ResultData(data['data'], true);
        }catch (exception){
          return ResultData('暂无数据', false);
        }
      }else{
        return ResultData(data['msg'], false);
      }
    }catch(exception){
      List data = json.decode(response.data);
      return ResultData(data, true);
    }
  }

  getHeaders () {
    return null;
  }

  getBasicUrl (){
    return null;
  }

}
