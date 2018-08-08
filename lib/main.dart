import 'package:flutter/material.dart';
import 'package:flutter_app/pages/MainPage.dart';
import 'package:flutter_app/pages/ProductDetail.dart';

void main() => runApp(new MaterialApp(
    theme: new ThemeData.light(),
    home: new MainPage(),
    routes: {
      ProductDetailPage.sName: (context) {
        return ProductDetailPage();
      },
    }));
