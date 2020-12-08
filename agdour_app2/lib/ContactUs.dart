import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ContactUs extends StatefulWidget {
  @override
  _ContactUsState createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  File imageFile;
  File imageFile1;
  File imageFile2;

  _openGallary(BuildContext context)async{
    var picture=await ImagePicker.pickImage(source: ImageSource.gallery);
    this.setState((){
      imageFile=picture;
    });
    Navigator.of(context).pop();
  }

  _openGallary1(BuildContext context)async{

    var picture1=await ImagePicker.pickImage(source: ImageSource.gallery);
    this.setState((){
      imageFile1=picture1;
    });
    Navigator.of(context).pop();
  }

  _openGallary2(BuildContext context)async{

    var picture2=await ImagePicker.pickImage(source: ImageSource.gallery);
    this.setState((){
      imageFile2=picture2;
    });
    Navigator.of(context).pop();
  }
  _openCamera(BuildContext context)async{
    var picture=await ImagePicker.pickImage(source: ImageSource.camera);
    this.setState((){
      imageFile=picture;
    });
    Navigator.of(context).pop();
  }
  _openCamera1(BuildContext context)async{
    var picture1=await ImagePicker.pickImage(source: ImageSource.camera);
    this.setState((){
      imageFile1=picture1;
    });
    Navigator.of(context).pop();
  }
  _openCamera2(BuildContext context)async{
    var picture2=await ImagePicker.pickImage(source: ImageSource.camera);
    this.setState((){
      imageFile2=picture2;
    });
    Navigator.of(context).pop();
  }
  Future<void>_showChoiceDialog(BuildContext context){
    return showDialog(context: context,builder: (BuildContext context){
      return AlertDialog(
        title: Text("Make a Choice!"),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              GestureDetector(
                child: Text("Gallary"),
                onTap: (){
                  _openGallary(context);
                },
              ),
              Padding(padding:EdgeInsets.all(8.0)),
              GestureDetector(
                child: Text("Camera"),
                onTap: (){
                  _openCamera(context);
                },
              ),
            ],
          ),
        ),
      );
    });
  }

  Future<void>_showChoiceDialog1(BuildContext context){
    return showDialog(context: context,builder: (BuildContext context){
      return AlertDialog(
        title: Text("Make a Choice!"),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              GestureDetector(
                child: Text("Gallary"),
                onTap: (){
                  _openGallary1(context);
                },
              ),
              Padding(padding:EdgeInsets.all(8.0)),
              GestureDetector(
                child: Text("Camera"),
                onTap: (){
                  _openCamera1(context);
                },
              ),
            ],
          ),
        ),
      );
    });
  }

  Future<void>_showChoiceDialog2(BuildContext context){
    return showDialog(context: context,builder: (BuildContext context){
      return AlertDialog(
        title: Text("Make a Choice!"),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              GestureDetector(
                child: Text("Gallary"),
                onTap: (){
                  _openGallary2(context);
                },
              ),
              Padding(padding:EdgeInsets.all(8.0)),
              GestureDetector(
                child: Text("Camera"),
                onTap: (){
                  _openCamera2(context);
                },
              ),
            ],
          ),
        ),
      );
    });
  }


  Widget _decideImageView(){
    if(imageFile == null){
      return FlatButton(onPressed: (){},
        child: SizedBox.fromSize(
          size: Size(40, 40), // button width and height
          child: ClipOval(
            child: Material(
              color: Colors.black12, // button color
              child: InkWell(
                splashColor: Colors.lightBlue, // splash color
                onTap: () {
                  _showChoiceDialog(context);
                }, // button pressed
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.add,color: Colors.blue,
                    ),
                  ],
                ),
              ),
            ),
          ),
        )
        ,
      );
    }
    else{
      return Image.file(imageFile,width: 100,height: 100,fit: BoxFit.fill,);


    }
  }

  Widget _decideImageView1(){
    if(imageFile1 == null){
      return FlatButton(onPressed: (){},
          child: SizedBox.fromSize(
            size: Size(40, 40), // button width and height
            child: ClipOval(
              child: Material(
                color: Colors.black12, // button color
                child: InkWell(
                  splashColor: Colors.lightBlue, // splash color
                  onTap: () {
                    _showChoiceDialog1(context);
                  }, // button pressed
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(Icons.add,color: Colors.blue,), // icon
                    ],
                  ),
                ),
              ),
            ),
          )

      );
    }
    else{
      return Image.file(imageFile1,width: 100,height: 100,fit: BoxFit.fill);
    }
  }

  Widget _decideImageView2(){
    if(imageFile2 == null){
      return FlatButton(onPressed: (){},
          child: SizedBox.fromSize(
            size: Size(40, 40), // button width and height
            child: ClipOval(
              child: Material(
                color: Colors.black12, // button color
                child: InkWell(
                  splashColor: Colors.lightBlue, // splash color
                  onTap: () {
                    _showChoiceDialog2(context);
                  }, // button pressed
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(Icons.add,color: Colors.blueAccent,), // icon
                    ],
                  ),
                ),
              ),
            ),
          )

      );
    }
    else{
      return Image.file(imageFile2,width: 100,height: 100,fit: BoxFit.fill);
    }
  }

  TextEditingController _textFieldController = TextEditingController();

  _onClear() {
    setState(() {
      _textFieldController.text = "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: new AppBar(
        backgroundColor: Colors.lightBlue,
        title: Text('Contact Us',style: TextStyle(color: Colors.white,fontSize: 30),),
        iconTheme: new IconThemeData(color: Colors.white),
      ),
      body: Container(
        decoration: new BoxDecoration(
          image: new DecorationImage(image: new AssetImage('assets/pn.jpg'),
              fit: BoxFit.fill
          ),
        ),
        child:Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: double.infinity,
              height: 100,
              padding: EdgeInsets.only(top: 4),
              margin: EdgeInsets.all(6),
              child: TextField(
                controller: _textFieldController,
                style: TextStyle()
                ,decoration: InputDecoration(
                suffix: IconButton(
                  icon: Icon(Icons.cancel,color: Colors.lightBlue,),
                  onPressed: _onClear,
                ),
                hintStyle: TextStyle(color: Colors.black45,fontSize: 25),
                hintText: "Describe your problem",
                contentPadding: new EdgeInsets.symmetric(vertical: 60.0, horizontal: 10.0),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0),
                ),
              ),
              ),
            ),

            Text("Add screenshorts (optional)",style: TextStyle(color: Colors.black,fontSize: 17,)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  width: 100,
                  height: 100,
                  color: Colors.black12,
                  //padding: EdgeInsets.all(18),
                  margin: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      _decideImageView(),
                    ],
                  ),
                ),
                Container(
                  width: 100,
                  height: 100,
                  color: Colors.black12,
                  //padding: EdgeInsets.only(top: 15),
                  margin: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      _decideImageView1(),
                    ],
                  ),
                ),
                Container(
                  width: 100,
                  height: 100,
                  color: Colors.black12,
                  //padding: EdgeInsets.only(top: 15),
                  margin: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      _decideImageView2(),
                    ],
                  ),
                ),
              ],
            ),
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
                    'Next',
                    style: TextStyle(fontSize: 23, color: Colors.white),
                  ),
                  onPressed: (){
                    sendData(context);
                  },
                ))
          ],
        ),

      ),
    );
  }
  void sendData(BuildContext context){
    var alertDialog=AlertDialog(
      title: Text("Data has been sent successfully!"),
      content: Text("We 'll try to solve the problem soon",style: TextStyle(fontSize: 13),),
    );
    showDialog(
        context: context,
        builder: (BuildContext context){
          return alertDialog;
        }
    );
  }
}
