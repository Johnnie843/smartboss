import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:myapp/model/User.dart';
import 'package:myapp/pages/LoginPage.dart';
import 'package:myapp/firestore/UserService.dart';
import 'package:myapp/pages/ProfilePage.dart';
import 'package:myapp/pages/DropDownMenuChoices.dart';
import 'package:myapp/pages/HomePage.dart';
import 'package:myapp/pages/HireEmployeePage.dart';

class ManageBusinessPage extends StatefulWidget {
  const ManageBusinessPage({Key key, @required this.user}) : super(key: key);
  static String tag = 'manage-business-page';
  final FirebaseUser user;

  @override
  _ManageBusinessPageState createState() => _ManageBusinessPageState();
}

class _ManageBusinessPageState extends State<ManageBusinessPage> {
  User currentUser;
  UserService userDocument = new UserService();
  QuerySnapshot userInfo;

  final routes = <String, WidgetBuilder>{
    LoginPage.tag: (context) => LoginPage(),
  };

  @override
  void initState() {
    userDocument.getUserProfile(widget.user.uid).then((user) {
      print("Init HomePage ${user.describeUser()}");
      setState(() {
        currentUser = user;
      });
    });
  }

  Choice _selectedChoice = choices[0];

  void _select(Choice choice) {
    setState(() {
      if (choice.title == "Dashboard") {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => HomePage(user: widget.user)));
      } else if (choice.title == "Manage Business") {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ManageBusinessPage(user: widget.user)));
      }
      _selectedChoice = choice;
    });
  }

  final TextStyle _dropDownMenuTextStyle = TextStyle(
    fontFamily: 'Roboto',
    color: Colors.white,
    fontSize: 20.0,
    fontWeight: FontWeight.w700,
  );

  final TextStyle _clipArtButtonTextStyle = TextStyle(
    fontFamily: 'Roboto',
    color: Colors.lightBlue,
    fontSize: 15.0,
    fontWeight: FontWeight.w700,
  );

  Widget _hireEmployeeButton(Size screenSize) {
    return Column(
      children: <Widget>[
        Text(
          "Hire Employee",
          style: _clipArtButtonTextStyle,
        ),
        Material(
          elevation: 10.0,
          color: Colors.transparent,
          child: Ink.image(
            image: NetworkImage(
                'https://firebasestorage.googleapis.com/v0/b/smartboss-3badb.appspot.com/o/hiringClipArt.jpg?alt=media&token=70284de4-03d4-40ad-aca4-5c91b1db0abb'),
            fit: BoxFit.scaleDown,
            width: 120.0,
            height: 120.0,
            child: InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => HireEmployeePage(user: widget.user)));
              },
              child: null,
            ),
          ),
        )
      ],
    );
  }

  Widget _manageEmployeesButton(Size screenSize) {
    return Column(
      children: <Widget>[
        Text(
          "Manage Employees",
          style: _clipArtButtonTextStyle,
        ),
        Material(
          elevation: 10.0,
          color: Colors.transparent,
          child: Ink.image(
            image: NetworkImage(
                'https://firebasestorage.googleapis.com/v0/b/smartboss-3badb.appspot.com/o/manageEmployees.jpg?alt=media&token=93e2b0d6-f28b-44b9-83a0-a833b80daf39'),
            fit: BoxFit.scaleDown,
            width: 120.0,
            height: 120.0,
            child: InkWell(
              onTap: () {},
              child: null,
            ),
          ),
        )
      ],
    );
  }

  Widget _payrollButton(Size screenSize) {
    return Column(
      children: <Widget>[
        Text(
          "Payroll",
          style: _clipArtButtonTextStyle,
        ),
        Material(
          elevation: 10.0,
          color: Colors.transparent,
          child: Ink.image(
            image: NetworkImage(
                'https://firebasestorage.googleapis.com/v0/b/smartboss-3badb.appspot.com/o/payrollClipart.jpg?alt=media&token=ee19be2c-a5c0-4bc6-a014-0c1f75e992c3'),
            fit: BoxFit.fill,
            width: 120.0,
            height: 120.0,
            child: InkWell(
              onTap: () {},
              child: null,
            ),
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text('SmartBoss'),
        leading: Builder(
          builder: (BuildContext context) {
            return Theme(
                data: Theme.of(context).copyWith(
                  cardColor: Colors.lightBlue,
                ),
                child: PopupMenuButton<Choice>(
                  icon: Icon(
                    Icons.menu,
                    color: Colors.white,
                  ),
                  onSelected: _select,
                  itemBuilder: (BuildContext context) {
                    return choices.map((Choice choice) {
                      return PopupMenuItem<Choice>(
                          value: choice,
                          child: Row(
                            children: <Widget>[
                              Icon(
                                choice.icon,
                                color: Colors.white,
                              ),
                              SizedBox(width: 10),
                              InkWell(
                                child: Text(
                                  choice.title,
                                  style: _dropDownMenuTextStyle,
                                ),
                              )
                            ],
                          ));
                    }).toList();
                  },
                ));
          },
        ),
        actions: <Widget>[
          IconButton(
              icon: new Stack(
                children: <Widget>[
                  new Icon(Icons.message),
                  new Positioned(
                    top: 0.0,
                    right: 0.0,
                    child: new Icon(
                      Icons.brightness_1,
                      size: 8.0,
                      color: Colors.redAccent,
                    ),
                  )
                ],
              ),
              onPressed: null),
          IconButton(
              color: Colors.white,
              icon: Icon(Icons.account_circle),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ProfilePage(user: widget.user)));
              }),
          IconButton(
              color: Colors.white,
              icon: Icon(Icons.exit_to_app),
              onPressed: () {
                FirebaseAuth.instance.signOut();
                Navigator.of(context).pushNamed(LoginPage.tag);
              })
        ],
      ),
      backgroundColor: Colors.white,
      body: StreamBuilder(
          stream: Firestore.instance
              .collection("users")
              .document("${widget.user.uid}")
              .snapshots(),
          builder: (context, snapshot) {
            return Column(
              children: <Widget>[
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    _hireEmployeeButton(screenSize),
                    _manageEmployeesButton(screenSize),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[_payrollButton(screenSize)],
                )
              ],
            );
          }),
    );
  }
}
