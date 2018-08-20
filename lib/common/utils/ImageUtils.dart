import 'package:flutter_app/common/utils/StringUtils.dart';

class ImageUtils {
  static getImageUrl(String resConfig, String url) {
    return StringUtils.containsIgnoreCase(url, "http") ? url : resConfig + url;
  }
}
