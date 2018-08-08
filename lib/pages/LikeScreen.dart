import 'package:flutter/material.dart';
import 'package:flutter_app/common/model/CommodityListBean.dart';
import 'package:flutter_app/common/model/Event.dart';
import 'package:flutter_app/pages/ProductDetail.dart';
import 'package:flutter_app/widget/GSYCardItem.dart';
import 'package:flutter_app/widget/GSYListState.dart';
import 'package:flutter_app/widget/GSYPullLoadWidget.dart';

class LikeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: LikePage(),
    );
  }
}

class LikePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LikeState();
  }
}

class _LikeState extends GSYListState<LikePage> with WidgetsBindingObserver {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(2.0),
        child: GSYPullLoadWidget(
          pullLoadWidgetControl,
          (BuildContext context, int index) =>
              _renderEventItem(pullLoadWidgetControl.dataList[index]),
          handleRefresh,
          onLoadMore,
          refreshKey: refreshIndicatorKey,
        ),
      ),
    );
  }

  _renderEventItem(CommodityListBean c) {
    return new ProductEventItem(
      c,
    );
  }

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

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {}

  @override
  requestRefresh() {
    EventDao.getEventReceived(_getStore(), page: page);
  }

  @override
  requestLoadMore() {
    EventDao.getEventReceived(_getStore(), page: page);
  }

  @override
  bool get isRefreshFirst => true;
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
              Image.network(commodityListBean.thumbnail),
              Text(commodityListBean.commodityBrandNameEn),
              Text(commodityListBean.recommendDescription),
            ],
          )),
    );
  }
}
