import 'package:flutter/material.dart';
import 'package:proyecto_cuc/styles.dart';
import 'package:proyecto_cuc/widgets/widgets.dart';

class ForgotPassword extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        BgImage(image: 'assets/images/login2.jpeg'),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back_ios,
                color: Colors.white,  
              ),
            ),
            title: Text(
              'Forgot Password',
              style: kBodyText,
            ),
            centerTitle: true,
          ),
          body: Column(
            children: [
              Column(
                children: [
                  Container(
                    width: size.width * 0.8,
                    child: Text(
                      "Please enter your email we will send you an email to reset your password",
                      style: kBodyText,
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: TextInput(
                      icon: Icons.email_outlined,
                      hint: 'Email',
                      inputType: TextInputType.emailAddress,
                      inputAction: TextInputAction.done,
                      ),
                  ),
                  SizedBox(height: 70),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: RoundedButton(
                      buttonText: 'Submit'
                    ),
                  ),
                ],
              )
            ],
          ),
        )
      ],
    );
  }
}