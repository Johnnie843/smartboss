import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:cloud_firestore/cloud_firestore.dart';




import 'package:myapp/login/loginPage.dart';

class HomePage extends StatefulWidget {

  const HomePage({Key key,@required this.user}): super(key:key);
  static String tag = 'home-page';
  final FirebaseUser user;



  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final routes = <String, WidgetBuilder>{
    LoginPage.tag: (context) => LoginPage(),

  };

  @override
  Widget _buildEmployeeHomeScreen(BuildContext context, DocumentSnapshot document) {
    final logo = Hero(
      tag: 'hero',
      child: CircleAvatar(
        backgroundColor: Colors.transparent,
        radius: 100.0,
        child: Image.asset("assets/images/logo.png"),
      ),
    );
    return Center(child: Text("Employee"));
  }

  @override
  Widget _buildContractorHomeScreen(BuildContext context, DocumentSnapshot document) {
    final logo = Hero(
      tag: 'hero',
      child: CircleAvatar(
        backgroundColor: Colors.transparent,
        radius: 100.0,
        child: Image.asset("assets/images/logo.png"),
      ),
    );
    return Center(child: Text("Contractor"));
  }

  @override
  Widget _buildCustomerHomeScreen(BuildContext context, DocumentSnapshot document) {
    final logo = Hero(
      tag: 'hero',
      child: CircleAvatar(
        backgroundColor: Colors.transparent,
        radius: 100.0,
        child: Image.asset("assets/images/logo.png"),
      ),
    );
    return Center(child: Text("Customer"));
  }

  @override
  Widget _buildAdminHomeScreen(BuildContext context, DocumentSnapshot document) {
    final logo = Hero(
      tag: 'hero',
      child: CircleAvatar(
        backgroundColor: Colors.transparent,
        radius: 100.0,
        child: Image.asset("assets/images/logo.png"),
      ),
    );
    return Center(child: Text("Admin"));

  }

  @override
  Widget build(BuildContext context) {

    CollectionReference collectionReference = Firestore.instance.collection("users/");
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
          IconButton(icon: Icon(Icons.account_circle), onPressed: null),
          IconButton(
              color: Colors.white,
              icon: Icon(Icons.exit_to_app), onPressed: () {
                FirebaseAuth.instance.signOut();
                Navigator.of(context).pushNamed(LoginPage.tag);
              }
           )
        ],
      ),
      backgroundColor: Colors.white,
      body: StreamBuilder(
          stream: Firestore.instance.collection("users").document("${widget.user.uid}").snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) return const CircularProgressIndicator();
            if (snapshot.data["userType"] == 0){
              return _buildAdminHomeScreen(context, snapshot.data);
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
          }),
    );
  }
}
