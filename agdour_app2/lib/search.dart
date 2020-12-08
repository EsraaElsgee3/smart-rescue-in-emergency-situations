import 'package:agdourapp2/Dialogs.dart';
import 'package:agdourapp2/zoomMap.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:progress_dialog/progress_dialog.dart';
class Search extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _SearchState();
  }}

class _SearchState extends State<Search> {

  final GlobalKey<State> _keyLoader = new GlobalKey<State>();
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
    });
    final uid = user.uid;
  }

  @override
  void initState() {
    super.initState();
    inputData();
  }

  bool value1=true;
  bool value2=false;
  List<String> category=['Traffic accidents','fire','Diseases','Women and childbirth','Injuries','Poisoning','Others'];
  String selectedItem1 ='Traffic accidents';
  String locationDesc ='';
  String injured='';
  String Comment='';

  List<DropdownMenuItem<String>> getMenuItems() {
    List<DropdownMenuItem<String>> menuItems = [];
    for (int i = 0; i < category.length - 1; i++) {
      String type = category[i];
      var newItem = DropdownMenuItem<String>(
        child: Text(type),
        value: type,
      );
      menuItems.add(newItem);
    }
    return menuItems;
  }

  void onChangedValue1(bool value){
    setState((){
      value1 =value;
      value2=!value1;
    });
  }
  void onChangedValue2(bool value) {
    setState(() {
      value2 = value;
      value1=!value2;
    });
  }
  @override
  Widget build(BuildContext context) {
    final currentPosition = Provider.of<Position>(context);

    void sendData(BuildContext context){
      var alertDialog=AlertDialog(
        title:  Icon(
          Icons.check_circle,
          size: 50,
          color: Colors.blue,
        ),
        content: Text( ' Your request has been sent successfully! ',
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

    Future<void> sendRequest() async {
      String username = 'AgdourApp@gmail.com';
      String password = 'app12345';
      final smtpServer = gmail(username, password);
      // Creating the Gmail server
      // Create our email message.
      final message = Message()
        ..from = Address(username)
        ..recipients.add('alisaeed0594@gmail.com') //recipent email
        ..subject = 'AmbulanceRequest :: ${DateTime.now()}' //subject of the email
        ..html = "<head> <style>"
            "table { border-collapse: collapse; width: 100%; }"
            "th, td { text-align: center; padding: 8px;  font-size: 15px;}"
            "tr:nth-child(even){background-color: #f2f2f2}"
      "</style></head>"
       "<body>"
            "<h3 style='display:inline'>Emergency Category : </h3>"
            "<h3 style='display:inline'>$selectedItem1</h3>"
              "<br>"
            "<h3 style='display:inline'>CurrentLocation  :  </h3>"
            "<a style='display:inline' href='https://www.google.com/maps/search/?api=1&query=${currentPosition.latitude},${currentPosition.longitude}'>https://www.google.com/maps/search/?api=1&query=${currentPosition.latitude},${currentPosition.longitude}</a>"
              "<br>"
            "<h3 style='display:inline'>Location Description : </h3>"
            "<h3 style='display:inline'>$locationDesc</h3>"
              "<br>"
            "<h3 style='display:inline'>Number of People injured : </h3>"
            "<h3 style='display:inline'>$injured</h3>"
              "<br>"
            "<h3 style='display:inline'>Comment : </h3>"
            "<h3 style='display:inline'>$Comment</h3>"
              "<br>"
              "<br>"

            "<table>"
      "<tr>"
      "<th style='background-color: #000000; color: white;'  colspan='2'>Personal Information</th>"
      "</tr>"

     " <tr>"
      "<th>Name</th>"
     " <td>${snapshot.data['FullName']}</td>"
     " </tr>"
     " <tr>"
     " <th>Date of Birth</th>"
      "<td>${snapshot.data['Date of Birth']}</td>"
     " </tr>"
      "<tr>"
     " <th>Gender</th>"
      "<td>${snapshot.data['Gender']}</td>"
      "</tr>"
      "<tr>"
      " <th>Email Address</th>"
      "<td>${snapshot.data['EmailAddress']}</td>"
      "</tr>"
      " <tr>"
      "<th>Mobile Number</th>"
      " <td>${snapshot.data['MobileNumber']}</td>"
      " </tr>"
      " <tr>"
      " <th>Emergency Contact</th>"
      "<td>${snapshot.data['EmergencyContact']}</td>"
      " </tr>"
      "<tr>"
      " <th>Address</th>"
      "<td>${snapshot.data['Address']}</td>"
      "</tr>"
      "<tr>"
      " <th>National ID</th>"
      "<td>${snapshot.data['NationalID']}</td>"
      "</tr>"
            "<tr>"
            "<th style='background-color: #000000; color: white;'  colspan='2'>Health Information</th>"
            "</tr>"

            " <tr>"
            "<th>Blood Type</th>"
            " <td>${snapshot.data['bloodType']}</td>"
            " </tr>"
            " <tr>"
            " <th>Diabetes Rate</th>"
            "<td>${snapshot.data['diabetesRate']}</td>"
            " </tr>"
            "<tr>"
            " <th>Blood Pressure</th>"
            "<td>${snapshot.data['bloodPressure']}</td>"
            "</tr>"
            "<tr>"
            " <th>Medications</th>"
            "<td>${snapshot.data['medications']}</td>"
            "</tr>"
            " <tr>"
            "<th>Surgery</th>"
            " <td>${snapshot.data['surgery']}</td>"
            " </tr>"
            " <tr>"
            " <th>Height</th>"
            "<td>${snapshot.data['height']}</td>"
            " </tr>"
            "<tr>"
            " <th>Weight</th>"
            "<td>${snapshot.data['weight']}</td>"
            "</tr>"



      "</table>"
      "</body>"; //body of the email

      try {
        Dialogs.showLoadingDialog(context, _keyLoader);//invoking
        final sendReport = await send(message, smtpServer);
        Navigator.of(_keyLoader.currentContext,rootNavigator: true).pop();//close the dialoge
        sendData(context);
        print('Message sent: ' + sendReport.toString()); //print if the email is sent
      } on MailerException catch (e) {
        print('Message not sent. \n'+ e.toString()); //print if the email is not sent
        // e.toString() will show why the email is not sending
      }
    }

    Future<void> sendOtherRequest() async {
      String username = 'AgdourApp@gmail.com';
      String password = 'app12345';
      final smtpServer = gmail(username, password);
      // Creating the Gmail server
      // Create our email message.
      final message = Message()
        ..from = Address(username)
        ..recipients.add('alisaeed0594@gmail.com') //recipent email
        ..subject = 'AmbulanceRequest :: ${DateTime.now()}' //subject of the email
        ..html =
            "<body>"
            "<h3 style='display:inline'>Emergency Category : </h3>"
            "<h3 style='display:inline'>$selectedItem1</h3>"
            "<br>"
            "<h3 style='display:inline'>CurrentLocation  :  </h3>"
            "<a style='display:inline' href='https://www.google.com/maps/search/?api=1&query=${currentPosition.latitude},${currentPosition.longitude}'>https://www.google.com/maps/search/?api=1&query=${currentPosition.latitude},${currentPosition.longitude}</a>"
            "<br>"
            "<h3 style='display:inline'>Location Description : </h3>"
            "<h3 style='display:inline'>$locationDesc</h3>"
            "<br>"
            "<h3 style='display:inline'>Number of People injured : </h3>"
            "<h3 style='display:inline'>$injured</h3>"
            "<br>"
            "<h3 style='display:inline'>Comment : </h3>"
            "<h3 style='display:inline'>$Comment</h3>"
            "<br>"
             "</body>"; //body of the email

      try {
        Dialogs.showLoadingDialog(context, _keyLoader);//invoking
        final sendReport = await send(message, smtpServer);
        Navigator.of(_keyLoader.currentContext,rootNavigator: true).pop();//close the dialoge
          sendData(context);
          print('Message sent: ' + sendReport.toString()); //print if the email is sent

      } on MailerException catch (e) {
        print('Message not sent. \n'+ e.toString()); //print if the email is not sent
        // e.toString() will show why the email is not sending
      }
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        centerTitle: true,
        title: Text("Ambulance Request",
            style: TextStyle(fontSize: 25, color: Colors.white)),
        iconTheme: new IconThemeData(color: Colors.white),
      ),
      body:Container(

        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/pn.jpg"),
            fit: BoxFit.cover,
          ),
        ),
           child:(currentPosition!=null)? Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                Container(
                  height: MediaQuery.of(context).size.height/3.8,
                  width: MediaQuery.of(context).size.width,
                  child:  GoogleMap(
                    mapType: MapType.hybrid,

                    initialCameraPosition: CameraPosition(
                        target: LatLng(currentPosition.latitude,
                            currentPosition.longitude),
                        zoom: 16.0),
                    zoomGesturesEnabled: true,
                    myLocationEnabled: true,

                  ),),
                Positioned(
                  top: 10,
                  left: 10,
                  child:FloatingActionButton(
                    backgroundColor: Colors.white70,
                    child: Icon(Icons.zoom_out_map,
                      color: Colors.black54,),
                    onPressed: (){
                      Navigator.push(context,
                          MaterialPageRoute(
                              builder: (context) => ZoomMap()
                          ));},
                  ),),],),

            Expanded(
              child: ListView(
                children: <Widget>[

                  Container(
                    padding: EdgeInsets.fromLTRB(
                      MediaQuery.of(context).size.width*0.03,
                      MediaQuery.of(context).size.height*0.01,
                      0,
                      MediaQuery.of(context).size.height*0.01,
                    ),

                    child: Text('Is this request for you ?',
                      style: TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),

                    ),
                  ),


                  Container(
                    margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.04,
                      left:MediaQuery.of(context).size.width*0.06 ,
                    ),
                    decoration: BoxDecoration(color: Colors.white,
                        borderRadius: new BorderRadius.only(
                            topLeft: const Radius.circular(10.0),
                            topRight: const Radius.circular(10.0)),
                        border: Border.all(
                          color: Colors.grey,
                          width: 1,)
                    ),
                    height:MediaQuery.of(context).size.height*0.08,

                    width: MediaQuery.of(context).size.width*0.5,

                    child: new SwitchListTile(
                      value: value1, onChanged: onChangedValue1,
                      activeTrackColor: Colors.lightBlueAccent,
                      activeColor: Colors.blue,
                      title: new Text('Me', style: TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold,

                      ),),
                    ),


                  ),
                  Container(
                    margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.04,
                        left:MediaQuery.of(context).size.width*0.06 ),
                    decoration: BoxDecoration(color: Colors.white,
                        borderRadius: new BorderRadius.only(
                            bottomLeft: const Radius.circular(10.0),
                            bottomRight: const Radius.circular(10.0)),
                        border: Border.all(
                          color: Colors.grey,
                          width: 1,)

                    ),

                    height:MediaQuery.of(context).size.height*0.08,

                    width: MediaQuery.of(context).size.width*0.5,

                    child: new SwitchListTile(
                      value: value2, onChanged: onChangedValue2,
                      activeColor: Colors.blue,
                      activeTrackColor: Colors.lightBlueAccent,

                      title: new Text('Other', style: TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),),


                    ),
                  ),

                  Container(
                    padding: EdgeInsets.fromLTRB( MediaQuery.of(context).size.width*0.03,
                      MediaQuery.of(context).size.height*0.04,
                      0,
                      MediaQuery.of(context).size.height*0.01,),
                    child: Text('Select Emergency Category', style: TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),),
                  ),

                  Padding(padding: EdgeInsets.only(left: 20,right: 15
                  ),
                    child:SizedBox(

                      width:  MediaQuery.of(context).size.width*0.04,
                      child: DropdownButtonFormField<String>(
                        iconEnabledColor: Colors.black,
                        iconSize: 25,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(left:10),
                          border: OutlineInputBorder(


                            borderRadius: BorderRadius.all(
                              Radius.circular(10.0),
                            ),

                            borderSide: BorderSide(color: Colors.black),),
                          filled: true,
                          fillColor: Colors.white,
                        ),
                        value: selectedItem1,
                        onChanged: (value) {
                          print(value);
                          setState(() {
                            selectedItem1 = value;
                          });
                        },
                        items: getMenuItems(),
                      ),
                    ),

                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB( MediaQuery.of(context).size.width*0.03,
                      MediaQuery.of(context).size.height*0.04,
                      0,
                      MediaQuery.of(context).size.height*0.01,),

                    child: Text('Location Description', style: TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),),),


                  Padding(padding: EdgeInsets.only(left: 20,right: 15),
                    child:  SizedBox(
                      width:MediaQuery.of(context).size.width*0.01 ,

                      child: TextField(
                        onChanged: (val){
                          setState(() => locationDesc = val );
                        },
                        // controller: _controllerEmail,
                        decoration: InputDecoration(
                          alignLabelWithHint: true,
                          filled: true,

                          fillColor: Colors.white,

                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide(color: Colors.blue),

                          ),
                          hintText: '  Location Description   ',
                          hintStyle: TextStyle(
                            color: Colors.grey,
                          ),
                        ),


                      ),
                    ),

                  ),
                  Container(

                    padding: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width*0.03,
                      MediaQuery.of(context).size.height*0.02,
                      0,
                      MediaQuery.of(context).size.height*0.01,),
                    child: Row(
                      children: <Widget>[
                        Text('Number of People injured', style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),),

                        SizedBox(
                          width: 40,
                          height: 40,
                        ),


                        SizedBox(
                          width: 60,
                          height: 40,
                          child: TextField(

                            onChanged: (val){
                              setState(() => injured = val );
                            },

                            decoration: InputDecoration(

                              alignLabelWithHint: true,
                              filled: true,
                              fillColor: Colors.white,
                              contentPadding: EdgeInsets.all(10),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                    Radius.circular(10)),
                                borderSide: BorderSide(color: Colors.blue),
                              ),
                              hintText: '    0    ',
                              hintStyle: TextStyle(
                                color: Colors.grey,
                              ),
                            ),),),],),),

                  Container(
                    padding: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width*0.03,
                      MediaQuery.of(context).size.height*0.02,
                      0,
                      MediaQuery.of(context).size.height*0.01,),

                    child: Text('Comment', style: TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),),),


                  Padding(padding: EdgeInsets.only(left: 20,right: 15),
                    child:SizedBox(
                      height: 100,
                      width: 350,
                      child: TextField(

                        onChanged: (val){
                          setState(() => Comment = val );
                        },
                        // controller: _controllerEmail,
                        decoration: InputDecoration(
                          alignLabelWithHint: true,
                          filled: true,

                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide(color: Colors.blue),

                          ),
                          hintText: ' Comment   ',
                          hintStyle: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            RaisedButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              padding: EdgeInsets.fromLTRB(100, 7, 100, 7),
              child: Text('SUBMIT', style: TextStyle(fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),),
              color: Colors.lightBlue,
              onPressed: ()
              {
                if(value1 == true)
                  {
                    sendRequest();
                  }
                else
                  {
                    sendOtherRequest();
                  }
                print( 'https://www.google.com/maps/search/?api=1&query=${currentPosition.latitude},${currentPosition.longitude}');
              },
            ),
          ],
        ) : Center(
          child: CircularProgressIndicator(),
        ),),
    );
  }
}
