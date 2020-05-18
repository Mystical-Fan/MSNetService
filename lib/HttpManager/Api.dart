
import 'HttpManager.dart';
import 'TargetType.dart';

class Api {

  static apiDemo() {
    return TargetType().config(
      path: "",
      headers: {},
      method: MSNetServiceMethod.GET,
      parameters: {},
      encoding: ParameterEncoding.URLEncoding
    );
  }
}

final HttpManager httpManager = HttpManager.instance;
