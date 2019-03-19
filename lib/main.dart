import 'package:flutter/material.dart';
import 'package:myapp/login/loginPage.dart';
import 'package:myapp/home/homePage.dart';
import 'package:myapp/createAccount/createBusinessAccountPage.dart';
import 'package:myapp/createAccount/createAccountPage.dart';
import 'package:myapp/createAccount/createEmployeeAccountPage.dart';


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
