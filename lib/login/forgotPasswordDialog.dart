import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:myapp/login/loginPage.dart';




class ForgotPasswordDialog extends StatefulWidget {

  static String tag = 'login-page';



  @override
  _ForgotPasswordDialogState createState() => _ForgotPasswordDialogState();
}

class _ForgotPasswordDialogState extends State<ForgotPasswordDialog> {
  String _email;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {




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


    final sendReset = Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Material(
        clipBehavior: Clip.antiAlias,
        borderRadius: BorderRadius.circular(30.0),
        shadowColor: Colors.lightBlueAccent.shade100,
        elevation: 5.0,
        child: MaterialButton(
            minWidth: 200.0,
            height: 42.0,
            onPressed: () {
              try {
                sendPasswordReset(_email);
              }catch(e){
                print(e);
              }
              Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
            },
            color: Colors.lightBlueAccent,
            child: Text(
              "Reset Password",
              style: TextStyle(color: Colors.white),
            )),
      ),
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
                  colorFilter: new ColorFilter.mode(Colors.white.withOpacity(0.4), BlendMode.dstATop),
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
                      logo,
                      SizedBox(height: 14.0),
                      email,
                      SizedBox(height: 8.0),
                      sendReset,
                    ],
                  ),
                ))
          ],
        ));
  }


  Future<void> sendPasswordReset(String email) async {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: "johntylercooper@icloud.com");
  }

}
