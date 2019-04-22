import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:myapp/model/User.dart';
import 'package:myapp/pages/LoginPage.dart';
import 'package:myapp/firestore/UserService.dart';
import 'package:myapp/pages/ProfilePage.dart';
import 'package:myapp/pages/ManageBusinessPage.dart';
import 'package:myapp/pages/DropDownMenuChoices.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key, @required this.user}) : super(key: key);
  static String tag = 'home-page';
  final FirebaseUser user;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  User currentUser;
  UserService userDocument = new UserService();
  QuerySnapshot userInfo;

  final routes = <String, WidgetBuilder>{
    LoginPage.tag: (context) => LoginPage(),
  };

  void showNewUserDialog(BuildContext context) {
    showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
          title: Center(
            child: Text("Welcome to SmartBoss"),
          ),
          content: ButtonBar(children: <Widget>[
            MaterialButton(
                minWidth: 100.0,
                height: 42.0,
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              ProfilePage(user: widget.user)));
                },
                color: Colors.lightBlueAccent,
                child: Text(
                  "Edit Profile",
                  style: TextStyle(color: Colors.white),
                )),
            MaterialButton(
                minWidth: 100.0,
                height: 42.0,
                onPressed: () {
                  Navigator.pop(context);
                },
                color: Colors.lightBlueAccent,
                child: Text(
                  "Main Menu",
                  style: TextStyle(color: Colors.white),
                ))
          ])),
    );
  }

  @override
  Widget _buildEmployeeHomeScreen(
      BuildContext context, DocumentSnapshot document) {
    return Center(child: Text("Employee"));
  }

  @override
  Widget _buildContractorHomeScreen(
      BuildContext context, DocumentSnapshot document) {
    return Center(child: Text("Contractor"));
  }

  @override
  Widget _buildCustomerHomeScreen(
      BuildContext context, DocumentSnapshot document) {
    return Center(child: Text("Customer"));
  }

  Widget _buildProfile(Size screenSize) {
    return Center(child: Text(""));
  }

  @override
  void initState() {
    userDocument.getUserProfile(widget.user.uid).then((user) {
      print("Init HomePage ${user.describeUser()}");
      setState(() {
        currentUser = user;
        if (currentUser.newUserGet) {
          showNewUserDialog(context);
        }
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
      }else if (choice.title == "Manage Business"){

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
                child:PopupMenuButton<Choice>(
                  icon: Icon(Icons.menu,
                    color: Colors.white,),
                  onSelected: _select,
                  itemBuilder: (BuildContext context) {
                    return choices.map((Choice choice) {
                      return PopupMenuItem<Choice>(
                          value: choice,
                          child: Row(
                            children: <Widget>[
                              Icon(choice.icon, color: Colors.white,),
                              SizedBox(width: 10),
                              InkWell(child: Text(
                                choice.title,
                                style: _dropDownMenuTextStyle,
                              ),)],
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
              onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context) => ProfilePage(user: widget.user)));}),
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
            return _buildProfile(screenSize);

          }),
    );
  }
}



