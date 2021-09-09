import 'package:flutter/material.dart';
import 'package:proyecto_cuc/styles.dart';
import 'package:proyecto_cuc/widgets/bg_image.dart';
import 'package:proyecto_cuc/widgets/pass_input.dart';
import 'package:proyecto_cuc/widgets/rounded_button.dart';
import 'package:proyecto_cuc/widgets/text_input.dart';
import '../widgets/widgets.dart';

class LoginPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        BgImage(image: 'assets/images/login1.png'),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            child: SafeArea(
              child: Column(
                children: [
                  Container(
                    height: 170,
                    child: Center(
                      child: Text(
                        'Round Trip',
                        style: kHeading,
                      ),
                    ),
                  ),
                  SizedBox(height: 100),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Column(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            TextInput(
                              icon: Icons.email,
                              hint: 'Email',
                              inputType: TextInputType.emailAddress,
                              inputAction: TextInputAction.next,
                            ),
                            PassInput(
                              icon: Icons.lock,
                              hint: 'Password',
                              inputAction: TextInputAction.done,
                            ),
                            GestureDetector(
                              onTap: () => Navigator.pushNamed(context, 'ForgotPassword'),
                              child: Text(
                                'Forgot Password?',
                                style: kBodyText ,
                              )
                            )
                          ],
                        ),
                        Column(
                          children: [
                            SizedBox(height: 70), 
                            RoundedButton(buttonText: 'Login'),
                            SizedBox(height: 30),
                            Container(
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom:  BorderSide(
                                  color: Colors.white,
                                  width: 1, 
                                  ),
                                ),
                              ),
                              child: GestureDetector(
                                  onTap: () => Navigator.pushNamed(context, 'CreateAccout'),
                                  child: Text(
                                  'Create New Account',
                                  style: kBodyText,
                                ),
                              ),
                            ), 
                            SizedBox(height: 30),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}

