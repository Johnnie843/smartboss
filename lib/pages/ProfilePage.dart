import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:myapp/model/User.dart';
import 'package:myapp/pages/LoginPage.dart';
import 'package:myapp/firestore/UserService.dart';
import 'package:myapp/pages/HomePage.dart';
import 'package:myapp/pages/BusinessProfilePage.dart';
import 'package:myapp/pages/DropDownMenuChoices.dart';
import 'package:myapp/pages/ManageBusinessPage.dart';

class ProfilePage extends StatefulWidget {
  static String tag = 'edit-profile-tag';
  final FirebaseUser user;

  const ProfilePage({Key key, @required this.user}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  User currentUser;
  UserService userDocument = new UserService();
  QuerySnapshot userInfo;

  static String _email, _password, _fname, _lname;

  final routes = <String, WidgetBuilder>{
    LoginPage.tag: (context) => LoginPage(),
  };

  @override
  void initState() {
    userDocument.getUserProfile(widget.user.uid).then((user) {
      print("Init ProfilePage ${user.describeUser()}");
      setState(() {
        currentUser = user;
      });
    });
  }

  TextStyle _nameTextStyle = TextStyle(
    fontFamily: 'Roboto',
    color: Colors.black,
    fontSize: 20.0,
    fontWeight: FontWeight.w700,
  );

  Widget _buildCoverImage(Size screenSize) {
    return Align(
        child: Container(
            width: screenSize.width + 20,
            height: screenSize.height / 4,
            child: Stack(
              children: <Widget>[
                Container(
                  width: screenSize.width,
                  decoration: BoxDecoration(
                      color: Colors.lightBlue,
                      image: DecorationImage(
                          image: NetworkImage(
                              'https://firebasestorage.googleapis.com/v0/b/smartboss-3badb.appspot.com/o/Screen%20Shot%202019-04-21%20at%2012.26.07%20AM.png?alt=media&token=62cbb8f0-1fd5-4b22-9bce-2a45c80b11d8'),
                          fit: BoxFit.fill),
                      boxShadow: [
                        BoxShadow(blurRadius: 7.0, color: Colors.black)
                      ]),
                ),
                Positioned(
                  top: 0.0,
                  right: 0.0,
                  child: new RawMaterialButton(
                    onPressed: () {},
                    child: new Icon(
                      Icons.edit,
                      color: Colors.white,
                      size: 25.0,
                    ),
                    shape: new CircleBorder(),
                    elevation: 2.0,
                    fillColor: Colors.lightBlue,
                    padding: const EdgeInsets.all(0.0),
                  ),
                ),
              ],
            )));
  }

  Widget _buildProfileImage() {
    return Align(
        alignment: Alignment(0.1, 0),
        child: Container(
            width: 170.0,
            height: 150.0,
            child: Stack(
              children: <Widget>[
                Container(
                  width: 140.0,
                  height: 140.0,
                  decoration: BoxDecoration(
                      color: Colors.lightBlue,
                      image: DecorationImage(
                          image: NetworkImage(
                              'https://firebasestorage.googleapis.com/v0/b/smartboss-3badb.appspot.com/o/Resume%20Image.jpeg?alt=media&token=c8938675-7179-4f3d-8d88-3a3c4ac2e74a'),
                          fit: BoxFit.cover),
                      borderRadius: BorderRadius.all(Radius.circular(75.0)),
                      boxShadow: [
                        BoxShadow(blurRadius: 7.0, color: Colors.black)
                      ]),
                ),
                Positioned(
                  top: 90.0,
                  right: 0.0,
                  child: new RawMaterialButton(
                    onPressed: () {},
                    child: new Icon(
                      Icons.edit,
                      color: Colors.white,
                      size: 25.0,
                    ),
                    shape: new CircleBorder(),
                    elevation: 2.0,
                    fillColor: Colors.lightBlue,
                    padding: const EdgeInsets.all(0.0),
                  ),
                ),
              ],
            )));
  }

  Widget _buildFullName() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 6.0),
      child: Text(
        "${currentUser.fnameGet} ${currentUser.lnameGet}",
        textAlign: TextAlign.center,
        style: _nameTextStyle,
      ),
    );
  }

  Widget _buildStatus(BuildContext context) {
    return Container(
      height: 50.0,
      padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 6.0),
      child: Text(
        "Ingenious Solutions",
        textAlign: TextAlign.center,
        style: _nameTextStyle,
      ),
    );
  }

  Widget _buildBio(Size screenSize) {
    TextStyle bioTextStyle = TextStyle(
      fontFamily: 'Spectral',
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.italic,
      color: Color(0xFF799497),
      fontSize: 16.0,
    );

    return Align(
        alignment: Alignment(0.1, 0),
        child: Container(
            width: screenSize.width,
            height: 100,
            color: Colors.grey.shade100,
            child: Stack(
              children: <Widget>[
                Container(
                    alignment: Alignment.topCenter,
                    width: screenSize.width,
                    height: screenSize.height / 5.9,
                    padding: EdgeInsets.all(8.0),
                    child: ListView(
                      children: <Widget>[
                        Column(children: <Widget>[
                          SizedBox(height: 20),
                          Text(
                            "An entrepreneur that specializes in Software Development, Co-Founded Ingenious Solutions which specializes in software development and consulting.",
                            textAlign: TextAlign.center,
                            style: bioTextStyle,
                          ),
                          SizedBox(height: 15),
                        ])
                      ],
                    )),
                Positioned(
                  left: 50,
                  bottom: 0,
                  child: _buildSeparator(screenSize, screenSize.width / 1.4),
                ),
                Positioned(
                  left: -15,
                  top: 0,
                  child: new RawMaterialButton(
                    onPressed: () {},
                    child: new Icon(
                      Icons.edit,
                      color: Colors.white,
                      size: 25.0,
                    ),
                    shape: new CircleBorder(),
                    elevation: 2.0,
                    fillColor: Colors.lightBlue,
                    padding: const EdgeInsets.all(0.0),
                  ),
                ),
              ],
            )));
  }

  Widget _buildSeparator(Size screenSize, double width) {
    return Container(
      width: width,
      height: 2.0,
      color: Colors.black54,
      margin: EdgeInsets.only(top: 4.0),
    );
  }

  TextStyle _buttonTextStyle = TextStyle(
    color: Colors.lightBlue,
    fontWeight: FontWeight.bold,
  );

  Widget _buildButtons() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 1.0, horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Column(
            children: <Widget>[
              Text(
                "Business",
                textAlign: TextAlign.center,
                style: _buttonTextStyle,
              ),
              IconButton(
                  padding: EdgeInsets.only(),
                  icon: new Icon(Icons.business),
                  iconSize: 50.0,
                  color: Colors.lightBlue,
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                BusinessProfilePage(user: widget.user)));
                  }),
              Text(
                "Profile",
                style: _buttonTextStyle,
                textAlign: TextAlign.center,
              ),
            ],
          ),
          SizedBox(width: 10.0),
          Column(
            children: <Widget>[
              Text(
                "Send",
                textAlign: TextAlign.center,
                style: _buttonTextStyle,
              ),
              IconButton(
                  padding: EdgeInsets.only(),
                  icon: new Icon(Icons.message),
                  iconSize: 50.0,
                  color: Colors.lightBlue,
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                BusinessProfilePage(user: widget.user)));
                  }),
              Text(
                "Message",
                style: _buttonTextStyle,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildEditFname(Size screenSize) {
    if (currentUser.fnameGet.isEmpty) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
              width: screenSize.width / 1.6,
              padding: EdgeInsets.symmetric(vertical: 4.0),
              child: TextFormField(
                autofocus: false,
                onSaved: (input) => _fname = input,
                decoration: InputDecoration(
                    prefixIcon: IconButton(
                      color: Colors.black,
                      icon: Icon(Icons.arrow_back),
                      iconSize: 20.0,
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    contentPadding: EdgeInsets.only(left: 25.0),
                    hintText: 'First Name',
                    labelText: 'First Name',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4.0))),
              )),
          RawMaterialButton(
            onPressed: () {
              final userService = new UserService();
              final formState = _formKey.currentState;
              formState.save();

              if (formState.validate()) {
                formState.save();
                try {
                  print("$_fname");
                  userService.updateUserFName(currentUser.uidGet, _fname);
                  // Navigator.push(context, MaterialPageRoute(builder: (context) => ProfilePage(user: widget.user)));
                } catch (e) {
                  print(e.message);
                }
              }
            },
            child: new Icon(
              Icons.check_circle,
              color: Colors.lightBlue,
              size: 40.0,
            ),
          ),
        ],
      );
    } else {
      return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
              width: screenSize.width / 1.6,
              padding: EdgeInsets.symmetric(vertical: 4.0),
              child: TextFormField(
                autofocus: false,
                onSaved: (input) => _fname = input,
                decoration: InputDecoration(
                    prefixIcon: IconButton(
                      color: Colors.black,
                      icon: Icon(Icons.arrow_back),
                      iconSize: 20.0,
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    contentPadding: EdgeInsets.only(left: 25.0),
                    hintText: 'First Name',
                    labelText: "${currentUser.fnameGet}",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4.0))),
              )),
          RawMaterialButton(
            onPressed: () {
              final userService = new UserService();
              final formState = _formKey.currentState;
              formState.save();

              if (formState.validate()) {
                formState.save();
                try {
                  print("$_fname");
                  userService.updateUserFName(currentUser.uidGet, _fname);
                  // Navigator.push(context, MaterialPageRoute(builder: (context) => ProfilePage(user: widget.user)));
                } catch (e) {
                  print(e.message);
                }
              }
            },
            child: new Icon(
              Icons.check_circle,
              color: Colors.lightBlue,
              size: 40.0,
            ),
          ),
        ],
      );
    }
  }

  Widget _buildEditLname(Size screenSize) {
    if (currentUser.lnameGet.isEmpty) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
              width: screenSize.width / 1.6,
              padding: EdgeInsets.symmetric(vertical: 4.0),
              child: TextFormField(
                autofocus: false,
                onSaved: (input) => _lname = input,
                decoration: InputDecoration(
                    prefixIcon: IconButton(
                      color: Colors.black,
                      icon: Icon(Icons.arrow_back),
                      iconSize: 20.0,
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    contentPadding: EdgeInsets.only(left: 25.0),
                    hintText: 'First Name',
                    labelText: 'First Name',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4.0))),
              )),
          RawMaterialButton(
            onPressed: () {
              final userService = new UserService();
              final formState = _formKey.currentState;
              formState.save();

              if (formState.validate()) {
                formState.save();
                try {
                  print("$_lname");
                  userService.updateUserFName(currentUser.uidGet, _lname);
                  // Navigator.push(context, MaterialPageRoute(builder: (context) => ProfilePage(user: widget.user)));
                } catch (e) {
                  print(e.message);
                }
              }
            },
            child: new Icon(
              Icons.check_circle,
              color: Colors.lightBlue,
              size: 40.0,
            ),
          ),
        ],
      );
    } else {
      return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
              width: screenSize.width / 1.6,
              padding: EdgeInsets.symmetric(vertical: 4.0),
              child: TextFormField(
                autofocus: false,
                onSaved: (input) => _lname = input,
                decoration: InputDecoration(
                    prefixIcon: IconButton(
                      color: Colors.black,
                      icon: Icon(Icons.arrow_back),
                      iconSize: 20.0,
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    contentPadding: EdgeInsets.only(left: 25.0),
                    hintText: 'Last Name',
                    labelText: "${currentUser.lnameGet}",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4.0))),
              )),
          RawMaterialButton(
            onPressed: () {
              final userService = new UserService();
              final formState = _formKey.currentState;
              formState.save();

              if (formState.validate()) {
                formState.save();
                try {
                  print("$_lname");
                  userService.updateUserFName(currentUser.uidGet, _lname);
                  //Navigator.push(context, MaterialPageRoute(builder: (context) => ProfilePage(user: widget.user)));
                } catch (e) {
                  print(e.message);
                }
              }
            },
            child: new Icon(
              Icons.check_circle,
              color: Colors.lightBlue,
              size: 40.0,
            ),
          ),
        ],
      );
    }
  }

  Choice _selectedChoice = choices[0];

  void _select(Choice choice) {
    // Causes the app to rebuild with the new _selectedChoice.
    setState(() {
      if (choice.title == "Dashboard") {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => HomePage(user: widget.user)));
      }
      else if (choice.title == "Manage Business"){

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
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  _buildCoverImage(screenSize),
                  Column(
                    children: <Widget>[
                      SizedBox(height: screenSize.height / 4.2),
                      Center(child: _buildProfileImage()),
                      _buildFullName(),
                      _buildSeparator(screenSize, screenSize.width / 2.5),
                      _buildStatus(context),
                      _buildButtons(),
                      _buildBio(screenSize),
                      SizedBox(height: 28.0),
                      Form(
                        key: _formKey,
                        child: ListView(
                          shrinkWrap: true,
                          padding: EdgeInsets.only(left: 24.0, right: 24.0),
                          children: <Widget>[
                            _buildEditFname(screenSize),
                            SizedBox(height: 12.0),
                            _buildEditLname(screenSize),
                            SizedBox(height: 12.0),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
