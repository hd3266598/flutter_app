import 'package:flutter/material.dart';
import 'package:flutter_app/pages/HomeScreen.dart';
import 'package:flutter_app/pages/LikeScreen.dart';
import 'package:flutter_app/pages/MineScreen.dart';
import 'package:flutter_app/pages/ProductScreen.dart';

class MainPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MainPageState();
  }
}

class MainPageState extends State<MainPage> {
  PageController pageController;
  int page = 0;
  List titles = ['首页', '商品', '喜欢', '我的'];

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
    });
  }

  @override
  Widget build(BuildContext context) {
    var list = List<BottomNavigationBarItem>();
    list.add(BottomNavigationBarItem(
        backgroundColor: Colors.blue,
        icon: Icon(Icons.home),
        title: Text(titles[0])));
    list.add(BottomNavigationBarItem(
        backgroundColor: Colors.blue,
        icon: Icon(Icons.shopping_basket),
        title: Text(titles[1])));
    list.add(BottomNavigationBarItem(
        backgroundColor: Colors.blue,
        icon: Icon(Icons.star),
        title: Text(titles[2])));
    list.add(BottomNavigationBarItem(
        backgroundColor: Colors.blue,
        icon: Icon(Icons.person),
        title: Text(titles[3])));

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(titles[page]),
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
