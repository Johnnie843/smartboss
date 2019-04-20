import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:myapp/pages/HomePage.dart';
import 'package:myapp/pages/dialogs/CreateBusinessAccountPage.dart';
import 'package:myapp/pages/dialogs/CreateEmployeeAccountPage.dart';
import 'package:myapp/pages/CreateAccountPage.dart';
import 'package:myapp/pages/dialogs/ForgotPasswordDialog.dart';



class LoginPage extends StatefulWidget {

  static String tag = 'login-page';

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {


  String _email, _password;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {


    Future _openForgotPasswordDialog() async{
      await Navigator.of(context).push(MaterialPageRoute(builder: (context) => ForgotPasswordDialog(), fullscreenDialog: true));
    }

    Future _openCreateAccountDialog() async{
      await Navigator.of(context).push(MaterialPageRoute(builder: (context) => CreateAccountPage(), fullscreenDialog: true));
    }

    final logo = Hero(
      tag: 'hero',
      child: CircleAvatar(
        backgroundColor: Colors.transparent,
        radius: 100.0,
        child: Image.asset("assets/images/logo.png"),
      ),
    );

    final email = TextFormField(
      keyboardType: TextInputType.emailAddress,
      autofocus: false,
      validator: (input){
        if(input.isEmpty){
          return 'Please enter your email';
        }
      },
      onSaved: (input) => _email = input,
      decoration: InputDecoration(
          labelText: 'Email',
          contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          border:
          OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );

    final password = TextFormField(
      autofocus: false,

      validator: (input){
        if(input.length < 6){
          return 'Please enter a valid password!';
        }
      },
      onSaved: (input) => _password = input,
      obscureText: true,
      decoration: InputDecoration(
          labelText: 'Password',
          contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          border:
          OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
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
              signInFirebaseValidation();
            },
            color: Colors.lightBlueAccent,
            child: Text(
              "Log In",
              style: TextStyle(color: Colors.white),
            )),
      ),
    );



    final createAccountButton = FlatButton(
      child: Text(
        'Create An Account',
        style: TextStyle(color: Colors.lightBlue),
      ),
      onPressed: (){_openCreateAccountDialog();},
    );

    final forgotPassword = FlatButton(

      child: Text(
        'Forgot Password?',
        style: TextStyle(color: Colors.lightBlue),
      ),
      onPressed: (){
        _openForgotPasswordDialog();
      },
    );

    return Scaffold(
        backgroundColor: Colors.white,
        body: new Stack(
          children: <Widget>[
            new Container(
              decoration: new BoxDecoration(
                image: new DecorationImage(
                  image: new AssetImage("assets/images/background.png"),
                  fit: BoxFit.fill,
                  colorFilter: new ColorFilter.mode(Colors.white.withOpacity(0.7), BlendMode.dstATop),
                ),
              ),
            ),
            Form(
                key: _formKey,
                child: Center(
                  child: ListView(
                    shrinkWrap: true,
                    padding: EdgeInsets.only(left: 24.0, right: 24.0),
                    children: <Widget>[
                      SizedBox(height: 100.0),
                      logo,
                      SizedBox(height: 14.0),
                      email,
                      SizedBox(height: 8.0),
                      password,
                      SizedBox(height: 8.0),
                      loginButton,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[

                          Container(child: createAccountButton,),
                          Container(child: forgotPassword,)
                        ],
                      )
                    ],
                  ),
                ))
          ],
        ));
  }

  Future<void> signInFirebaseValidation() async{

    final formState = _formKey.currentState;

    if(formState.validate()){

      formState.save();
      try {
        FirebaseUser user = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: _email, password: _password);
        Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage(user: user)));
      }
      catch(e){
        print(e.message);
      }
    }


  }
}
