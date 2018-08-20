import 'package:flutter/material.dart';

class NewLikeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _NewLikeScreenState();
  }
}

class _NewLikeScreenState extends State<NewLikeScreen>
    with WidgetsBindingObserver {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
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
}
