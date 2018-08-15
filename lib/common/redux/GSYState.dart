import 'package:flutter_app/common/model/LikeProductResponseModel.dart';
import 'package:flutter_app/common/redux/ProductListReducer.dart';

/**
 * Redux全局State
 * Created by guoshuyu
 * Date: 2018-07-16
 */

class GSYState {
  List<CommodityListBean> eventList = new List();

  GSYState({this.eventList});
}

GSYState appReducer(GSYState state, action) {
  return GSYState(eventList: ProductListReducer(state.eventList, action));
}
