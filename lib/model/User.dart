import 'package:flutter/material.dart';


class User{

    String _uid;
    String _fname;
    String _lname;
    bool _newUser;
    int _userType;

    User(String uid, String fname, String lname, bool newUser, int userType){

         _uid = uid;
         _fname = fname;
         _lname = lname;
         _newUser = newUser;
         _userType = userType;
    }

    set uidSet(String uid){
      _uid = uid;
    }

    String get uidGet{
      return _uid;
    }

    set fnameSet(String fname){
      _fname = fname;
    }

    String get fnameGet{
      return _fname;
    }

    set lnameSet(String lname){
      _lname = lname;
    }

    String get lnameGet{
      return _lname;
    }

    set newUserSet(bool newUser){
      _newUser = newUser;
    }

    bool get newUserGet{
      return _newUser;
    }

    set userType(int userType){
      _userType = userType;
    }

    int get userTypeGet{
      return _userType;
    }

    String describeUser(){
      return ("UID: $_uid | fname: $_fname | lname: $_lname | newUser: $_newUser | userType: $_userType");
    }
}


