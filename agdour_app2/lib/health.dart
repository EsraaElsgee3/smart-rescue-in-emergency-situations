import 'package:agdourapp2/Dialogs.dart';
import 'package:agdourapp2/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Health extends StatefulWidget {
  @override
  _State createState() => _State();
}
class _State extends State<Health> {

  final GlobalKey<State> _keyLoader = new GlobalKey<State>();
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

  String bloodType;
  String diabetesRate;
  String bloodPressure;
  String medications;
  String surgery;
  String height;
  String weight;

  String error;

  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isSwitched = false;
  List<String> bloodTypes = ['A+', 'A-', 'B+', 'B-', 'AB', 'O+', 'O-'];
  String selectedItem = 'A+';
  int selectedDiabetes;
  int selectedBloodPressure;
  List<DropdownMenuItem<String>> getMenuItems() {
    List<DropdownMenuItem<String>> menuItems = [];
    for (int i = 0; i < bloodTypes.length - 1; i++) {
      String type = bloodTypes[i];
      var newItem = DropdownMenuItem<String>(
        child: Text(type),
        value: type,
      );
      menuItems.add(newItem);
    }
    return menuItems;
  }

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
    });
    final uid = userD.uid;
  }

  @override
  void initState() {
    super.initState();
    inputData();
  }


  void getDiabetesSelected(int value) {
    if (value == 1) {
      selectedDiabetes = value;
      setState(() {
        diabetesRate = 'Normal';
      });
    } else if (value == 2) {
      selectedDiabetes = 2;
      setState(() {
        diabetesRate = 'Low';
      });
    }
    else if (value == 3) {
      selectedDiabetes = 3;
      setState(() {
        diabetesRate = 'High';
      });
    }

  }

  void getBloodPressureSelected(int value) {
    if (value == 1) {
      selectedBloodPressure = value;
      setState(() {
        bloodPressure = 'Normal';
      });
    } else if (value == 2) {
      selectedBloodPressure = 2;
      setState(() {
        bloodPressure = 'Low';
      });
    }
    else if (value == 3) {
      selectedBloodPressure = 3;
      setState(() {
        bloodPressure = 'High';
      });
    }
  }
  bool _updating = false;
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
  Widget build(BuildContext context) {
    var body =Container(
      decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/pn.jpg'),
            fit: BoxFit.cover,
          )),
      child: Scaffold(
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            child: Container(
                padding: EdgeInsets.only(top: 15),
                child: Column(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.fromLTRB(15,0,15,15),
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
                      SizedBox(
                        width: 250,
                        child: DropdownButtonFormField<String>(
                          iconEnabledColor: Colors.black,
                          iconSize: 25,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(left: 30, right: 15),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(15.0),
                              ),
                              borderSide: BorderSide.none,
                            ),
                            filled: true,
                            fillColor: Colors.white,
                          ),
                          value: selectedItem,
                          onChanged: (value) {
                            print(value);
                            setState(() {
                              selectedItem = value;
                              bloodType = value;
                            });
                          },
                          items: getMenuItems(),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                          padding: EdgeInsets.all(15),
                          child: Row(children: <Widget>[
                            Icon(
                              Icons.trending_up,
                              size: 20,
                              color: Colors.black,
                            ),
                            SizedBox(
                              width: 5.0,
                            ),
                            Text(
                              'Are you diabetic?',
                              style: TextStyle(fontSize: 25),
                            ),
                          ])),
                      SizedBox(
                        height: 5.0,
                      ),
                      SizedBox(
                        width: 450.0,
                        height: 30.0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Radio(
                              activeColor: Colors.blue,
                              value: 1,
                              groupValue: selectedDiabetes,
                              onChanged: (int value) {
                                setState(() {
                                  getDiabetesSelected(value);
                                });
                              },
                            ),
                            Text(
                              'Normal',
                              style: TextStyle(fontSize: 20.0),
                            ),
                            Radio(
                              activeColor: Colors.blue,
                              value: 2,
                              groupValue: selectedDiabetes,
                              onChanged: (int value) {
                                setState(() {
                                  getDiabetesSelected(value);
                                });
                              },
                            ),
                            Text(
                              'low',
                              style: TextStyle(fontSize: 20.0),
                            ),
                            Radio(
                              activeColor: Colors.blue,
                              value: 3 ,
                              groupValue: selectedDiabetes,
                              onChanged: (int value) {
                                setState(() {
                                  getDiabetesSelected(value);
                                }
                                );
                              },
                            ),
                            Text(
                              'high',
                              style: TextStyle(fontSize: 20.0),
                            )
                          ],
                        ),
                      ),
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
                      SizedBox(
                        width: 450.0,
                        height: 30.0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Radio(
                              activeColor: Colors.blue,
                              value: 1,
                              groupValue: selectedBloodPressure,
                              onChanged: (int value) {
                                setState(() {
                                  getBloodPressureSelected(value);
                                });
                              },
                            ),
                            Text(
                              'Normal',
                              style: TextStyle(fontSize: 20.0),
                            ),
                            Radio(
                              activeColor: Colors.blue,
                              value: 2,
                              groupValue: selectedBloodPressure,
                              onChanged: (int value) {
                                setState(() {
                                  getBloodPressureSelected(value);
                                });
                              },
                            ),
                            Text(
                              'low',
                              style: TextStyle(fontSize: 20.0),
                            ),
                            Radio(
                              activeColor: Colors.blue,
                              value: 3,
                              groupValue: selectedBloodPressure,
                              onChanged: (int value) {
                                setState(() {
                                  getBloodPressureSelected(value);
                                });
                              },
                            ),
                            Text(
                              'high',
                              style: TextStyle(fontSize: 20.0),
                            ),
                          ],
                        ),
                      ),
                      Container(
                          padding: EdgeInsets.all(15),
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
                      SizedBox(
                          width: 250.0,
                          height: 40,
                          child: TextField(
                            onChanged: (val){
                              if (val != null)
                              setState(() => medications = val );
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
                              hintText: 'Enter Allergic',
                              hintStyle: TextStyle(
                                color: Colors.grey,
                              ),
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
                            SizedBox(
                              width: 32,
                            ),
                            Switch(
                                value: isSwitched,
                                onChanged: (value) {
                                  setState(() {
                                    isSwitched = value;
                                    print(isSwitched);
                                    if(value == false)
                                      surgery = "I've never had surgery before";
                                    else
                                      surgery = "I have surgery before";
                                  });
                                },
                                activeTrackColor: Colors.lightBlueAccent,
                                activeColor: Colors.blue)
                          ])),
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
                            SizedBox(
                              width: 150,
                            ),
                            SizedBox(
                                width: 65.0,
                                height: 40,
                                child: TextField(
                                  onChanged: (val){
                                    setState(() => height = val );
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
                                    hintText: '1.8 m',
                                    hintStyle: TextStyle(
                                      color: Colors.grey,
                                    ),
                                  ),
                                )),
                          ])),
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
                            SizedBox(
                              width: 150,
                            ),
                            SizedBox(
                                width: 65.0,
                                height: 40,
                                child: TextField(
                                  onChanged: (val){
                                    setState(() => weight = val );
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
                                    hintText: '60 kg',
                                    hintStyle: TextStyle(
                                      color: Colors.grey,
                                    ),
                                  ),
                                )),
                          ])),
                      Container(
                          height: 70,
                          padding: EdgeInsets.all(15),
                          child: RaisedButton(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),

                              color: Colors.blueAccent,
                              padding: EdgeInsets.fromLTRB(100, 4, 100,4),
                              child: Text(
                                'Update',
                                style: TextStyle(fontSize: 23, color: Colors.white),
                              ),
                            onPressed: () {
                              updateMyData();
                              //_onUpdating();
                            },
                          ))
                    ])),
          )),
    );
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
          title:  Icon(
            Icons.check_circle,
            size: 50,
            color: Colors.blue,
          ),
          content: Text( '          Successfully Updated ',
            style: TextStyle(
                fontWeight: FontWeight.bold),
          ),
        ));
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

    //personal
    FullName = snapshot.data['FullName'];
    DateofBirth = snapshot.data['Date of Birth'];
    Gender = snapshot.data['Gender'];
    MobileNumber = snapshot.data['MobileNumber'];
    EmergencyContact = snapshot.data['EmergencyContact'];
    Address = snapshot.data['Address'];
    NationalID = snapshot.data['NationalID'];
    EmailAddress = snapshot.data['EmailAddress'];
    Password = snapshot.data['Password'];

    //health
    if( bloodType == null)
      bloodType =snapshot.data['bloodType'];
    if( diabetesRate == null)
      diabetesRate =snapshot.data['diabetesRate'];
    if( bloodPressure == null)
      bloodPressure =snapshot.data['bloodPressure'];
    if( medications == null)
      medications =snapshot.data['medications'];
    if( surgery == null)
      surgery =snapshot.data['surgery'];
    if( height == null)
      height =snapshot.data['height'];
    if( weight == null)
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


















