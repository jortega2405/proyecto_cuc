import 'package:flutter/material.dart';

import '../styles.dart';

class RoundedButton extends StatelessWidget {
  const RoundedButton({
    Key key, @required this.buttonText,
  }) : super(key: key);

  final String buttonText;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.grey[800].withOpacity(0.5), 
        borderRadius: BorderRadius.circular(17),
      ),
      child: FlatButton(
        onPressed: () {},
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15.0),
          child: Text(
          buttonText,
          style: kBodyText,
      ),
        ),),
    );
  }
}


