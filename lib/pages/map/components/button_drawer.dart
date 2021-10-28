import 'package:flutter/material.dart';

import 'map_controller.dart';

class ButtonDrawer extends StatelessWidget {
  const ButtonDrawer({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MapController _con = new MapController();
    return Container(
        alignment: Alignment.centerLeft,
        child: IconButton(
          onPressed: (){
          },
          icon: Icon(
            Icons.menu,
            color: Colors.white,
          ),
        ),
      );
  }
}