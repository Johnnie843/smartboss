import 'package:flutter/material.dart';


import 'package:myapp/pages/LoginPage.dart';
import 'package:myapp/pages/HomePage.dart';
import 'package:myapp/pages/dialogs/CreateBusinessAccountPage.dart';
import 'package:myapp/pages/CreateAccountPage.dart';
import 'package:myapp/pages/dialogs/CreateEmployeeAccountPage.dart';
import 'package:myapp/pages/ProfilePage.dart';
import 'package:myapp/pages/BusinessProfilePage.dart';
import 'package:myapp/pages/HireEmployeePage.dart';
import 'package:myapp/pages/ManageBusinessPage.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  final routes = <String, WidgetBuilder>{

    LoginPage.tag: (context)=>LoginPage(),
    HomePage.tag: (context)=>HomePage(),
    CreateBusinessAccountPage.tag: (context)=>CreateBusinessAccountPage(),
    CreateAccountPage.tag: (context)=>CreateAccountPage(),
    CreateEmployeeAccountPage.tag:  (context)=>CreateEmployeeAccountPage(),
    ProfilePage.tag: (context)=>ProfilePage(),
    BusinessProfilePage.tag: (context)=>BusinessProfilePage(),
    ManageBusinessPage.tag: (context)=> ManageBusinessPage(),
    HireEmployeePage.tag: (context)=>HireEmployeePage()

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
