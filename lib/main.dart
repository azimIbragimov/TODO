import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:todo/constants.dart';
import 'package:todo/demo.dart';
import 'package:todo/loginpage.dart';
import 'package:todo/pageNotification.dart';
import 'package:todo/profile.dart';
import 'package:todo/registerPage.dart';
import 'welcomeInformation.dart';
import 'myDrawer.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'constants.dart';
import 'slideCard.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:no_context_navigation/no_context_navigation.dart';
import 'myhomepage.dart';
import 'firstScreen.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: HomePage(),
      debugShowCheckedModeBanner: false,
      navigatorKey: NavigationService.navigationKey,
      routes: {
        HomePage.id: (context) => HomePage(),
        MyHomePage.id: (context) => MyHomePage(),
        LoginPage.id: (context) => LoginPage(),
        RegisterPage.id: (context) => RegisterPage(),
        Group1Widget.id: (context) => Group1Widget()
      },
      initialRoute: HomePage.id,
    );
  }
}
