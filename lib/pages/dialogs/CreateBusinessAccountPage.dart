import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:myapp/pages/LoginPage.dart';



class CreateBusinessAccountPage extends StatefulWidget {

  static String tag = 'create-business-account-page';


  @override
  _CreateBusinessAccountPageState createState() => _CreateBusinessAccountPageState();
}

class _CreateBusinessAccountPageState extends State<CreateBusinessAccountPage> {

  String _email, _password, _fname, _lname, _buisnessName;

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
          return 'Please enter a email';
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

    final businessName = TextFormField(
      autofocus: false,
      onSaved: (input) => _buisnessName = input,
      decoration: InputDecoration(
          labelText: 'Business Name',
          contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          border:
          OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );

    final firstName = TextFormField(
      autofocus: false,
      onSaved: (input) => _fname = input,
      decoration: InputDecoration(
          labelText: 'First Name',
          contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          border:
          OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );

    final lastName = TextFormField(
      autofocus: false,
      onSaved: (input) => _lname = input,
      decoration: InputDecoration(
          labelText: 'Last Name',
          contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          border:
          OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );



    final submitButton = Padding(
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
              signUpFirebaseValidation();
            },
            color: Colors.lightBlueAccent,
            child: Text(
              "Create Account",
              style: TextStyle(color: Colors.white),
            )),
      ),
    );


    return Scaffold(
        appBar: new AppBar(
          title: new Text("Create a Business Account"),
        ),
        backgroundColor: Colors.white,
        body:
        Form(
          key: _formKey,
          child: ListView(
            shrinkWrap: true,
            padding: EdgeInsets.only(left: 24.0, right: 24.0),
            children: <Widget>[
              SizedBox(height: 28.0),
              email,
              SizedBox(height: 12.0),
              password,
              SizedBox(height: 12.0),
              businessName,
              SizedBox(height: 12.0),
              firstName,
              SizedBox(height: 12.0),
              lastName,
              SizedBox(height: 14.0),
              submitButton,
              SizedBox(height: 14.0),
              logo
            ],
          ),
        )
    );
  }


  Future<void> signUpFirebaseValidation() async{

    final formState = _formKey.currentState;

    if(formState.validate()){
      formState.save();
      try {

        FirebaseUser user = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: _email, password: _password);
        // user.sendEmailVerification();

        Firestore.instance.runTransaction((Transaction transaction)async{

          Firestore.instance.collection("users").document(user.uid).setData({"userType":1,"fname":_fname,"lname":_lname, },merge: true);
          Firestore.instance.collection("business").document().setData({"name":_buisnessName, "owner":user.uid},merge: true);

        });


        Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));

      }

      catch(e){
        print(e.message);
      }
    }


  }

}
