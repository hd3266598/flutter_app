import 'package:flutter_app/common/model/LikeProductResponseModel.dart';
import 'package:flutter_app/common/net/Address.dart';
import 'package:flutter_app/common/net/Api.dart';
import 'package:flutter_app/common/redux/GSYState.dart';
import 'package:flutter_app/common/redux/ProductListReducer.dart';
import 'package:redux/redux.dart';

class ProductDao {
  static getLikeProductListResponse(Store<GSYState> store) async {
    var res = await HttpManager.netFetch(
        Address.getPersonLikeProductList(), null, null, null);
    if (res != null && res.result) {
      var likeProductResponseModel =
          LikeProductResponseModel.formJson(res.data);
      store.dispatch(new RefreshEventAction(
          likeProductResponseModel.userCollectionCommodityInfoList));
      return likeProductResponseModel.userCollectionCommodityInfoList;
    } else {
      return null;
    }
  }
}
