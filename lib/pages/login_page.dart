import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:proyecto_cuc/main.dart';
import 'package:proyecto_cuc/pages/new_account.dart';
import 'package:proyecto_cuc/styles.dart';
import 'package:proyecto_cuc/widgets/bg_image.dart';
import 'package:proyecto_cuc/widgets/pass_input.dart';
import 'package:proyecto_cuc/widgets/text_input.dart';
import '../widgets/widgets.dart';

class LoginPage extends StatelessWidget {

TextEditingController emailTextEditingController = TextEditingController();
TextEditingController passTextEditingController = TextEditingController();


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
                              controller: emailTextEditingController,
                              icon: Icons.email,
                              hint: 'Email',
                              inputType: TextInputType.emailAddress,
                              inputAction: TextInputAction.next,
                            ),
                            PassInput(
                              controller: passTextEditingController,
                              icon: Icons.lock,
                              hint: 'Password',
                              inputAction: TextInputAction.done,
                            ),
                            // GestureDetector(
                            //   onTap: () => Navigator.pushNamed(context, 'HomePage'),
                            //   child: Text(
                            //     'Forgot Password?',
                            //     style: kBodyText ,
                            //   )
                            // )
                          ],
                        ),
                        Column(
                          children: [
                            SizedBox(height: 70), 
                            RaisedButton(
                              color: Colors.grey[800].withOpacity(0.5),
                              textColor: Colors.white,
                              child: Container(
                                height: 50,
                                child: Center(
                                  child: Text(
                                    "Login",
                                    style: TextStyle(fontSize: 18.0),
                                  ),
                                ),
                              ),
                              shape: new RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24),
                              ),
                              onPressed: () {
                                if (!emailTextEditingController.text.contains("@")) {
                                 displayToastMessage("Email is not valid.", context);
                                }
                                else if (passTextEditingController.text.isEmpty) {
                                  displayToastMessage("Password is mandatory", context);
                                }
                                else{
                                  loginAndAuthenticateUser(context);
                                }

                              },
                            ),
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

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  void loginAndAuthenticateUser(BuildContext context) async {
    final User firebaseUser = (await _firebaseAuth.signInWithEmailAndPassword(
      email: emailTextEditingController.text,
      password: passTextEditingController.text
    ).catchError((errMsg){
      displayToastMessage("Error: " + errMsg.toString(), context);
    })).user;

    if (firebaseUser != null) {
      //save user info to database
      userRef.child(firebaseUser.uid).once().then((DataSnapshot snap){
        if(snap.value != null){
          Navigator.pushNamed(context, 'MapScreen');
          displayToastMessage("You are logged-in now", context);
        }else{
          _firebaseAuth.signOut();
          displayToastMessage("No records exists for this user. Please create a new account", context);
        }
      });
    }else{
      //error ocurred - display error message
      displayToastMessage("Error occurred, ", context);
    }
  }
}

