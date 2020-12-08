/*
import 'package:firebase_database/firebase_database.dart';
 class Person {
  String _id;
  String _fullname;
  String _dateofbirth;
  String _gender;
  String _mobilenumber;
  String _emergencycontact;
  String _address;
  String _nationalid;
  String _emailaddress;
  String _password;
  Person(this._id,this._fullname,this._dateofbirth,
      this._gender,this._mobilenumber,this._emergencycontact,
      this._address,this._nationalid,this._emailaddress,
      this._password);
  Person.map(dynamic obj)
  {
    this._fullname=obj['fullname'];
    this._dateofbirth=obj['dateofbirth'];
    this._gender=obj['gender'];
    this._mobilenumber=obj['mobilenumber'];
    this._emergencycontact=obj['emergencycontact'];
    this._address=obj['address'];
    this._nationalid=obj['nationalid'];
    this._emailaddress=obj['emailaddress'];
    this._password=obj['password'];
  }

  String get id => _id;
  String get fullname => _fullname;
  String get dateofbirth => _dateofbirth;
  String get gender => _gender;
  String get mobilenumber => _mobilenumber ;
  String get emergencycontact => _emergencycontact ;
  String get address => _address;
  String get nationalid => _nationalid;
  String get emailaddress => _emailaddress ;
  String get password => _password ;

  Person.fromSnapShot(DataSnapshot snapshot){
    _id = snapshot.key;
    _fullname = snapshot.value['fullname'];
    _dateofbirth = snapshot.value['dateofbirth'];
    _gender = snapshot.value['gender'];
    _mobilenumber = snapshot.value['mobilenumber'];
    _emergencycontact = snapshot.value['emergencycontact'];
    _address = snapshot.value['address'];
    _nationalid = snapshot.value['nationalid'];
    _emailaddress = snapshot.value['emailaddress'];
    _password = snapshot.value['password'];
  }
}*/
