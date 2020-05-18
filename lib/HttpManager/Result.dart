
enum ValidateType{
  /// 请求中
  validating,
  /// 请求成功
  success,
  /// 请求失败
  failed,
}

class ValidateResult {
  ValidateType validateType;
  var data;
  var errorMsg;

  ValidateResult(this.validateType,{
    this.data,
    this.errorMsg});
}

