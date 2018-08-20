import 'package:json_annotation/json_annotation.dart';

part 'Config.g.dart';

@JsonSerializable()
class Config extends Object with _$ConfigSerializerMixin {
  String wechatMpAppId;
  String envirement;
  String wechatMpAppSecret;
  String resourceUrlPrefix;

  Config(this.wechatMpAppId, this.envirement, this.wechatMpAppSecret,
      this.resourceUrlPrefix);

  factory Config.formJson(Map<String, dynamic> json) => _$ConfigFromJson(json);
}
