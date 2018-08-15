import 'package:json_annotation/json_annotation.dart';

part 'LikeProductResponseModel.g.dart';

@JsonSerializable()
class LikeProductResponseModel extends Object
    with _$LikeProductResponseModelSerializerMixin {
  @JsonKey(nullable: false)
  List<CommodityListBean> userCollectionCommodityInfoList;
  @JsonKey(nullable: false)
  List<CommodityListBean> tenRandomCommodityList;

  LikeProductResponseModel(this.userCollectionCommodityInfoList,
      this.tenRandomCommodityList);

  factory LikeProductResponseModel.formJson(Map<String, dynamic> json) =>
      _$LikeProductResponseModelFromJson(json);
}

@JsonSerializable(includeIfNull: false)
class CommodityListBean extends Object with _$CommodityListBeanSerializerMixin {
  double marketPrice;
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
  int id;
  double rentPrice;
  String shelveStatus;
  String commodityBackShelveNotifyStatus;
  List<String> labels;

  CommodityListBean(this.marketPrice,
      this.src,
      this.thumbnail,
      this.freezedQuota,
      this.commodityBrandNameCn,
      this.collected,
      this.logoSrc,
      this.recommendDescription,
      this.rentCycle,
      this.avaliableDays,
      this.name,
      this.commodityBrandNameEn,
      this.id,
      this.rentPrice,
      this.shelveStatus,
      this.commodityBackShelveNotifyStatus,
      this.labels);

  factory CommodityListBean.fromJson(Map<String, dynamic> json) =>
      _$CommodityListBeanFromJson(json);
}
