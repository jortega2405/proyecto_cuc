import 'package:flutter/material.dart';

import 'map_controller.dart';

class CenterPosition extends StatefulWidget {
  const CenterPosition({Key key}) : super(key: key);

  @override
  _CenterPositionState createState() => _CenterPositionState();
}

class _CenterPositionState extends State<CenterPosition> {

  MapController _con = new MapController();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _con.centerPosition,
        child: Container(
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
      ),
    );
  }
}