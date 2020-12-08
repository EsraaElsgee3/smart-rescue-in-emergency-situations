import 'package:agdourapp2/database.dart';
import 'package:agdourapp2/myprofile.dart';
import 'package:agdourapp2/user.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  // create user obj based on firebase user
  User _userFromFirebaseUser(FirebaseUser user) {
    return user != null ? User(uid: user.uid) : null;
  }

  // auth change user stream
  Stream<User> get user {
    return _auth.onAuthStateChanged
    //.map((FirebaseUser user) => _userFromFirebaseUser(user));
        .map(_userFromFirebaseUser);
  }

  Future<String>getCurrentUID()async{
    return (await _auth.currentUser()).uid;
  }
  // sign in anon
  Future signInAnon() async {
    try {
      AuthResult result = await _auth.signInAnonymously();
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // sign in with email and password
  Future signInWithEmailAndPassword(String EmailAddress, String Password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(email: EmailAddress, password: Password);
      FirebaseUser user = result.user;
      await MyProfile(user: user);
      return _userFromFirebaseUser(user);
    } catch (error) {
      print(error.toString());
      return null;
    }}
  // register with email and password
  Future registerWithEmailAndPassword(
      String FullName,String DateofBirth,String Gender,String MobileNumber,String EmergencyContact,
      String Address,String NationalID, String EmailAddress,String Password,String myImg,
      String bloodType , String diabetesRate, String bloodPressure,
      String medications, String surgery, String height, String weight,) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(email: EmailAddress, password: Password);
      FirebaseUser user = result.user;
      //create a new document for the user with uid
      await DatabaseService(uid: user.uid).updateUserData(FullName, DateofBirth, Gender,
          MobileNumber, EmergencyContact, Address, NationalID, EmailAddress,Password,myImg,
          bloodType , diabetesRate, bloodPressure, medications, surgery, height, weight,);
      return _userFromFirebaseUser(user);
    } catch (error) {
      print(error.toString());
      return null;
    }}

  // sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

}





/*
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/widgets.dart';


class UserToDatabase {

  addNewUser(user , context) {
    FirebaseDatabase.instance.reference().child('users')
        .push().set({
      'email' : user.email,
      'uid' : user.uid
    }).then((value){
      Navigator.of(context).pop();
      Navigator.of(context).pushReplacementNamed('/home');

    }).catchError((e){
      print(e);
    });
  }
}*/
