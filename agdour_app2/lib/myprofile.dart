import 'dart:io';
import 'package:agdourapp2/DB.dart';
import 'package:agdourapp2/Dialogs.dart';
import 'package:agdourapp2/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';

class MyProfile extends StatefulWidget {

  final FirebaseUser user;
  MyProfile({ this.user });


  //final databaseReference = Firestore.instance;

  @override
  _State createState() => _State();

}
class _State extends State<MyProfile> {

  final GlobalKey<State> _keyLoader = new GlobalKey<State>();
  final AuthService _auth = AuthService();
  final _FormKey = GlobalKey<FormState>();

  //text field state
  String FullName;
  String DateofBirth;
  String Gender;
  String MobileNumber;
  String EmergencyContact;
  String Address;
  String NationalID;
  String EmailAddress;
  String Password;
  String myImg;

  String bloodType ;
  String diabetesRate;
  String bloodPressure;
  String medications;
  String surgery;
  String height;
  String weight;
  String error;
  File _image;
  bool _updating = false;

  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  int selectedDateofBirth;


  FirebaseUser userD;

  DocumentSnapshot snapshot;
  final db = Firestore.instance;

  Future<void> inputData() async {
    final FirebaseUser userData = await FirebaseAuth.instance.currentUser();
    DocumentSnapshot snap =
    await db.collection('personal').document(userData.uid).get();
    setState(() {
      userD = userData;
      snapshot = snap;
      print(userData.uid);
      print(snapshot.data['FullName']);
    });
    final uid = userD.uid;
  }

  void _onUpdating() {
    setState(() {
      _updating = true;
      Future.delayed(new Duration(seconds: 2), _update);
    });
  }

  Future _update() async{
    setState((){
      _updating = false;
      Future.delayed(Duration.zero, () => showAlert(context));
    });
  }


  @override
  void initState() {
    super.initState();
    inputData();
  }

