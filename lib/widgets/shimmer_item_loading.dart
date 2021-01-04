import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerItemLoading extends StatelessWidget {
  const ShimmerItemLoading({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double containerWidth = 220.0;
    return ListView.separated(
      padding: EdgeInsets.all(10),
      itemCount: 15,
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: Colors.grey[300],
          highlightColor: Colors.white,
          child: ListTile(
              title: Container(
                width: containerWidth,
                color: Colors.grey,
                child: Container(
                  width: 200,
                  height: 40,
                ),
              ),
              trailing: Container(
                height: 20,
                width: 20,
                color: Colors.grey,
              )),
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return Divider(
          indent: 20,
          endIndent: 20,
        );
      },
    );
  }
}
