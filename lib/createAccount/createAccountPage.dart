
import 'package:flutter/material.dart';
import 'package:myapp/createAccount/createBusinessAccountPage.dart';
import 'package:myapp/createAccount/createEmployeeAccountPage.dart';
import 'package:myapp/createAccount/createCustomerAccount.dart';




class CreateAccountPage extends StatefulWidget {

  static String tag = 'create-account-page';


  @override
  _CreateAccountPageState createState() => _CreateAccountPageState();
}

class _CreateAccountPageState extends State<CreateAccountPage> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {

    Future _openCreateBusinessAccountDialog() async{
      await Navigator.of(context).push(MaterialPageRoute(builder: (context) => CreateBusinessAccountPage(), fullscreenDialog: true));
    }

    Future _openCreateEmployeeAccountDialog() async{
      await Navigator.of(context).push(MaterialPageRoute(builder: (context) => CreateEmployeeAccountPage(), fullscreenDialog: true));
    }

    Future _openCreateCustomerAccountDialog() async{
      await Navigator.of(context).push(MaterialPageRoute(builder: (context) => CreateCustomerAccountPage(), fullscreenDialog: true));
    }

    final logo = Hero(
      tag: 'hero',
      child: CircleAvatar(
        backgroundColor: Colors.transparent,
        radius: 100.0,
        child: Image.asset("assets/images/logo.png"),
      ),
    );

    final businessOwnerButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        clipBehavior: Clip.antiAlias,
        borderRadius: BorderRadius.circular(30.0),
        shadowColor: Colors.lightBlueAccent.shade100,
        elevation: 5.0,
        child: MaterialButton(
            minWidth: 200.0,
            height: 42.0,
            onPressed: () {
              _openCreateBusinessAccountDialog();
            },
            color: Colors.lightBlueAccent,
            child: Text(
              "Business Account",
              style: TextStyle(color: Colors.white),
            )),
      ),
    );

    final employeeButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        clipBehavior: Clip.antiAlias,
        borderRadius: BorderRadius.circular(30.0),
        shadowColor: Colors.lightBlueAccent.shade100,
        elevation: 5.0,
        child: MaterialButton(
            minWidth: 200.0,
            height: 42.0,
            onPressed: () {
              _openCreateEmployeeAccountDialog();
            },
            color: Colors.lightBlueAccent,
            child: Text(
              "Employee Account",
              style: TextStyle(color: Colors.white),
            )),
      ),
    );

    final customerButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        clipBehavior: Clip.antiAlias,
        borderRadius: BorderRadius.circular(30.0),
        shadowColor: Colors.lightBlueAccent.shade100,
        elevation: 5.0,
        child: MaterialButton(
            minWidth: 200.0,
            height: 42.0,
            onPressed: () {
              _openCreateCustomerAccountDialog();
            },
            color: Colors.lightBlueAccent,
            child: Text(
              "Customer Account",
              style: TextStyle(color: Colors.white),
            )),
      ),
    );




    return Scaffold(
        appBar: new AppBar(title: Text("Select Account Type"),
        ),
        backgroundColor: Colors.white,
        body:
        Form(
          key: _formKey,
          child: ListView(
            shrinkWrap: true,
            padding: EdgeInsets.only(left: 24.0, right: 24.0),
            children: <Widget>[
              SizedBox(height: 33.0),
              Text("What kind of account do you want to create?",
                  textAlign: TextAlign.center,
                  style:TextStyle(
                    fontSize: 32.0,
                    color: Colors.lightBlue)
              ),
              SizedBox(height: 10.0),
              employeeButton,
              SizedBox(height: 10.0),
              businessOwnerButton,
              SizedBox(height: 10.0),
              customerButton,
              logo
            ],
          ),
        )
    );
  }

}
