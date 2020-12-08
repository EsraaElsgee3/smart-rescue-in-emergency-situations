import 'package:agdourapp2/loginpage.dart';
import 'package:agdourapp2/terms.dart';
import'package:flutter/material.dart';
import'package:humanitarian_icons/humanitarian_icons.dart';
class Start extends StatefulWidget {
@override
_StartState createState() => _StartState();
}
class _StartState extends State<Start> {
@override
Widget build(BuildContext context) {
return Container(
decoration: BoxDecoration(
image: DecorationImage(
image: AssetImage('assets/oo.jpg'),
fit: BoxFit.cover,
),),
child: Scaffold(
backgroundColor: Colors.transparent,
body: Center(
child: Column(
children: <Widget>[
Container(
height: MediaQuery.of(context).size.height * 0.6,
width: double.infinity,
alignment: Alignment.center,
decoration: BoxDecoration(
borderRadius: BorderRadius.only(
bottomLeft: Radius.circular(120),
bottomRight: Radius.circular(120),
),
image: DecorationImage(
image: AssetImage('assets/pn.jpg'),
fit: BoxFit.cover,
),
),
child: FittedBox(
child: Align(
alignment: Alignment.center,
child: Stack(
alignment: Alignment.center,
children: <Widget>[
Padding(
padding: const EdgeInsets.only(
top:50,
),
child: Icon(
Icons.location_on,
size: 200,
  color: Colors.blue[500],
),
),
Icon(
HumanitarianIcons.ambulance,
size: 30,
color: Colors.red,
),],),),),),
SizedBox(
height: 20.0,
),
Text(
'Welcome to Agdour',
style: TextStyle(
color: Colors.blue[900],
fontWeight: FontWeight.w900,
fontSize: 30),
),
SizedBox(
height: 30,
),
Container(
height: 60,
width: double.infinity,
margin: EdgeInsets.only(left: 20.0, right: 20.0),
decoration: BoxDecoration(
borderRadius: BorderRadius.all(
Radius.circular(30.0),
),
border: Border.all(color: Colors.blue[900], width: 3.0),
),
child: FlatButton(
textColor: Colors.white,
child: Text(
'Sign Up',
style: TextStyle(
fontSize: 40,
color: Colors.blue[900],
fontWeight: FontWeight.w700),
),
onPressed: () {Navigator.push(context,
      MaterialPageRoute(
          builder: (context) => TermsScreen()));},),),
SizedBox(
height: 10,),
Container(
height: 60,
width: double.infinity,
margin: EdgeInsets.only(left: 20.0, right: 20.0),
decoration: BoxDecoration(
borderRadius: BorderRadius.all(
Radius.circular(30.0),),
border: Border.all(color: Colors.blue[900], width: 3.0),),
child: FlatButton(
textColor: Colors.white,
child: Text(
'Sign In',
style: TextStyle(
fontSize: 40,
color: Colors.blue[900],
fontWeight: FontWeight.w700),),
onPressed: () {
  Navigator.push(context,
      MaterialPageRoute(
          builder: (context) =>LoginPage()
  ));},),),],),),),);}}