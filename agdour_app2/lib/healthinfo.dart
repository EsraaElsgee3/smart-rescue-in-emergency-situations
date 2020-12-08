import 'package:agdourapp2/DB.dart';
import 'package:agdourapp2/appWay.dart';
import 'package:agdourapp2/mainPage.dart';
import 'package:flutter/material.dart';


class Healthinfo extends StatefulWidget {

  final String FullName ;
  final String DateofBirth;
  final String Gender;
  final String MobileNumber;
  final String EmergencyContact;
  final String Address;
  final String NationalID;
  final String EmailAddress;
  final String Password;
  final String myImg;

  const Healthinfo(this.FullName,this.DateofBirth,this.Gender,
  this.MobileNumber,this.EmergencyContact,this.Address,this.NationalID,
  this.EmailAddress,this.Password,this.myImg, {Key key}): super(key: key);


  @override
  _State createState() => _State();
}
class _State extends State<Healthinfo> {

  final AuthService _auth = AuthService();
  String bloodType ='A+';
  String diabetesRate = '';
  String bloodPressure = '';
  String medications = 'Do not take medicines';
  String surgery = "I've never had surgery before";
  String height='';
  String weight='';

  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isSwitched = false;
  List<String> bloodTypes = ['A+', 'A-', 'B+', 'B-', 'AB+','AB-', 'O+', 'O-'];
  String selectedItem = 'A+';
  int selectedDiabetes;
  int selectedBloodPressure;
  List<DropdownMenuItem<String>> getMenuItems() {
    List<DropdownMenuItem<String>> menuItems = [];
    for (int i = 0; i < bloodTypes.length ; i++) {
      String type = bloodTypes[i];
      var newItem = DropdownMenuItem<String>(
        child: Text(type),
        value: type,
      );
      menuItems.add(newItem);
    }
    return menuItems;
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
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/pn.jpg'),
            fit: BoxFit.cover,
          )),
      child: MaterialApp(
          home: Scaffold(
              backgroundColor: Colors.transparent,
              body: SingleChildScrollView(
                child: Container(
                    padding: EdgeInsets.only(top: 30),
                    child: Column(children: <Widget>[
                      Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.all(5),
                          child: Text(
                            'Sign Up',
                            style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.w500,
                                fontSize: 45),
                          )),
                      Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.all(.2),
                          child: Text(
                            'health info',
                            style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.w500,
                                fontSize: 20),
                          )),
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
                        height: 9,
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
                              'Diabetes Rate',
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
                            textColor: Colors.white,
                            color: Colors.blueAccent,
                            padding: EdgeInsets.fromLTRB(100, 4, 100,4),
                            child: Text(
                              'Sign Up',
                              style: TextStyle(fontSize: 23, color: Colors.white),
                            ),
                            onPressed: () async {
                              print (widget.FullName);

                              dynamic result = await _auth.registerWithEmailAndPassword(
                                 widget.FullName,widget.DateofBirth,widget.Gender,widget.MobileNumber,widget.EmergencyContact,
                                  widget.Address,widget.NationalID,widget.EmailAddress,widget.Password,widget.myImg,
                                  bloodType , diabetesRate, bloodPressure, medications, surgery, height, weight,);

                              Navigator.push((context), MaterialPageRoute(
                                builder: (context) => AppWay(),

                              ));
                            },
                          ))
                    ])),
              ))),
    );
  }

}