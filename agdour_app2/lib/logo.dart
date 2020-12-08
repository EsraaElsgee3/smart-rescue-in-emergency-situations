import 'package:agdourapp2/mainPage.dart';
import 'package:agdourapp2/start.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LogoPage extends StatefulWidget {
  @override
  _LogoPageState createState() => _LogoPageState();
}

class _LogoPageState extends State<LogoPage> {

  @override
  void initState(){
    super.initState();

    _mockCheckForSession().then(
            (status) {
          if (status) {
            _navigateToStart();
          } else {
            _navigateToHome();
          }
        }
    );
  }


  Future<bool> _mockCheckForSession() async {
    await Future.delayed(Duration(milliseconds: 1600), () {});

    return true;
  }

  void _navigateToStart(){
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(
            builder: (BuildContext context) => Start()
        )
    );
  }

  void _navigateToHome(){
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(
            builder: (BuildContext context) => MainPage('','')
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          height: double.infinity,
          width: double.infinity,
          decoration: new BoxDecoration(
            image: new DecorationImage(
              image: new AssetImage("assets/logo.jpg"),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ],
    );
  }
}