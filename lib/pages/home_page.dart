
import 'package:flutter/material.dart';
import 'package:proyecto_cuc/components/botton_nav_bar.dart';


import '../enums.dart';
import 'home/components/body.dart';

class HomePage extends StatelessWidget {
  static String routeName = "/home";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(),
      bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.home),
    );
  }
}
