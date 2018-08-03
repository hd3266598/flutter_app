import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

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

class _LikeState extends State<LikePage> {
  Dio dio = Dio();
  @override
  Widget build(BuildContext context) {
   return Scaffold(
     body: new ListView(children: <Widget>[],),
   );
  }

  void _getLikeData(){
    dio.get("")
  }
}
