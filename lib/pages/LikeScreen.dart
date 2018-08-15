import 'package:flutter/material.dart';
import 'package:flutter_app/common/dao/ProductDao.dart';
import 'package:flutter_app/common/model/LikeProductResponseModel.dart';
import 'package:flutter_app/common/redux/GSYState.dart';
import 'package:flutter_app/pages/ProductDetail.dart';
import 'package:flutter_app/widget/GSYCardItem.dart';
import 'package:flutter_app/widget/GSYListState.dart';
import 'package:flutter_app/widget/GSYPullLoadWidget.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

class LikeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LikeState();
  }
}

class _LikeState extends GSYListState<LikeScreen> with WidgetsBindingObserver {
  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

//  @override
//  void didChangeDependencies() {
//    pullLoadWidgetControl.dataList = _getStore().state.eventList;
//    if (pullLoadWidgetControl.dataList.length == 0) {
//      showRefreshLoading();
//    }
//    super.didChangeDependencies();
//  }
//
//  @override
//  void didChangeAppLifecycleState(AppLifecycleState state) {
//    if (state == AppLifecycleState.resumed) {
//      if (pullLoadWidgetControl.dataList.length != 0) {
//        showRefreshLoading();
//      }
//    }
//  }

  @override
  requestRefresh() {
    return ProductDao.getLikeProductListResponse(_getStore());
  }

  @override
  requestLoadMore() {
    return ProductDao.getLikeProductListResponse(_getStore());
  }

  Store<GSYState> _getStore() {
    return new Store<GSYState>(appReducer, initialState: new GSYState());
  }

  @override
  bool get isRefreshFirst => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return StoreProvider(
        store: _getStore(),
        child: GSYPullLoadWidget(
            pullLoadWidgetControl,
                (BuildContext context, int index) =>
                _renderEventItem(pullLoadWidgetControl.dataList[index]),
            handleRefresh,
            onLoadMore,
            refreshKey: refreshIndicatorKey));
  }

  _renderEventItem(CommodityListBean c) {
    return new ProductEventItem(
      c,
    );
  }
}

class ProductEventItem extends StatelessWidget {
  final CommodityListBean commodityListBean;

  ProductEventItem(this.commodityListBean);

  @override
  Widget build(BuildContext context) {
    return GSYCardItem(
      child: FlatButton(
          onPressed: () {
            Navigator.pushNamed(context, ProductDetailPage.sName);
          },
          child: Column(
            children: <Widget>[
              Image.network(
                  'https://resource.starluxe.cn' + commodityListBean.thumbnail),
              Text(commodityListBean.commodityBrandNameEn),
              Text(commodityListBean.name),
            ],
          )),
    );
  }
}
