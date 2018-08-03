import 'package:flutter/material.dart';
import 'package:flutter_app/pages/HomeScreen.dart';
import 'package:flutter_app/pages/ProductScreen.dart';
import 'package:flutter_app/pages/LikeScreen.dart';
import 'package:flutter_app/pages/MineScreen.dart';

class MainPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MainPageState();
  }
}

class MainPageState extends State<MainPage> {
  PageController pageController;
  int page = 0;
  String title = "首页";

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: this.page);
  }

  void onTap(int index) {
    pageController.jumpToPage(index);
  }

  void onPageChanged(int page) {
    setState(() {
      this.page = page;
      switch (page) {
        case 0:
          this.title = '首页';
          break;
        case 1:
          this.title = '商品';
          break;
        case 2:
          this.title = '喜欢';
          break;
        case 3:
          this.title = '我的';
          break;
        default:
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var list = List<BottomNavigationBarItem>();
    list.add(BottomNavigationBarItem(
        backgroundColor: Colors.blue,
        icon: Icon(Icons.home),
        title: Text('首页')));
    list.add(BottomNavigationBarItem(
        backgroundColor: Colors.blue,
        icon: Icon(Icons.shopping_basket),
        title: Text('商品')));
    list.add(BottomNavigationBarItem(
        backgroundColor: Colors.blue,
        icon: Icon(Icons.star),
        title: Text('喜欢')));
    list.add(BottomNavigationBarItem(
        backgroundColor: Colors.blue,
        icon: Icon(Icons.person),
        title: Text('我的')));

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(title),
      ),
      body: PageView(
        children: <Widget>[
          HomeScreen(),
          ProductScreen(),
          LikeScreen(),
          MineScreen()
        ],
        controller: pageController,
        onPageChanged: onPageChanged,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: list,
        onTap: onTap,
        currentIndex: page,
      ),
    );
  }
}
