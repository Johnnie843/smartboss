import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:autocomplete_textfield/autocomplete_textfield.dart';

import 'package:myapp/model/User.dart';
import 'package:myapp/pages/LoginPage.dart';
import 'package:myapp/firestore/UserService.dart';
import 'package:myapp/pages/ProfilePage.dart';
import 'package:myapp/pages/DropDownMenuChoices.dart';
import 'package:myapp/pages/HomePage.dart';
import 'package:myapp/pages/ManageBusinessPage.dart';
import 'package:myapp/firestore/UsersService.dart';

class HireEmployeePage extends StatefulWidget {
  const HireEmployeePage({Key key, @required this.user}) : super(key: key);
  static String tag = 'hire-employee-page';
  final FirebaseUser user;

  @override
  _HireEmployeePageState createState() => _HireEmployeePageState();
}

class _HireEmployeePageState extends State<HireEmployeePage> {
  User currentUser;
  UserService userDocument = new UserService();
  QuerySnapshot userInfo;
  AutoCompleteTextField searchTextField;
  TextEditingController controller = new TextEditingController();
  GlobalKey<AutoCompleteTextFieldState<User>> key = new GlobalKey();

  void _loadData() async {
    await UsersService.loadUsers();
  }

  @override
  void initState() {
    _loadData();
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

  final TextStyle _titleTextStyle = TextStyle(
    fontFamily: 'Roboto',
    color: Colors.lightBlue,
    fontSize: 20.0,
    fontWeight: FontWeight.w700,
  );

  final loginButton = Padding(
    padding: EdgeInsets.symmetric(vertical: 8.0),
    child: Material(
      clipBehavior: Clip.antiAlias,
      borderRadius: BorderRadius.circular(30.0),
      shadowColor: Colors.lightBlueAccent.shade100,
      elevation: 5.0,
      child: MaterialButton(
          minWidth: 200.0,
          height: 45.0,
          onPressed: () {
          },
          color: Colors.lightBlueAccent,
          child: Text(
            "Send Request",
            style: TextStyle(color: Colors.white),
          )),
    ),
  );

  Widget _buildSearchBar(Size screenSize) {

    return Column(children: <Widget>[ SizedBox(height: 30,),
    Text("Search and Hire a Current User", style: _titleTextStyle,),
    Padding(
    padding: const EdgeInsets.all(10.0),
    child:searchTextField = AutoCompleteTextField<User>(
        style: new TextStyle(color: Colors.grey, fontSize: 16.0),
        decoration: new InputDecoration(
            suffixIcon: Container(
              width: 85.0,
              height: 60.0,
            ),
            contentPadding: EdgeInsets.only(left: 25.0),
            filled: true,
            hintText: 'Users Email',
            hintStyle: TextStyle(color: Colors.black),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4.0))),

        itemSubmitted: (item) {
          setState(() => searchTextField.textField.controller.text =
              item.userEmailGet);
        },
        clearOnSubmit: false,
        key: key,
        suggestions: UsersService.users,
        itemBuilder: (context, item) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(item.userEmailGet,
                style: TextStyle(
                    fontSize: 16.0
                ),),
              Padding(
                padding: EdgeInsets.all(15.0),
              ),
              Text("${item.fnameGet} ${item.lnameGet}",
              )
            ],
          );
        },
        itemSorter: (a, b) {
          return a.userEmailGet.compareTo(b.userEmailGet);
        },
        itemFilter: (item, query) {
          return item.userEmailGet
              .toLowerCase()
              .startsWith(query.toLowerCase());
        }),),
      loginButton

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
      body: _buildSearchBar(screenSize),
    );
  }
}
