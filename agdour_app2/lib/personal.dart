import 'dart:io';
import 'package:agdourapp2/healthinfo.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:async';
import 'package:agdourapp2/DB.dart';
import 'package:path/path.dart';

void main() {
  runApp(MaterialApp(
    routes: <String,WidgetBuilder>{
      '/heathinfo' : (BuildContext  context) => Healthinfo('','','','',
          '','','','','','')
    },
  ));
}

//final  info1Reference=FirebaseDatabase.instance.reference().child('info1');

class Personal extends StatefulWidget {
  @override
  _State createState() => _State();
}
class _State extends State<Personal> {
  final AuthService _auth = AuthService();
  final _FormKey =GlobalKey<FormState>();
  //text field state
  String FullName = '';
  String DateofBirth='';
  String Gender='';
  String MobileNumber;
  String EmergencyContact;
  String Address='';
  String NationalID;
  String EmailAddress='';
  String Password='';
 // String myImg='';
  String error = '';

  File _image;
  String _uploadedFileURL ='';
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  int selectedDateofBirth;
  //for storing user's database inside list
 // List<Person> items;
  //for realtime changes , automatic firebase and list update
  //StreamSubscription<Event> _OnAddedSubscription;
  //StreamSubscription<Event> _OnChangedSubscription;
  // for automatic steady of DB from firebase


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

    Future uploadPic(BuildContext context) async{
      String fileName = basename(_image.path);
      StorageReference firebaseStorageRef = FirebaseStorage.instance.ref().child(fileName);
      StorageUploadTask uploadTask = firebaseStorageRef.putFile(_image);
      StorageTaskSnapshot taskSnapshot=await uploadTask.onComplete;

      var dowurl = await (await uploadTask.onComplete).ref.getDownloadURL();
      String url = dowurl.toString();

      setState(() {
        print("Profile Picture uploaded");
        _uploadedFileURL = url;
        print("url::");
        print(_uploadedFileURL);
       // Scaffold.of(context).showSnackBar(SnackBar(content: Text('Profile Picture Uploaded')));

      });
    }
    print(_uploadedFileURL);


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
                  child:Form(
                      key:_FormKey,
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
                            'personal info',
                            style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.w500,
                                fontSize: 20),
                          )),
                      SizedBox(
                        height: 20.0,
                      ),
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
                            ),),],),
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
                        height: 5,
                      ),
                      SizedBox(
                          width: 250.0,
                          height: 70,
                          child: TextFormField(

                            validator: (val) =>val.isEmpty ? 'Enter Your FullName': null,

                            onChanged: (val){
                              setState(() => FullName = val );
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
                              hintText: ' Enter Your FullName',
                              hintStyle: TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                            //onChanged: (val){}
                          )
                      ),

                      SizedBox(
                        height: 20,
                      ),
                      Container(padding: EdgeInsets.all(15),
                          child: Row(children: <Widget>[
                            Icon(
                              Icons.date_range,
                              size: 25,
                              color: Colors.black,
                            ),
                            Text(
                              'Date of Birth',
                              style: TextStyle(fontSize: 22),
                            ),
                          ])),
                      SizedBox(
                          width: 250.0,
                          height: 70,
                          child: TextFormField(
                            validator: (val) =>val.isEmpty ? 'Enter Your Date of Birth': null,
                            onChanged: (val){
                              setState(() => DateofBirth = val );
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

                      SizedBox(
                        height: 20,
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
                              onChanged: (int value) {setState(() {getDateofBirth(value);

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
                                setState(() {getDateofBirth(value);
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

                      SizedBox(
                        height: 20,
                      ),
                      Container(padding: EdgeInsets.all(15),
                          child: Row(children: <Widget>[
                            Icon(
                              Icons.phone,
                              size: 25,
                              color: Colors.black,
                            ),
                            Text(
                              'Mobile Number',
                              style: TextStyle(fontSize: 22),
                            ),
                          ])),
                      SizedBox(
                          width: 250.0,
                          height: 70,
                          child: TextFormField(

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
                            //keyboardType: TextInputType.number,
                            validator: (val) =>val.isEmpty ? 'Enter your Mobile Number': null,
                            onChanged: (val){
                              setState(() => MobileNumber = val);
                            },
                          )
                      ),

                      SizedBox(
                        height: 20,
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
                          height: 70,
                          child: TextFormField(
                            validator: (val) =>val.isEmpty ? 'Enter an Emergency Contact ': null,
                            onChanged: (val){
                              setState(() => EmergencyContact = val );
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
                      SizedBox(
                        height: 20,
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
                          height: 70,
                          child: TextFormField(
                            validator: (val) =>val.isEmpty ? 'Enter your Address': null,
                            onChanged: (val){
                              setState(() => Address = val );
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
                      SizedBox(
                        height: 20,
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
                          height: 70,
                          child: TextFormField(
                            validator: (val) =>val.isEmpty ? 'Enter Your ID ': null,
                            onChanged: (val){
                              setState(() => NationalID = val );
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
                            ),)),
                      SizedBox(
                        height: 20,
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
                          height: 70,
                          child: TextFormField(
                            validator: (val) =>val.isEmpty ? 'Enter your E-mail Address': null,
                            onChanged: (val){
                              setState(() => EmailAddress = val );
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
                      SizedBox(
                        height: 20,
                      ),

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
                          height: 70,
                          child: TextFormField(
                            validator: (val) => val.length < 6 ? 'Enter a password 6+ chars long' : null,                            onChanged: (val){
                              setState(() => Password = val );
                            },
                            obscureText: true,
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
                            ),)),
                      SizedBox(
                        height: 20,
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
                            onPressed: () async{
                              if(_FormKey.currentState.validate()) {

                                await uploadPic(context);
                                    print("url::");
                                    print(_uploadedFileURL);
                                    Navigator.push((context), MaterialPageRoute(
                                        builder: (context) => Healthinfo(FullName
                                            ,DateofBirth,Gender,MobileNumber,EmergencyContact,
                                            Address,NationalID,EmailAddress,Password,_uploadedFileURL)

                                    ));
                              }

                            }
                          ),


                      ),
                      SizedBox(height: 12.0),
                      Text(
                        error,
                        style: TextStyle(color: Colors.red, fontSize: 14.0),
                      )

                    ])),
              ))),
    ));
  }
  /*void _OnPersonAdded(Event event){
    setState(() {
      items.add(new Person.fromSnapShot(event.snapshot));
    });

  }
  void _OnPersonChanged(){

  }
  void _CreateNewUser(BuildContext context)async{
    await Navigator.push(context,MaterialPageRoute(builder: (context) => personScreen(Person( null ,'','','','','','','','',''))),
    );
  }

   */
}