  void getDateofBirth(int value) {
    if (value == 1) {
      selectedDateofBirth = value;
      setState(() {
        Gender = 'male';
      });
    } else if (value == 2) {
      selectedDateofBirth = 2;
      setState(() {
        Gender = 'Female';
      });
    }
    else {
      selectedDateofBirth = value;
      setState(() {
        Gender = 'male';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Future getImage() async {
      var image = await ImagePicker.pickImage(source: ImageSource.gallery);

      setState(() {
        _image = image;
        print('Image Path $_image');
      });
    }

    var body=Container(
      decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/pn.jpg'),
            fit: BoxFit.cover,
          )
      ),


      child: MaterialApp(
          home: Scaffold(
              backgroundColor: Colors.transparent,
              body: SingleChildScrollView(
                child: Form(
                  key: _FormKey,
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
                                    child: _image != null
                                        ? Image.file(
                                      _image,
                                      fit: BoxFit.fill,
                                    )
                                        : Image.asset('assets/pic.jpg'),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 60.0),
                              child: IconButton(
                                icon: Icon(
                                  FontAwesomeIcons.camera,
                                  size: 30.0,
                                ),
                                onPressed: () {
                                  getImage();
                                },
                              ),
                            ),
                          ],
                        ),


                        Container(padding: EdgeInsets.all(15),

                            child: Row(children: <Widget>[
                              Icon(
                                Icons.account_box,
                                size: 25,
                                color: Colors.black,
                              ),
                              Text(
                                'Full Name',
                                style: TextStyle(fontSize: 22),
                              ),

                            ])),
                        SizedBox(
                            width: 250.0,
                            height: 40,
                            child: TextField(

                              onChanged: (val) {
                                setState(() => FullName = val);
                              },

                              decoration: InputDecoration(
                                alignLabelWithHint: true,
                                fillColor: Colors.white,
                                filled: true,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10.0),
                                  ),
                                  borderSide: BorderSide.none,
                                ),
                                hintText: 'Enter Name',
                                hintStyle: TextStyle(
                                  color: Colors.grey,
                                ),
                              ),
                            )
                        ),
                        Container(padding: EdgeInsets.all(15),
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
                        SizedBox(
                            width: 250.0,
                            height: 40,
                            child: TextField(
                              onChanged: (val) {
                                setState(() => DateofBirth = val);
                              },
                              decoration: InputDecoration(
                                alignLabelWithHint: true,
                                fillColor: Colors.white,
                                filled: true,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10.0),
                                  ),
                                  borderSide: BorderSide.none,
                                ),
                                hintText: '1/1/1998',
                                hintStyle: TextStyle(
                                  color: Colors.grey,
                                ),
                              ),
                            )

                        ),
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
                        SizedBox(
                          height: 5.0,
                        ),
                        SizedBox(
                          width: 250.0,
                          height: 30.0,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Radio(
                                activeColor: Colors.blue,
                                value: 1,
                                groupValue: selectedDateofBirth,
                                onChanged: (int value) {
                                  setState(() {
                                    getDateofBirth(value);
                                  });
                                },
                              ),
                              Text(
                                'male',
                                style: TextStyle(fontSize: 20.0),
                              ),
                              Radio(
                                activeColor: Colors.blue,
                                value: 2,
                                groupValue: selectedDateofBirth,
                                onChanged: (int value) {
                                  setState(() {
                                    getDateofBirth(value);
                                  });
                                },
                              ),
                              Text(
                                'female',
                                style: TextStyle(fontSize: 20.0),
                              ),
                            ],
                          ),
                        ),
                        Container(padding: EdgeInsets.all(15),
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
                        SizedBox(
                            width: 250.0,
                            height: 40,
                            child: TextField(

                              onChanged: (val) {
                                setState(() => MobileNumber = val);
                              },
                              decoration: InputDecoration(
                                alignLabelWithHint: true,
                                fillColor: Colors.white,
                                filled: true,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10.0),
                                  ),
                                  borderSide: BorderSide.none,
                                ),
                                hintText: '010********',
                                hintStyle: TextStyle(
                                  color: Colors.grey,
                                ),
                              ),
                            )

                        ),
                        Container(padding: EdgeInsets.all(15),
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
                        SizedBox(
                            width: 250.0,
                            height: 40,
                            child: TextField(
                              onChanged: (val) {
                                setState(() => EmergencyContact = val);
                              },
                              decoration: InputDecoration(
                                alignLabelWithHint: true,
                                fillColor: Colors.white,
                                filled: true,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10.0),
                                  ),
                                  borderSide: BorderSide.none,
                                ),
                                hintText: '010*********',
                                hintStyle: TextStyle(
                                  color: Colors.grey,
                                ),
                              ),
                            )

                        ),
                        Container(padding: EdgeInsets.all(15),
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
                        SizedBox(
                            width: 250.0,
                            height: 40,
                            child: TextField(
                              onChanged: (val) {
                                setState(() => Address = val);
                              },
                              decoration: InputDecoration(
                                alignLabelWithHint: true,
                                fillColor: Colors.white,
                                filled: true,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10.0),
                                  ),
                                  borderSide: BorderSide.none,
                                ),
                                hintText: 'Address',
                                hintStyle: TextStyle(
                                  color: Colors.grey,
                                ),
                              ),
                            )

                        ),

                        Container(padding: EdgeInsets.all(15),
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
                        SizedBox(
                            width: 250.0,
                            height: 40,
                            child: TextField(
                              onChanged: (val) {
                                setState(() => NationalID = val);
                              },
                              decoration: InputDecoration(
                                alignLabelWithHint: true,
                                fillColor: Colors.white,
                                filled: true,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10.0),
                                  ),
                                  borderSide: BorderSide.none,
                                ),
                                hintText: '**************',
                                hintStyle: TextStyle(
                                  color: Colors.grey,
                                ),
                              ),
                            )

                        ),


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
                        SizedBox(
                            width: 250.0,
                            height: 40,
                            child: TextField(
                              onChanged: (val) {
                                setState(() => EmailAddress = val);
                              },
                              decoration: InputDecoration(
                                alignLabelWithHint: true,
                                fillColor: Colors.white,
                                filled: true,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10.0),
                                  ),
                                  borderSide: BorderSide.none,
                                ),
                                hintText: 'Email',
                                hintStyle: TextStyle(
                                  color: Colors.grey,
                                ),
                              ),
                            )),
                        Container(padding: EdgeInsets.all(15),
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
                        SizedBox(
                            width: 250.0,
                            height: 40,
                            child: TextField(
                              onChanged: (val) {
                                setState(() => Password = val);
                              },
                              decoration: InputDecoration(
                                alignLabelWithHint: true,
                                fillColor: Colors.white,
                                filled: true,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10.0),
                                  ),
                                  borderSide: BorderSide.none,
                                ),
                                hintText: 'password',
                                hintStyle: TextStyle(
                                  color: Colors.grey,
                                ),
                              ),
                            )
                        ),
                        Container(
                            height: 70,
                            padding: EdgeInsets.all(15),
                            child: RaisedButton(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),

                              color: Colors.blueAccent,
                              padding: EdgeInsets.fromLTRB(100, 4, 100, 4),
                              child: Text(
                                'Update',
                                style: TextStyle(
                                    fontSize: 23, color: Colors.white),
                              ),
                              onPressed: () async {
                                updateMyData();
                              },
                            ))
                      ])),
                ),))),);
    var bodyProgress = new Container(
      child: new Stack(
        children: <Widget>[
          body,
          new Container(
            alignment: AlignmentDirectional.center,
            decoration: new BoxDecoration(
              color: Colors.white70,
            ),
            child: new Container(
              decoration: new BoxDecoration(
                  color: Colors.blue[200],
                  borderRadius: new BorderRadius.circular(10.0)
              ),
              width: 300.0,
              height: 200.0,
              alignment: AlignmentDirectional.center,
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new Center(
                    child: new SizedBox(
                      height: 50.0,
                      width: 50.0,
                      child: new CircularProgressIndicator(
                        value: null,
                        strokeWidth: 7.0,
                      ),
                    ),
                  ),
                  new Container(
                    margin: const EdgeInsets.only(top: 25.0),
                    child: new Center(
                      child: new Text(
                        "Updating.. wait...",
                        style: new TextStyle(
                            color: Colors.white
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );

    return new Scaffold(
      body: new Container(
          decoration: new BoxDecoration(
              color: Colors.blue[200]
          ),
          child: _updating ? bodyProgress : body
      ),

    );
  }
  void showAlert(BuildContext context) {
    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Icon(
            Icons.check_circle,
            size: 50,
            color: Colors.blue,
          ),
          content: Text( '          Successfully Updated',
            style: TextStyle(
                fontWeight: FontWeight.bold),
          ),));
  }

  void sendData(BuildContext context){
    var alertDialog=AlertDialog(
      title:  Icon(
        Icons.check_circle,
        size: 50,
        color: Colors.blue,
      ),
      content: Text(  '          Successfully Updated ',
        style: TextStyle(
            fontWeight: FontWeight.bold),
      ),

    );
    showDialog(
        context: context,
        builder: (BuildContext context){
          return alertDialog;
        });
  }


  Future updateMyData() async {

    if( FullName == null)
      FullName = snapshot.data['FullName'];
    if( DateofBirth == null)
      DateofBirth = snapshot.data['Date of Birth'];
    if( Gender == null)
      Gender = snapshot.data['Gender'];
    if( MobileNumber == null)
      MobileNumber = snapshot.data['MobileNumber'];
    if( EmergencyContact == null)
      EmergencyContact = snapshot.data['EmergencyContact'];
    if( Address == null)
      Address = snapshot.data['Address'];
    if( NationalID == null)
      NationalID = snapshot.data['NationalID'];
    if( EmailAddress == null)
      EmailAddress = snapshot.data['EmailAddress'];
    if( Password == null)
      Password = snapshot.data['Password'];

    myImg =snapshot.data['myImg'];
    bloodType =snapshot.data['bloodType'];
    diabetesRate =snapshot.data['diabetesRate'];
    bloodPressure =snapshot.data['bloodPressure'];
    medications =snapshot.data['medications'];
    surgery =snapshot.data['surgery'];
    height =snapshot.data['height'];
    weight =snapshot.data['weight'];


    try {
      Dialogs.showLoadingDialog(context, _keyLoader);//invoking
      await DatabaseService(uid: userD.uid).updateUserData(
          FullName,
          DateofBirth,
          Gender,
          MobileNumber,
          EmergencyContact,
          Address,
          NationalID,
          EmailAddress,
          Password,
          myImg,
          bloodType ,
          diabetesRate,
          bloodPressure,
          medications,
          surgery,
          height,
          weight,);
      Navigator.of(_keyLoader.currentContext,rootNavigator: true).pop();//close the dialoge
      sendData(context);
      return userD;
    } catch (error) {
      print(error.toString());
      return null;
    }

  }
}