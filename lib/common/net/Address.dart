import 'package:flutter_app/common/config/Config.dart';

///地址数据
class Address {
  //release
//  static const String host = "http://app.starluxe.cn:8080/";
//  static const String hostWeb = "http://app.starluxe.cn/#";

  //dev
  static const String host = "http://api-qa.xiangxing365.com/";
  static const String hostWeb = "http://test.starluxe.cn/#";

  ///获取授权  post
  static getAuthorization() {
    return "${host}authorizations";
  }

  ///搜索 get
  static search(q, sort, order, type, page, [pageSize = Config.PAGE_SIZE]) {
    if (type == 'user') {
      return "${host}search/users?q=$q&page=$page&per_page=$pageSize";
    }
    sort ??= "best%20match";
    order ??= "desc";
    page ??= 1;
    pageSize ??= Config.PAGE_SIZE;
    return "${host}search/repositories?q=$q&sort=$sort&order=$order&page=$page&per_page=$pageSize";
  }

  static getPersonLikeProductList() {
    return "${host}user/commodityCollection/findUserCollectionCommodityInfoList";
  }

  static getVenusConfig() {
    return "${host}config";
  }
}
