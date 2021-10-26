import 'package:flutter/material.dart';

class CenterPosition extends StatelessWidget {
  const CenterPosition({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerRight,
      margin: EdgeInsets.symmetric(horizontal: 5),
      child: Card(
        shape: CircleBorder(),
        color: Colors.white,
        elevation: 4.0,
        child: Container(
          padding: EdgeInsets.all(10),
          child: Icon(
            Icons.location_searching,
            color: Colors.grey[600],
            size: 20,
          ),
        ),
      )
    );
  }
}