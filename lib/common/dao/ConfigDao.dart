import 'package:flutter_app/common/config/Constants.dart';
import 'package:flutter_app/common/local/LocalStorage.dart';
import 'package:flutter_app/common/model/Config.dart';
import 'package:flutter_app/common/net/Address.dart';
import 'package:flutter_app/common/net/Api.dart';

class ConfigDao {
  static getVenusConfig() async {
    var res =
        await HttpManager.netFetch(Address.getVenusConfig(), null, null, null);
    if (res != null && res.result) {
      Config config = Config.formJson(res.data);
      await LocalStorage.save(
          Constants.STAR_WE_CHAT_APP_ID, config.wechatMpAppId);
      await LocalStorage.save(Constants.STAR_ENVIRONMENT, config.envirement);
      await LocalStorage.save(
          Constants.STAR_WE_CHAT_MP_APP_SECRET, config.wechatMpAppSecret);
      await LocalStorage.save(
          Constants.STAR_RESOURCE_URL_PREFIX, config.resourceUrlPrefix);
    }
  }
}
