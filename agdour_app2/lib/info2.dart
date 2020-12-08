/*
import 'package:firebase_database/firebase_database.dart';
class PersonHealth {
  String _id;
  String _bloodtype;
  String _diabetesrate;
  String _bloodpressure;
  String _medications;
  String _surgery;
  String _height;
  String _weight;
  PersonHealth(this._id,this._bloodtype,this._diabetesrate,
      this._bloodpressure,this._medications,this._surgery,
      this._height,this._weight);

  PersonHealth.map(dynamic obj2)
  {
    this._bloodtype=obj2['bloodtype'];
    this._diabetesrate=obj2['diabetesrate'];
    this._bloodpressure=obj2['bloodpressure'];
    this._medications=obj2['medications'];
    this._surgery=obj2['surgery'];
    this._height=obj2['height'];
    this._weight=obj2['weight'];
  }

  String get id => _id;
  String get bloodtype => _bloodtype;
  String get diabetesrate => _diabetesrate;
  String get bloodpressure => _bloodpressure;
  String get medications => _medications ;
  String get surgery => _surgery ;
  String get height => _height;
  String get weight => _weight;

  PersonHealth.fromSnapShot(DataSnapshot snapshot2){
    _id = snapshot2.key;
    _bloodtype = snapshot2.value['bloodtype'];
    _diabetesrate = snapshot2.value['diabetesrate'];
    _bloodpressure = snapshot2.value['bloodpressure'];
    _medications = snapshot2.value['medications'];
    _surgery = snapshot2.value['surgery'];
    _height = snapshot2.value['height'];
    _weight = snapshot2.value['weight'];
  }
}*/
