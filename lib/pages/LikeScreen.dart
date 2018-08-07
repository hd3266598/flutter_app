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

class _LikeState extends GSYListState<LikePage> with WidgetsBindingObserver{
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

  _renderEventItem(Event e) {
//    EventViewModel eventViewModel = EventViewModel.fromEventMap(e);
//    return new EventItem(
//      eventViewModel,
//      onPressed: () {
//        EventUtils.ActionUtils(context, e, "");
//      },
//    );
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
  void didChangeAppLifecycleState(AppLifecycleState state) {

  }


  @override
  requestRefresh() {

  }


  @override
  requestLoadMore() {

  }

  @override
  bool get isRefreshFirst => true;
}
