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
    if (res != null) {
      List<CommodityListBean> list = new List();
      var likeProductResponseModel =
          LikeProductResponseModel.formJson(res.data);
      list = likeProductResponseModel.userCollectionCommodityInfoList;
      print(list.toString());
      store.dispatch(new RefreshEventAction(list));
      return list;
    } else {
      return null;
    }
  }
}
