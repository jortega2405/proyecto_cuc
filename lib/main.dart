import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:proyecto_cuc/pages/home_page.dart';
import 'package:proyecto_cuc/pages/login_page.dart';
import 'package:proyecto_cuc/pages/map/map.dart';
import 'package:proyecto_cuc/pages/new_account.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

DatabaseReference userRef = FirebaseDatabase.instance.reference().child("users");

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
      initialRoute: 'MapScreen',
      routes: {
        'LoginPage': (context) => LoginPage(),
        'HomePage': (context) => HomePage(),
        'CreateAccout' : (context) => NewAccount(),
        'MapScreen': (context) => MapScreen(),
      },
    );
  }
}

