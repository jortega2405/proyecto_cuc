import 'package:flutter/material.dart';


class DiscountBanner extends StatelessWidget {
  const DiscountBanner({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 90,
      width: double.infinity,
      margin: EdgeInsets.all(20),
      padding: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 15,
      ),
      decoration: BoxDecoration(
        color: Color(0xFF4A3298),
        borderRadius: BorderRadius.circular(20),
      ),
      child: GestureDetector(
        onTap: () {
          print("Click");
        },
          child: Text.rich(
          TextSpan(
            style: TextStyle(color: Colors.white),
            children: [
               TextSpan(
                text: "Let's talk about something\n",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextSpan(text: "Busca a tu contactos"),
            ],
          ),
        ),
      ),
    );
  }
}