import 'package:flutter/material.dart';
import 'package:proyecto_cuc/widgets/bg_image.dart';
import 'package:proyecto_cuc/widgets/pass_input.dart';
import 'package:proyecto_cuc/widgets/rounded_button.dart';
import 'package:proyecto_cuc/widgets/text_input.dart';

import '../styles.dart';

class NewAccount extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        BgImage(image: 'assets/images/login3.jpeg'),
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
              'New Account',
              style: kBodyText,
            ),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            child: SafeArea(
              child: Column(
            children: [
              Column(
                children: [
                  Container(
                    width: size.width * 0.8,
                    child: Text(
                      "Please provide the following information",
                      style: kBodyText,
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: TextInput(
                      icon: Icons.person,
                      hint: 'Name',
                      inputType: TextInputType.name,
                      inputAction: TextInputAction.next,
                      ),
                  ),
                  SizedBox(height: 4),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: TextInput(
                      icon: Icons.phone,
                      hint: 'Phone',
                      inputType: TextInputType.phone,
                      inputAction: TextInputAction.next,
                      ),
                  ),
                  SizedBox(height: 4),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: TextInput(
                      icon: Icons.email_outlined,
                      hint: 'Email',
                      inputType: TextInputType.emailAddress,
                      inputAction: TextInputAction.next,
                      ),
                  ),
                  SizedBox(height: 4),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: PassInput(
                      icon: Icons.lock,
                      hint: 'Password',
                      inputAction: TextInputAction.next,
                      ),
                  ),
                   Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: PassInput(
                      icon: Icons.lock,
                      hint: 'Confirm Password',
                      inputAction: TextInputAction.done,
                      ),
                  ),
                  SizedBox(height: 40),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: RoundedButton(
                      buttonText: 'Submit'
                    ),
                  ),
                  SizedBox(height: 10),
                  GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Text(
                      'Already has an account',
                      style: kBodyText,
                    ),
                  ),
                ],
              )
            ],
          ),
          ),
          ),
        ),
      ],
    );
  }
}