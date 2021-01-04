import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WrapPage extends StatefulWidget {
  WrapPage({Key key, @required this.title}) : super(key: key);
  final String title;

  @override
  _WrapPageState createState() => _WrapPageState();
}

class _WrapPageState extends State<WrapPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Text("Wrap"),
      ),
    );
  }
}
