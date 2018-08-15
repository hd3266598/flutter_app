import 'dart:collection';

import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_app/common/config/Config.dart';
import 'package:flutter_app/common/local/LocalStorage.dart';
import 'package:flutter_app/common/net/Code.dart';
import 'package:flutter_app/common/net/ResultData.dart';

///http请求
class HttpManager {
  static const CONTENT_TYPE_JSON = "application/json";
  static const CONTENT_TYPE_FORM = "application/x-www-form-urlencoded";
  static Map optionParams = {
    "timeoutMs": 15000,
    "token":
    'Venus eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiIxMzcyMDMzMDc4NCIsImNyZWF0ZWRfZGF0ZSI6MTUzMzc4MTk1NTM1MSwiZXhwIjoxNTM2MzczOTU1LCJqdGkiOjE0NTl9.lsAV8LvTw4AmnqX2j7hr9mLljiwkMqcAjTGV1NJ9LcGsEQwJu176rV6alaH5P4BvnvQKHQYh2HZ_IhqRe4jvwA',
    "authorizationCode":
    'Venus eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiIxMzcyMDMzMDc4NCIsImNyZWF0ZWRfZGF0ZSI6MTUzMzc4MTk1NTM1MSwiZXhwIjoxNTM2MzczOTU1LCJqdGkiOjE0NTl9.lsAV8LvTw4AmnqX2j7hr9mLljiwkMqcAjTGV1NJ9LcGsEQwJu176rV6alaH5P4BvnvQKHQYh2HZ_IhqRe4jvwA',
  };

  ///发起网络请求
  ///[ url] 请求url
  ///[ params] 请求参数
  ///[ header] 外加头
  ///[ option] 配置
  static netFetch(url, params, Map<String, String> header, Options option,
      {noTip = false}) async {
    //没有网络
    var connectivityResult = await (new Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      return new ResultData(
          Code.errorHandleFunction(Code.NETWORK_ERROR, "", noTip),
          false,
          Code.NETWORK_ERROR);
    }

    Map<String, String> headers = new HashMap();
    if (header != null) {
      headers.addAll(header);
    }

    //授权码
    if (optionParams["authorizationCode"] == null) {
      var authorizationCode = await getAuthorization();
      if (authorizationCode != null) {
        optionParams["authorizationCode"] = authorizationCode;
      }
    }

    headers["Authorization"] = optionParams["authorizationCode"];

    if (option != null) {
      option.headers = headers;
    } else {
      option = new Options(method: "get");
      option.headers = headers;
    }

    Dio dio = new Dio();

    dio.interceptor.request.onSend = (Options options) {
      if (Config.DEBUG) {
        debugPrint('请求方式: ' + options.method);
        debugPrint('请求url: ' + options.path);
        debugPrint('请求头: ' + option.headers.toString());
        if (params != null) {
          debugPrint('请求参数: ' + params.toString());
        }
        if (optionParams["authorizationCode"] != null) {
          debugPrint('authorizationCode: ' + optionParams["authorizationCode"]);
        }
      }
      // 在请求被发送之前做一些事情
      return options; //continue
      // 如果你想完成请求并返回一些自定义数据，可以返回一个`Response`对象或返回`dio.resolve(data)`。
      // 这样请求将会被终止，上层then会被调用，then中返回的数据将是你的自定义数据data.
      //
      // 如果你想终止请求并触发一个错误,你可以返回一个`DioError`对象，或返回`dio.reject(errMsg)`，
      // 这样请求将被中止并触发异常，上层catchError会被调用。
    };

    dio.interceptor.response.onSuccess = (Response response) {
      if (Config.DEBUG) {
        if (response != null) {
          debugPrint('返回参数: ' + response.toString());
        }
      }
      // 在返回响应数据之前做一些预处理
      return response; // continue
    };

    dio.interceptor.response.onError = (DioError e) {
      // 当请求失败时做一些预处理
      if (Config.DEBUG) {
        debugPrint('请求异常: ' + e.toString());
      }
      return DioError; //continue
    };

    Response response;
    try {
      response = await dio.request(url, data: params, options: option);
    } on DioError catch (e) {
      Response errorResponse;
      if (e.response != null) {
        errorResponse = e.response;
      } else {
        errorResponse = new Response(statusCode: 666);
      }
      if (e.type == DioErrorType.CONNECT_TIMEOUT) {
        errorResponse.statusCode = Code.NETWORK_TIMEOUT;
      }
      return new ResultData(
          Code.errorHandleFunction(errorResponse.statusCode, e.message, noTip),
          false,
          errorResponse.statusCode);
    }

    try {
      if (option.contentType != null &&
          option.contentType.primaryType == "text") {
        return new ResultData(response.data, true, Code.SUCCESS);
      } else {
        var responseJson = response.data;
        if (response.statusCode == 201 && responseJson["token"] != null) {
          optionParams["authorizationCode"] = 'token ' + responseJson["token"];
          await LocalStorage.save(
              Config.TOKEN_KEY, optionParams["authorizationCode"]);
        }
      }
      if (response.statusCode == 200 || response.statusCode == 201) {
        return new ResultData(response.data, true, Code.SUCCESS,
            headers: response.headers);
      }
    } catch (e) {
      print(e.toString() + url);
      return new ResultData(response.data, false, response.statusCode,
          headers: response.headers);
    }
    return new ResultData(
        Code.errorHandleFunction(response.statusCode, "", noTip),
        false,
        response.statusCode);
  }

  ///清除授权
  static clearAuthorization() {
    optionParams["authorizationCode"] = null;
    LocalStorage.remove(Config.TOKEN_KEY);
  }

  ///获取授权token
  static getAuthorization() async {
    String token = await LocalStorage.get(Config.TOKEN_KEY);
    if (token == null) {
      String basic = await LocalStorage.get(Config.USER_BASIC_CODE);
      if (basic == null) {
        //提示输入账号密码
      } else {
        //通过 basic 去获取token，获取到设置，返回token
        return "Basic $basic";
      }
    } else {
      optionParams["authorizationCode"] = token;
      return token;
    }
  }
}
