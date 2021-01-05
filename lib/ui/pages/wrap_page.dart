import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WrapPage extends StatefulWidget {
  WrapPage({Key key}) : super(key: key);
  

  @override
  _WrapPageState createState() => _WrapPageState();
}

class _WrapPageState extends State<WrapPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: Center(
        child: Text("Wrap"),
      ),
    );
  }
}
