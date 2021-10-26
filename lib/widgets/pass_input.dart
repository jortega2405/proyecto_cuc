import 'package:flutter/material.dart';

import '../styles.dart';

class PassInput extends StatelessWidget {
  const PassInput({
    Key key, @required this.icon, @required this.hint, this.inputAction, this.controller,
  }) : super(key: key);
  final IconData icon;
  final String hint;
  final TextInputAction inputAction;
  final TextEditingController controller;


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[800].withOpacity(0.5),
          borderRadius: BorderRadius.circular(17),
        ),
        child: TextField(
          controller: controller,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(vertical: 20),
            border: InputBorder.none,
            hintText: hint,
            prefixIcon: Padding(
              padding: const EdgeInsets.symmetric(horizontal:20),
              child: Icon(
                icon,
                color: Colors.white,
                size: 30,
              ),
            ), 
            hintStyle: kBodyText2,
          ),
          obscureText: true,
          style: kBodyText,
          textInputAction: inputAction,
        ),
      ),
    );
  }
}