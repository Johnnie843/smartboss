import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:myapp/model/User.dart';

class UserService{


    User currentUser;
    Future<User> getUserProfile(String uid) async{

    DocumentSnapshot snapshot = await Firestore.instance.collection("users").document(uid).get();


    currentUser = new User(uid, snapshot['email'], snapshot['fname'], snapshot['lname'], snapshot['newUser'], snapshot['userType']);

    return currentUser;

  }

    void updateUserFName(uid, _fname) async{

        Firestore.instance.runTransaction((Transaction transaction)async{

            Firestore.instance.collection("users").document(uid).setData({"fname":_fname},merge: true);

        });

    }

}