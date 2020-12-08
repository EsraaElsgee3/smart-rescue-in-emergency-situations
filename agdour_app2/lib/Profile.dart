import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreCRUDPage extends StatefulWidget {
  @override
  FirestoreCRUDPageState createState() {
    return FirestoreCRUDPageState();
  }
}

class FirestoreCRUDPageState extends State<FirestoreCRUDPage> {
  FirebaseUser user;

  DocumentSnapshot snapshot;
  final db = Firestore.instance;

  Future<void> inputData() async {
    final FirebaseUser userData = await FirebaseAuth.instance.currentUser();
    DocumentSnapshot snap =
        await db.collection('personal').document(userData.uid).get();
    setState(() {
      user = userData;
      snapshot = snap;
      print(userData.uid);
      print(snapshot.data['FullName']);
      print(snapshot.data['myImg']);
    });
    final uid = user.uid;
  }

  @override
  void initState() {
    super.initState();
    inputData();
  }

  Widget showData() {
    if (snapshot != null && snapshot.data['FullName'] != null && user != null) {
      return Container(
        decoration: BoxDecoration(
          image: DecorationImage(
          image: AssetImage('assets/pn.jpg'),
        fit: BoxFit.cover,
        )),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            child: Container(
                padding: EdgeInsets.only(top: 20),
                child: Column(children: <Widget>[
                Row(
                mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Align(
                        alignment: Alignment.center,
                        child: CircleAvatar(
                          radius: 90,
                          backgroundColor: Colors.lightBlue,
                          child: ClipOval(
                            child: new SizedBox(
                              width: 160.0,
                              height: 160.0,
                              child:  Image.network('${snapshot.data['myImg']}',fit: BoxFit.fill),
                            ),
                          ),
                        ),
                      ),],),
                  SizedBox(
                    height: 10.0,
                  ),
                  Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(.2),
                      child: Text(
                        'personal Info',
                        style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.w500,
                            fontSize: 25),
                      )),
                  SizedBox(
                    height: 10.0,
                  ),
                  Container(
                      padding: EdgeInsets.all(15),
                      child: Row(children: <Widget>[
                        Icon(
                          Icons.account_box,
                          size: 25,
                          color:  Colors.black,
                        ),
                        Text(
                          'Name',
                          style: TextStyle(fontSize: 22),
                        ),
                      ])),
                  Card(
                      color: Colors.white,
                      margin: EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 25.0),
                      child: ListTile(

                        title: Text(
                            '${snapshot.data['FullName']}',
                          style: TextStyle(
                              fontFamily: 'BalooBhai', fontSize: 20.0),
                        ),
                      )),
                  Container(
                      padding: EdgeInsets.all(15),
                      child: Row(children: <Widget>[
                        Icon(
                          Icons.date_range,
                          size: 25,
                          color: Colors.black,
                        ),
                        Text(
                          'Date of Birth ',
                          style: TextStyle(fontSize: 22),
                        ),
                      ])),
                Card(
                    color: Colors.white,
                    margin: EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 25.0),
                    child: ListTile(

                      title: Text(
                        '${snapshot.data['Date of Birth']}',
                        style: TextStyle(
                            fontFamily: 'BalooBhai', fontSize: 20.0),
                      ),
                    )),
                  Container(
                      padding: EdgeInsets.all(15),
                      child: Row(children: <Widget>[
                        Icon(
                          Icons.compare_arrows,
                          size: 30,
                          color: Colors.black,
                        ),
                        SizedBox(
                          width: 5.0,
                        ),
                        Text(
                          'Gender',
                          style: TextStyle(fontSize: 25),
                        ),
                      ])),

                  Card(
                      color: Colors.white,
                      margin: EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 25.0),
                      child: ListTile(

                        title: Text(
                          '${snapshot.data['Gender']}',
                          style: TextStyle(
                              fontFamily: 'BalooBhai', fontSize: 20.0),
                        ),
                      )),

