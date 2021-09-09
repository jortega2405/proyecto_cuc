import 'package:flutter/material.dart';
import 'package:proyecto_cuc/pages/forgot_password.dart';
import 'package:proyecto_cuc/pages/login_page.dart';
import 'package:proyecto_cuc/pages/new_account.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Proyecto CUC',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: 'LoginPage',
      routes: {
        'LoginPage': (context) => LoginPage(),
        'ForgotPassword': (context) => ForgotPassword(),
        'CreateAccout' : (context) => NewAccount(),
      },
    );
  }
}

