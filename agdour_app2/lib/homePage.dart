import 'dart:ui';
import 'package:agdourapp2/search.dart';
import 'package:android_intent/android_intent.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'emergencynumbers.dart';

class HomePage extends StatefulWidget {
  @override

  _HomePageState createState()=>_HomePageState();

}
class _HomePageState extends State<HomePage>{

  Future _checkGps() async {
    if (!(await Geolocator().isLocationServiceEnabled())) {
      if (Theme.of(context).platform == TargetPlatform.android) {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("Can't get current location"),
                content:const Text('Please make sure you enable GPS and try again'),
                actions: <Widget>[
                  FlatButton(child: Text('Ok'),
                      onPressed: () {
                        final AndroidIntent intent = AndroidIntent(
                            action: 'android.settings.LOCATION_SOURCE_SETTINGS');
                        intent.launch();
                        Navigator.of(context, rootNavigator: true).pop();
                      })],
              );
            });
      }
    }
  }


  @override
  void initState(){
    super.initState();

  }


  @override
  Widget build(BuildContext context) {
    final currentPosition = Provider.of<Position>(context);


    return Scaffold(

      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/pn.jpg"),
            fit: BoxFit.cover,
          ),
        ),

        child: new Column(

          children: <Widget>[
            new GestureDetector(
              onTap: () async {
                if (!(await Geolocator().isLocationServiceEnabled())) {
                  _checkGps();
                  return{  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Search() ,
                      ))
                  };
                }
                else{
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Search() ,
                      ));
                };
              },
              child: Container(

                child: Row(
                  children: <Widget>[
                    Padding(padding:EdgeInsets.only(left: 4) ,
                      child: Image(
                        image: AssetImage('assets/eme.jpg'),
                        width: 120,
                        height: 120,

                      ),
                    ),

                    Column(
                      children: <Widget>[
                        Padding(padding:EdgeInsets.only(top: 40,bottom: 20),
                          child: Text( 'Ambulance Request',
                            style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold

                            ),
                          )
                          ,),
                        Text( 'you can send a request to\nthe nearest ambulance\nunit for youself or others  ',
                          style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold
                          ),
                        ),

                      ],
                    ),

                  ],

                ),
                margin: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width*0.1,
                    MediaQuery.of(context).size.height*0.07,
                    MediaQuery.of(context).size.width*0.1,
                    0),

                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    border: Border.all(
                      color: Colors.lightBlue,
                      width: 3,)
                ),
                width: 700,
                height: 190,


              ),
            ),
            Row(
              children: <Widget>[
                new GestureDetector(
                  onTap: () async {
                    if (!(await Geolocator().isLocationServiceEnabled())) {
                      _checkGps();
                      return null;
                    }
                    else{
                      _launchMapsUrl1(currentPosition.latitude,
                        currentPosition.longitude,);}
                  },

                  child:new Container(
                    margin: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width*0.09,
                        MediaQuery.of(context).size.width*0.01,
                        0,
                        MediaQuery.of(context).size.width*0.01),

                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(
                          color: Colors.lightBlue,
                          width: 3,)
                    ),
                    child: Column(
                        children: <Widget>[
                          Padding(padding: EdgeInsets.only(top: 3),

                            child: Image(
                              image: AssetImage('assets/23.jpg'),
                              width: 50,
                              height: 50,

                            ),
                          ),

                          Padding(
                              padding: EdgeInsets.only(top: 20),
                              child: Text('Nearest Hospital',
                                  style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold
                                  )
                              )
                          ),

                        ]

                    ),


                    width: 145,
                    height: 130,


                  ),

                ),

                new GestureDetector(
                  onTap: () async {
                    if (!(await Geolocator().isLocationServiceEnabled())) {
                      _checkGps();
                      return null;
                    }
                    else{
                      _launchMapsUrl2(currentPosition.latitude,
                        currentPosition.longitude,);}
                  },

                  child:new Container(
                    margin: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width*0.02,
                        MediaQuery.of(context).size.width*0.01,
                        MediaQuery.of(context).size.width*0.01,
                        MediaQuery.of(context).size.width*0.01),

                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(
                          color: Colors.lightBlue,
                          width: 3,)
                    ),
                    child: Column(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(top: 2),
                            child: Image(
                              image: AssetImage('assets/ee.jpg'),
                              width: 50,
                              height: 50,


                            ),
                          ),

                          Padding(
                              padding: EdgeInsets.only(top: 20),
                              child: Text('Nearest pharmacy',
                                  style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold
                                  )
                              )
                          ),
                        ]

                    ),




                    width: 145,
                    height: 130,


                  ),

                ),

              ],

            ),

            new GestureDetector(
              onTap: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EmergencyNumbers() ,
                    ));

              },

              child:Container(

                margin: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width*0.1,
                    0,
                    MediaQuery.of(context).size.width*0.1,
                    0),

                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    border: Border.all(
                      color: Colors.lightBlue,
                      width: 3,)
                ),

                width: 700,
                height: 100,

                child: Row(
                  children: <Widget>[
                    Padding(padding:EdgeInsets.only(left: 9) ,
                      child: Image(
                        image: AssetImage('assets/ccal.png'),
                        width: 100,
                        height: 70,

                      ),
                    ),
                    Text('Emergency Numbers',style: TextStyle(fontWeight: FontWeight.bold,fontSize:17 ),),

                  ],
                ),
              ),
            ),






          ],

        ),
      ),


    );
  }


  void _launchMapsUrl2(double lat, double lng) async {
    final url ='https://www.google.com/maps/search/pharmacy/@lat,lng,11z/data=!3m1!4b1';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
  void _launchMapsUrl1(double lat, double lng) async {
    final url ='https://www.google.com/maps/search/hospitals/@lat,lng,11z/data=!3m1!4b1';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }


}