import 'package:json_annotation/json_annotation.dart';

part 'Event.g.dart';

@JsonSerializable()
class Event extends Object with _$EventSerializerMixin {
  String code;
  String message;
  String url;
  int status;

  Event(this.code, this.message, this.url, this.status);

  factory Event.formJson(Map<String, dynamic> json) => _$EventFromJson(json);
}
