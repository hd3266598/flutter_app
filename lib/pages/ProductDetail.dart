import 'package:flutter/material.dart';

class ProductDetailPage extends StatelessWidget {
  static const String sName = "ProductDetailPage";

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: ProductDetailStatePage(),
    );
  }
}

class ProductDetailStatePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ProductDetailState();
  }
}

class ProductDetailState extends State<ProductDetailStatePage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold();
  }
}
