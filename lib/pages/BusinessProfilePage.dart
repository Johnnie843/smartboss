import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:myapp/model/User.dart';
import 'package:myapp/pages/LoginPage.dart';
import 'package:myapp/firestore/UserService.dart';
import 'package:myapp/pages/HomePage.dart';
import 'package:myapp/pages/ProfilePage.dart';
import 'package:myapp/pages/DropDownMenuChoices.dart';
import 'package:myapp/pages/ManageBusinessPage.dart';

class BusinessProfilePage extends StatefulWidget {
  static String tag = 'build-profile-tag';
  final FirebaseUser user;

  const BusinessProfilePage({Key key, @required this.user}) : super(key: key);

  @override
  _BusinessProfilePageState createState() => _BusinessProfilePageState();
}

class _BusinessProfilePageState extends State<BusinessProfilePage> {
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
                      color: Colors.red,
                      image: DecorationImage(
                          image: NetworkImage(
                              'https://firebasestorage.googleapis.com/v0/b/smartboss-3badb.appspot.com/o/coverphoto.png?alt=media&token=87ede39a-aea3-4b5e-87bd-599095af7d4f'),
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

  Widget _buildHeaderItem(String label, String count, double fontSize) {
    TextStyle _statLabelTextStyle = TextStyle(
      fontFamily: 'Roboto',
      color: Colors.white,
      fontSize: fontSize,
      fontWeight: FontWeight.bold,
    );

    TextStyle _statCountTextStyle = TextStyle(
      color: Colors.white,
      fontSize: fontSize,
      fontWeight: FontWeight.bold,
    );

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          count,
          style: _statCountTextStyle,
        ),
        Text(
          label,
          style: _statLabelTextStyle,
        ),
      ],
    );
  }

  Widget _buildHeaderContainer(Size screensize) {
    return Container(
        height: 100.0,
        width: screensize.width,
        margin: EdgeInsets.only(top: 8.0),
        decoration: BoxDecoration(
          color: Colors.lightBlue,
        ),
        child: Row(
          children: <Widget>[
            SizedBox(
              width: 20.0,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 5.0,
                ),
                _buildHeaderItem("Ingenious solutions", "", 24.0),
                _buildHeaderItem("***** 155 Reviews", "4.7  ", 14.0),
                _buildHeaderItem("Technology Soluctions", "", 14.0),
                SizedBox(
                  height: 5.0,
                ),
              ],
            ),
          ],
        ));
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
                    height: 150,
                    padding: EdgeInsets.all(8.0),
                    child: ListView(
                      children: <Widget>[
                        Column(children: <Widget>[
                          SizedBox(height: 30),
                          Text(
                            "Ingenious Solution is here for any technology solution that fits your needs such as, Software Development, Web Design, and much more",
                            textAlign: TextAlign.center,
                            style: bioTextStyle,
                          ),
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
                      size: 20.0,
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
      height: 1.0,
      color: Colors.black54,
      margin: EdgeInsets.only(top: 0.0),
    );
  }


  Widget _buildStatsItem(String label, String count) {
    TextStyle _statLabelTextStyle = TextStyle(
      fontFamily: 'Roboto',
      color: Colors.lightBlue,
      fontSize: 16.0,
      fontWeight: FontWeight.bold,
    );

    TextStyle _statCountTextStyle = TextStyle(
      color: Colors.lightBlue,
      fontSize: 24.0,
      fontWeight: FontWeight.bold,
    );

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          count,
          style: _statCountTextStyle,
        ),
        Text(
          label,
          style: _statLabelTextStyle,
        ),
      ],
    );
  }

  Widget _buildStatContainer() {
    return Container(
      height: 60.0,
      margin: EdgeInsets.only(top: 8.0),
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          _buildStatsItem("Employees", "23"),
          _buildStatsItem("Satisfied Jobs", '11246'),
        ],
      ),
    );
  }


  TextStyle _buttonTextStyle = TextStyle(
    color: Colors.lightBlue,
    fontWeight: FontWeight.bold,
  );

  Widget _buildButtons(Size screenSize) {
    TextStyle _buildButtonsTextStyle = TextStyle(
      fontFamily: 'Roboto',
      color: Colors.lightBlue,
      fontSize: 16,
      fontWeight: FontWeight.bold,
    );
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Column(
            children: <Widget>[
              IconButton(
                  padding: EdgeInsets.only(),
                  icon: new Icon(Icons.phone),
                  iconSize: 50.0,
                  color: Colors.lightBlue,
                  onPressed: () {}),
              Text(
                "Call",
                textAlign: TextAlign.center,
                style: _buildButtonsTextStyle,
              ),
            ],
          ),
          Column(
            children: <Widget>[
              IconButton(
                  padding: EdgeInsets.only(),
                  icon: new Icon(Icons.email),
                  iconSize: 50.0,
                  color: Colors.lightBlue,
                  onPressed: () {}),
              Text(
                "Email",
                textAlign: TextAlign.center,
                style: _buildButtonsTextStyle,
              ),
            ],
          ),
          Column(
            children: <Widget>[
              IconButton(
                  padding: EdgeInsets.only(),
                  icon: new Icon(Icons.language),
                  iconSize: 50.0,
                  color: Colors.lightBlue,
                  onPressed: () {}),
              Text(
                "Website",
                textAlign: TextAlign.center,
                style: _buildButtonsTextStyle,
              ),
            ],
          ),
          Column(
            children: <Widget>[
              IconButton(
                  padding: EdgeInsets.only(),
                  icon: new Icon(Icons.calendar_today),
                  iconSize: 50.0,
                  color: Colors.lightBlue,
                  onPressed: () {}),
              Text(
                "Schedule",
                textAlign: TextAlign.center,
                style: _buildButtonsTextStyle,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildEditAddress(Size screenSize) {
    if (currentUser.fnameGet.isEmpty) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Icon(
            Icons.location_on,
            color: Colors.lightBlue,
            size: 40.0,),
          Container(
              width: screenSize.width / 1.6,
              padding: EdgeInsets.symmetric(vertical: 4.0),
              child: TextFormField(
                autofocus: false,
                onSaved: (input) => _fname = input,
                decoration: InputDecoration(
                    labelText: "Business Address",
                    hintText: "Business Address",
                    contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(32.0))),
              )),
          RawMaterialButton(
            onPressed: () {
              final userService = new UserService();
              final formState = _formKey.currentState;
              formState.save();

              if (formState.validate()) {
                formState.save();
                try {
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
         Icon(
            Icons.location_on,
            color: Colors.lightBlue,
            size: 40.0,),
          Container(
              width: screenSize.width / 1.25,
              padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 1),
              child: TextFormField(
                autofocus: false,
                onSaved: (input) => _fname = input,
                decoration: InputDecoration(
                    labelText: "1808 Widgeon Road Monck Corner",
                    hintText: "Business Address",
                    contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(32.0))),
              )),
          Container(
              width: 40,
              child: RawMaterialButton(
            onPressed: () {
              final userService = new UserService();
              final formState = _formKey.currentState;
              formState.save();

              if (formState.validate()) {
                formState.save();
                try {

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
          ),)

        ],
      );
    }
  }

  Widget _buildBusinessPhone(Size screenSize) {
    if (currentUser.fnameGet.isEmpty) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Icon(
            Icons.phone,
            color: Colors.lightBlue,
            size: 40.0,),
          Container(
              width: screenSize.width / 1.6,
              padding: EdgeInsets.symmetric(vertical: 4.0),
              child: TextFormField(
                autofocus: false,
                onSaved: (input) => _fname = input,
                decoration: InputDecoration(
                    labelText: "Business Contact Number",
                    hintText: "Business Contact Number",
                    contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(32.0))),
              )),
          RawMaterialButton(
            onPressed: () {
              final userService = new UserService();
              final formState = _formKey.currentState;
              formState.save();

              if (formState.validate()) {
                formState.save();
                try {
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
          Icon(
            Icons.phone,
            color: Colors.lightBlue,
            size: 40.0,),
          Container(
              width: screenSize.width / 1.25,
              padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 1),
              child: TextFormField(
                autofocus: false,
                onSaved: (input) => _fname = input,
                decoration: InputDecoration(
                    labelText: "843-555-9999",
                    hintText: "Business Contact Number",
                    contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(32.0))),
              )),
          Container(
            width: 40,
            child: RawMaterialButton(
              onPressed: () {
                final userService = new UserService();
                final formState = _formKey.currentState;
                formState.save();

                if (formState.validate()) {
                  formState.save();
                  try {

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
            ),)

        ],
      );
    }
  }

  Widget _buildBusinessEmail(Size screenSize) {
    if (currentUser.fnameGet.isEmpty) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Icon(
            Icons.email,
            color: Colors.lightBlue,
            size: 40.0,),
          Container(
              width: screenSize.width / 1.6,
              padding: EdgeInsets.symmetric(vertical: 4.0),
              child: TextFormField(
                autofocus: false,
                onSaved: (input) => _fname = input,
                decoration: InputDecoration(
                    labelText: "Business Email",
                    hintText: "Business Email",
                    contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(32.0))),
              )),
          RawMaterialButton(
            onPressed: () {
              final userService = new UserService();
              final formState = _formKey.currentState;
              formState.save();

              if (formState.validate()) {
                formState.save();
                try {
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
          Icon(
            Icons.email,
            color: Colors.lightBlue,
            size: 40.0,),
          Container(
              width: screenSize.width / 1.25,
              padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 1),
              child: TextFormField(
                autofocus: false,
                onSaved: (input) => _fname = input,
                decoration: InputDecoration(
                    labelText: "cooperj2@g.cofc.edu",
                    hintText: "Business Email",
                    contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(32.0))),
              )),
          Container(
            width: 40,
            child: RawMaterialButton(
              onPressed: () {
                final userService = new UserService();
                final formState = _formKey.currentState;
                formState.save();

                if (formState.validate()) {
                  formState.save();
                  try {

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
            ),)

        ],
      );
    }
  }
  Widget _buildBusinessWebsite(Size screenSize) {
    if (currentUser.fnameGet.isEmpty) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Icon(
            Icons.language,
            color: Colors.lightBlue,
            size: 40.0,),
          Container(
              width: screenSize.width / 1.6,
              padding: EdgeInsets.symmetric(vertical: 4.0),
              child: TextFormField(
                autofocus: false,
                onSaved: (input) => _fname = input,
                decoration: InputDecoration(
                    labelText: "Company Website",
                    hintText: "Company Website",
                    contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(32.0))),
              )),
          RawMaterialButton(
            onPressed: () {
              final userService = new UserService();
              final formState = _formKey.currentState;
              formState.save();

              if (formState.validate()) {
                formState.save();
                try {
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
          Icon(
            Icons.language,
            color: Colors.lightBlue,
            size: 40.0,),
          Container(
              width: screenSize.width / 1.25,
              padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 1),
              child: TextFormField(
                autofocus: false,
                onSaved: (input) => _fname = input,
                decoration: InputDecoration(
                    labelText: "www.comingsoon.com",
                    hintText: "Business Email",
                    contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(32.0))),
              )),
          Container(
            width: 40,
            child: RawMaterialButton(
              onPressed: () {
                final userService = new UserService();
                final formState = _formKey.currentState;
                formState.save();

                if (formState.validate()) {
                  formState.save();
                  try {

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
            ),)

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
                      _buildHeaderContainer(screenSize),
                      _buildButtons(screenSize),
                      _buildSeparator(screenSize, screenSize.width),
                      _buildBio(screenSize),
                      _buildStatContainer(),
                      SizedBox(height: 20),
                      _buildEditAddress(screenSize),
                      _buildBusinessPhone(screenSize),
                      _buildBusinessEmail(screenSize),
                      _buildBusinessWebsite(screenSize)
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
