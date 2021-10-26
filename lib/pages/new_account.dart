import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:proyecto_cuc/main.dart';
import 'package:proyecto_cuc/widgets/bg_image.dart';
import 'package:proyecto_cuc/widgets/pass_input.dart';
import 'package:proyecto_cuc/widgets/text_input.dart';

import '../styles.dart';

class NewAccount extends StatelessWidget {

  TextEditingController nameTextEditingController = TextEditingController();
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController phoneTextEditingController = TextEditingController();
  TextEditingController passTextEditingController = TextEditingController();
  
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
                      controller: nameTextEditingController,
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
                      controller: phoneTextEditingController,
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
                      controller: emailTextEditingController,
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
                      controller: passTextEditingController,
                      icon: Icons.lock,
                      hint: 'Password',
                      inputAction: TextInputAction.next,
                      ),
                  ),
                  SizedBox(height: 40),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: RaisedButton(
                      color: Colors.grey[800].withOpacity(0.5),
                      textColor: Colors.white,
                      child: Container(
                        height: 40,
                        child: Center(
                          child: Text(
                            "Submit",
                            style: TextStyle(fontSize: 18.0),
                          ),
                        ),
                      ),
                      shape: new RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                      onPressed: () {
                        if (nameTextEditingController.text.length < 4) {
                          displayToastMessage("Name must be atleast 4 characters.", context);
                        }
                        else if (!emailTextEditingController.text.contains("@")) {
                          displayToastMessage("Email is not valid.", context);
                        }else if (phoneTextEditingController.text.isEmpty) {
                          displayToastMessage("Phone number is mandatory.", context);
                        }
                        else if (passTextEditingController.text.length < 6) {
                          displayToastMessage("Password must be atleast 6 characters.", context);
                        }else{
                          registerNewUSer(context);
                        }
                      },
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

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  registerNewUSer(BuildContext context) async {
    final User firebaseUser = (await _firebaseAuth.createUserWithEmailAndPassword(
      email: emailTextEditingController.text,
      password: passTextEditingController.text
    ).catchError((errMsg){
      displayToastMessage("Error: " + errMsg.toString(), context);
    })).user;
    //user created
    if (firebaseUser != null) {
      //save user info to database
      Map userDataMap = {
        "name": nameTextEditingController.text.trim(),
        "email": emailTextEditingController.text.trim(),
        "phone": phoneTextEditingController.text.trim(),
       // "name": nameTextEditingController.text,
      };
      
      userRef.child(firebaseUser.uid).set(userDataMap);
      displayToastMessage("Congrats, your account has been created", context);

      Navigator.pushNamed(context, 'LoginPage');

    }else{
      //error ocurred - display error message
      displayToastMessage("New user account has not been created", context);
    }
  }
}

displayToastMessage(String message, BuildContext context){
  Fluttertoast.showToast(msg: message);
}
