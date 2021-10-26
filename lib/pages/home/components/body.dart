import 'package:flutter/material.dart';
import 'package:proyecto_cuc/pages/home/components/discount.dart';


class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
           
            SizedBox(height: 10),
            DiscountBanner(),
            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}