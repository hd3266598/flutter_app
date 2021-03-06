import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_app/common/style/GSYStyle.dart';

///错误编码
class Code {
  ///网络错误
  static const NETWORK_ERROR = -1;

  ///网络超时
  static const NETWORK_TIMEOUT = -2;

  ///网络返回数据格式化一次
  static const NETWORK_JSON_EXCEPTION = -3;

  static const SUCCESS = 200;

  static errorHandleFunction(code, message, noTip) {
    switch (code) {
      case NETWORK_ERROR:
        if(!noTip) {
          Fluttertoast.showToast(msg: GSYStrings.network_error);
        }
        return GSYStrings.network_error;
      case 401:
        //TODO 授权逻辑
        /*if (Actions.currentScene !== 'LoginPage') {
          Actions.reset("LoginPage");
        }*/
        if(!noTip) {
          Fluttertoast.showToast(msg: GSYStrings.network_error_401);
        }
        return GSYStrings.network_error_401; //401 Unauthorized
      case 403:
        if(!noTip) {
          Fluttertoast.showToast(msg: GSYStrings.network_error_403);
        }
        return GSYStrings.network_error_403;
      case 404:
        if(!noTip) {
          Fluttertoast.showToast(msg: GSYStrings.network_error_404);
        }
        return GSYStrings.network_error_404;
      case NETWORK_TIMEOUT:
        //超时
        if(!noTip) {
          Fluttertoast.showToast(msg: GSYStrings.network_error_timeout);
        }
        return GSYStrings.network_error_timeout;
      default:
        if(!noTip) {
          Fluttertoast.showToast(msg: GSYStrings.network_error_unknown + " " + message);
        }
        return GSYStrings.network_error_unknown;
    }
  }
}
