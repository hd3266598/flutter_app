import 'package:flutter/material.dart';
import 'package:flutter_app/common/style/GSYStyle.dart';
import 'package:flutter_app/widget/control/GSYPullLoadWidgetControl.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

///通用下上刷新控件
class GSYPullLoadGirdWidget extends StatefulWidget {
  ///item渲染
  final IndexedWidgetBuilder itemBuilder;

  ///加载更多回调
  final RefreshCallback onLoadMore;

  ///下拉刷新回调
  final RefreshCallback onRefresh;

  ///控制器，比如数据和一些配置
  final GSYPullLoadWidgetControl control;

  final Key refreshKey;

  GSYPullLoadGirdWidget(
      this.control, this.itemBuilder, this.onRefresh, this.onLoadMore,
      {this.refreshKey});

  @override
  State createState() {
    return _GSYPullLoadGirdWidgetState(this.control, this.itemBuilder,
        this.onRefresh, this.onLoadMore, this.refreshKey);
  }
}

class _GSYPullLoadGirdWidgetState extends State<GSYPullLoadGirdWidget> {
  final IndexedWidgetBuilder itemBuilder;

  final RefreshCallback onLoadMore;

  final RefreshCallback onRefresh;

  final Key refreshKey;

  GSYPullLoadWidgetControl control;

  _GSYPullLoadGirdWidgetState(this.control, this.itemBuilder, this.onRefresh,
      this.onLoadMore, this.refreshKey);

  final ScrollController _scrollController = new ScrollController();

  @override
  void initState() {
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        if (this.onLoadMore != null && this.control.needLoadMore) {
          this.onLoadMore();
        }
      }
    });
    super.initState();
  }

  _getListCount() {
    if (control.needHeader) {
      return (control.dataList.length > 0)
          ? control.dataList.length + 2
          : control.dataList.length + 1;
    } else {
      if (control.dataList.length == 0) {
        return 1;
      }
      return (control.dataList.length > 0)
          ? control.dataList.length + 1
          : control.dataList.length;
    }
  }

  @override
  Widget build(BuildContext context) {
    return new RefreshIndicator(
      key: refreshKey,
      onRefresh: onRefresh,
      child: GridView.count(
        controller: _scrollController,
        crossAxisCount: 2,
        children: List.generate(control.dataList.length, (index) {
          if (!control.needHeader &&
              index == control.dataList.length &&
              control.dataList.length != 0) {
            return _buildProgressIndicator();
          } else if (control.needHeader &&
              index == _getListCount() - 1 &&
              control.dataList.length != 0) {
            return _buildProgressIndicator();
          } else if (!control.needHeader && control.dataList.length == 0) {
            return _buildEmpty();
          } else {
            return itemBuilder(context, index);
          }
        }),
      ),
    );
  }

  Widget _buildEmpty() {
    return new Container(
      height: MediaQuery.of(context).size.height - 100,
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          FlatButton(
            onPressed: () {},
            child: new Image(
                image: new AssetImage(GSYICons.DEFAULT_USER_ICON),
                width: 70.0,
                height: 70.0),
          ),
          Container(
            child: Text(GSYStrings.app_empty, style: GSYConstant.normalText),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressIndicator() {
    Widget bottomWidget = (control.needLoadMore)
        ? new Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
                new SpinKitRotatingCircle(color: Color(GSYColors.primaryValue)),
                new Container(
                  width: 5.0,
                ),
                new Text(
                  GSYStrings.load_more_text,
                  style: GSYConstant.smallTextBold,
                )
              ])
        : new Text(GSYStrings.load_more_not, style: GSYConstant.smallTextBold);
    return new Padding(
      padding: const EdgeInsets.all(20.0),
      child: new Center(
        child: bottomWidget,
      ),
    );
  }
}
