import 'package:json_annotation/json_annotation.dart';

part 'CommodityListBean.g.dart';

@JsonSerializable()
class CommodityListBean extends Object with _$CommodityListBeanSerializerMixin{

  Object marketPrice;
  String src;
  String thumbnail;
  int freezedQuota;
  String commodityBrandNameCn;
  bool collected;
  String logoSrc;
  String recommendDescription;
  String rentCycle;
  int avaliableDays;
  String name;
  String commodityBrandNameEn;
  String id;
  Object rentPrice;
  String shelveStatus;
  String commodityBackShelveNotifyStatus;
  List<String> labels;

  CommodityListBean(this.marketPrice, this.src, this.thumbnail,
      this.freezedQuota, this.commodityBrandNameCn, this.collected,
      this.logoSrc, this.recommendDescription, this.rentCycle,
      this.avaliableDays, this.name, this.commodityBrandNameEn, this.id,
      this.rentPrice, this.shelveStatus, this.commodityBackShelveNotifyStatus,
      this.labels);

  factory CommodityListBean.fromJson(Map<String, dynamic> json) =>_$CommodityListBeanFromJson(json);
}