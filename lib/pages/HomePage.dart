import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:myapp/model/User.dart';
import 'package:myapp/pages/LoginPage.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key key, @required this.user}) : super(key: key);
  static String tag = 'home-page';
  final FirebaseUser user;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


  User currentUser;


  final routes = <String, WidgetBuilder>{
    LoginPage.tag: (context) => LoginPage(),
  };

  void showNewUserDialog(BuildContext context) {
    showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Test"),
        content: Text("Test"),
        actions: <Widget>[
          FlatButton(
            child: const Text('OK'),
            onPressed: () {
              Navigator.of(context).pop(true);
            },
          ),
        ],
      ),
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

  @override
  Widget _buildAdminHomeScreen(BuildContext context) {
    return Container(
      child: Text("Welcome"),
    );
  }

  @override
  Widget _buildActionBar(BuildContext context) {
    return Container();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          title: Text('SmartBoss'),
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(icon: Icon(Icons.dashboard), onPressed: null);
            },
          ),
          actions: <Widget>[
            IconButton(icon: Icon(Icons.message), onPressed: null),
            IconButton(
                icon: new Stack(
                  children: <Widget>[
                    new Icon(Icons.account_circle),
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
                icon: Icon(Icons.exit_to_app),
                onPressed: () {
                  FirebaseAuth.instance.signOut();
                  Navigator.of(context).pushNamed(LoginPage.tag);
                })
          ],
        ),
        backgroundColor: Colors.white,
        body: StreamBuilder(
            stream: Firestore.instance.collection("users").document("${widget.user.uid}").snapshots(),
            builder: (context, snapshot) {
              currentUser = new User(widget.user.uid, snapshot.data["fname"] , snapshot.data["lname"] , snapshot.data["newUser"] , snapshot.data["userType"]);

              if (!snapshot.hasData) return const CircularProgressIndicator();

              if (snapshot.data["userType"] == 0) {
                return _buildAdminHomeScreen(context);
              }
              else if (snapshot.data["userType"] == 1){
                return _buildContractorHomeScreen(context, snapshot.data);
              }
              else if (snapshot.data["userType"] == 2){
                return _buildEmployeeHomeScreen(context, snapshot.data);
              }
              else{
                return _buildCustomerHomeScreen(context, snapshot.data);
              }

            })

    );
  }
}
