import 'dart:async';

import 'package:flutter/material.dart';
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

class _LikeState extends GSYListState<LikePage> {
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


  @override
  void initState() {
    super.initState();
  }

  @override
  Future<Null> handleRefresh() async {}

  @override
  Future<Null> onLoadMore() async {}

  @override
  bool get isRefreshFirst => true;
}
