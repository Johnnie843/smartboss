import 'package:flutter/material.dart';


import 'package:myapp/pages/LoginPage.dart';
import 'package:myapp/pages/HomePage.dart';
import 'package:myapp/pages/dialogs/CreateBusinessAccountPage.dart';
import 'package:myapp/pages/CreateAccountPage.dart';
import 'package:myapp/pages/dialogs/CreateEmployeeAccountPage.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  final routes = <String, WidgetBuilder>{
    LoginPage.tag: (context)=>LoginPage(),
    HomePage.tag: (context)=>HomePage(),
    CreateBusinessAccountPage.tag: (context)=>CreateBusinessAccountPage(),
    CreateAccountPage.tag: (context)=>CreateAccountPage(),
    CreateEmployeeAccountPage.tag:  (context)=>CreateEmployeeAccountPage()

  };

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: new ThemeData(
        primarySwatch: Colors.lightBlue,
        primaryTextTheme: Theme
            .of(context)
            .primaryTextTheme
            .apply(bodyColor: Colors.white)
      ),

      home: LoginPage(),
      routes: routes,
    );
  }
}
