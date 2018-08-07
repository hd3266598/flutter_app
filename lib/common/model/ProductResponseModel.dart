import 'package:json_annotation/json_annotation.dart';
import 'package:flutter_app/common/model/CommodityListBean.dart';

part 'ProductResponseModel.g.dart';

@JsonSerializable()
class ProductResponseModel extends Object with _$ProductResponseModelSerializerMixin {
  int totalCount;
  List<CommodityListBean> commodityList;

  ProductResponseModel(this.totalCount, this.commodityList);

  factory ProductResponseModel.fromJson(Map<String, dynamic> json) =>_$ProductResponseModelFromJson(json);
}


