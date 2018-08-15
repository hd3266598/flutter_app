import 'package:flutter_app/common/model/LikeProductResponseModel.dart';
import 'package:redux/redux.dart';

final ProductListReducer = combineReducers<List<CommodityListBean>>([
  TypedReducer<List<CommodityListBean>, RefreshEventAction>(_refresh),
  TypedReducer<List<CommodityListBean>, LoadMoreEventAction>(_loadMore)
]);

List<CommodityListBean> _refresh(List<CommodityListBean> list, action) {
  list = List();
  if (action.list == null) {
    return list;
  } else {
    list.addAll(action.list);
    return list;
  }
}

List<CommodityListBean> _loadMore(List<CommodityListBean> list, action) {
  if (action.list != null) {
    list.addAll(action.list);
  }
  return list;
}

class RefreshEventAction {
  final List<CommodityListBean> list;

  RefreshEventAction(this.list);
}

class LoadMoreEventAction {
  final List<CommodityListBean> list;

  LoadMoreEventAction(this.list);
}