                  Container(
                      padding: EdgeInsets.all(15),
                      child: Row(children: <Widget>[
                        Icon(
                          Icons.phone,
                          size: 25,
                          color: Colors.black,
                        ),
                        Text(
                          'Mobile Number ',
                          style: TextStyle(fontSize: 22),
                        ),
                      ])),
                  Card(
                      color: Colors.white,
                      margin: EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 25.0),
                      child: ListTile(

                        title: Text(
                          '${snapshot.data['MobileNumber']}',
                          style: TextStyle(
                              fontFamily: 'BalooBhai', fontSize: 20.0),
                        ),
                      )),
                  Container(
                      padding: EdgeInsets.all(15),
                      child: Row(children: <Widget>[
                        Icon(
                          Icons.phone_in_talk,
                          size: 25,
                          color: Colors.black,
                        ),
                        Text(
                          'Emergency Contact ',
                          style: TextStyle(fontSize: 22),
                        ),
                      ])),
                  Card(
                      color: Colors.white,
                      margin: EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 25.0),
                      child: ListTile(

                        title: Text(
                          '${snapshot.data['EmergencyContact']}',
                          style: TextStyle(
                              fontFamily: 'BalooBhai', fontSize: 20.0),
                        ),
                      )),
                  Container(
                      padding: EdgeInsets.all(15),
                      child: Row(children: <Widget>[
                        Icon(
                          Icons.location_on,
                          size: 25,
                          color: Colors.black,
                        ),
                        Text(
                          'Address',
                          style: TextStyle(fontSize: 22),
                        ),
                      ])),
                  Card(
                      color: Colors.white,
                      margin: EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 25.0),
                      child: ListTile(

                        title: Text(
                          '${snapshot.data['Address']}',
                          style: TextStyle(
                              fontFamily: 'BalooBhai', fontSize: 20.0),
                        ),
                      )),
                  Container(
                      padding: EdgeInsets.all(15),
                      child: Row(children: <Widget>[
                        Icon(
                          Icons.person,
                          size: 25,
                          color: Colors.black,
                        ),
                        Text(
                          'National ID',
                          style: TextStyle(fontSize: 22),
                        ),
                      ])),
                  Card(
                      color: Colors.white,
                      margin: EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 25.0),
                      child: ListTile(

                        title: Text(
                          '${snapshot.data['NationalID']}',
                          style: TextStyle(
                              fontFamily: 'BalooBhai', fontSize: 20.0),
                        ),
                      )),
                  Container(
                      padding: EdgeInsets.all(15),
                      child: Row(children: <Widget>[
                        Icon(
                          Icons.email,
                          size: 25,
                          color: Colors.black,
                        ),
                        Text(
                          'Email Address',
                          style: TextStyle(fontSize: 22),
                        ),
                      ])),
                  Card(
                      color: Colors.white,
                      margin: EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 25.0),
                      child: ListTile(

                        title: Text(
                          '${snapshot.data['EmailAddress']}',
                          style: TextStyle(
                              fontFamily: 'BalooBhai', fontSize: 20.0),
                        ),
                      )),
                  Container(
                      padding: EdgeInsets.all(15),
                      child: Row(children: <Widget>[
                        Icon(
                          Icons.lock,
                          size: 25,
                          color: Colors.black,
                        ),
                        Text(
                          'Password ',
                          style: TextStyle(fontSize: 22),
                        ),
                      ])),
                  Card(
                      color: Colors.white,
                      margin: EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 25.0),
                      child: ListTile(

                        title: Text(
                          '${snapshot.data['Password']}',
                          style: TextStyle(
                              fontFamily: 'BalooBhai', fontSize: 20.0),
                        ),
                      )),
                //health info

                SizedBox(
                height: 10.0,
                ),
                Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(.2),
                child: Text(
                'Health Info',
                style: TextStyle(
                color: Colors.blue,
                fontWeight: FontWeight.w500,
                fontSize: 25),
                )),
                SizedBox(
                height: 10.0,
                ),


                Container(
                padding: EdgeInsets.all(15),
                child: Row(
                children: <Widget>[
                Icon(
                Icons.opacity,
                size: 25,
                color: Colors.black,
                ),
                Text(
                'Blood Type',
                style: TextStyle(fontSize: 25),
                ),
                SizedBox(
                height: 5,
                ),
                ],
                ),
                ),
                Card(
                color: Colors.white,
                margin: EdgeInsets.symmetric(
                vertical: 10.0, horizontal: 25.0),
                child: ListTile(

                title: Text(
                '${snapshot.data['bloodType']}',
                style: TextStyle(
                fontFamily: 'BalooBhai', fontSize: 20.0),
                ),
                )),


                Container(
                padding: EdgeInsets.all(15),
                child: Row(children: <Widget>[
                Icon(
                Icons.border_color,
                size: 20,
                color: Colors.black,
                ),
                SizedBox(
                width: 5.0,
                ),
                Text(
                'Diabetes Rate',
                style: TextStyle(fontSize: 25),
                ),
                ])),
                Card(
                color: Colors.white,
                margin: EdgeInsets.symmetric(
                vertical: 10.0, horizontal: 25.0),
                child: ListTile(

                title: Text(
                '${snapshot.data['diabetesRate']}',
                style: TextStyle(
                fontFamily: 'BalooBhai', fontSize: 20.0),
                ),
                )),


                Container(
                padding: EdgeInsets.all(15),
                child: Row(children: <Widget>[
                Icon(
                Icons.sync_problem,
                size: 25,
                color: Colors.black,
                ),
                Text(
                'Blood Pressure',
                style: TextStyle(fontSize: 25),
                ),
                ])),
                Card(
                color: Colors.white,
                margin: EdgeInsets.symmetric(
                vertical: 10.0, horizontal: 25.0),
                child: ListTile(

                title: Text(
                '${snapshot.data['bloodPressure']}',
                style: TextStyle(
                fontFamily: 'BalooBhai', fontSize: 20.0),
                ),
                )),


                Container(
                padding: EdgeInsets.all(25),
                child: Row(children: <Widget>[
                Icon(
                Icons.report_problem,
                size: 25,
                color: Colors.black,
                ),
                Text(
                'Medications that you are allergic to ',
                style: TextStyle(fontSize: 19),
                ),
                ])),
                Card(
                color: Colors.white,
                margin: EdgeInsets.symmetric(
                vertical: 10.0, horizontal: 25.0),
                child: ListTile(

                title: Text(
                '${snapshot.data['medications']}',
                style: TextStyle(
                fontFamily: 'BalooBhai', fontSize: 20.0),
                ),
                )),

                Container(
                padding: EdgeInsets.all(15),
                child: Row(children: <Widget>[
                Icon(
                Icons.sentiment_satisfied,
                size: 25,
                color: Colors.black,
                ),
                Text(
                'Did you have surgery before? ',
                style: TextStyle(fontSize: 16),
                ),
                ])),
                Card(
                color: Colors.white,
                margin: EdgeInsets.symmetric(
                vertical: 10.0, horizontal: 25.0),
                child: ListTile(

                title: Text(
                '${snapshot.data['surgery']}',
                style: TextStyle(
                fontFamily: 'BalooBhai', fontSize: 20.0),
                ),
                )),


                Container(
                padding: EdgeInsets.all(15),
                child: Row(children: <Widget>[
                Icon(
                Icons.accessibility,
                size: 25,
                color: Colors.black,
                ),
                Text(
                'Height ',
                style: TextStyle(fontSize: 25),
                ),

                ])),
                Card(
                color: Colors.white,
                margin: EdgeInsets.symmetric(
                vertical: 10.0, horizontal: 25.0),
                child: ListTile(

                title: Text(
                '${snapshot.data['height']}',
                style: TextStyle(
                fontFamily: 'BalooBhai', fontSize: 20.0),
                ),
                )),


                Container(
                padding: EdgeInsets.all(15),
                child: Row(children: <Widget>[
                Icon(
                Icons.pregnant_woman,
                size: 25,
                color: Colors.black,
                ),
                Text(
                'Weight',
                style: TextStyle(fontSize: 25),
                ),
                ])),
                Card(
                color: Colors.white,
                margin: EdgeInsets.symmetric(
                vertical: 10.0, horizontal: 25.0),
                child: ListTile(

                title: Text(
                '${snapshot.data['weight']}',
                style: TextStyle(
                fontFamily: 'BalooBhai', fontSize: 20.0),
                ),
                )),

                ])),
                ),
                ),
                );
                } else {
                return Center(child: CircularProgressIndicator());
                }
              }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(
          backgroundColor: Colors.lightBlue,
          title: Text('Profile',style: TextStyle(color: Colors.white,fontSize: 30),),),
        body: showData());
  }
}
