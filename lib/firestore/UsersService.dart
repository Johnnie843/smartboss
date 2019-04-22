import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:myapp/model/User.dart';

class UsersService{

  static List<User> users;

  static loadUsers() async {

    users = new List<User>();
    Firestore.instance
        .collection('users')
        .snapshots()
        .listen((snapshot){
          snapshot.documents.forEach((doc)=> users.add(new User(doc.data["uid"],doc.data["email"] , doc.data["fname"] , doc.data["lname"] , doc.data["newUser"] , doc.data["userType"])));
    });
  }

}