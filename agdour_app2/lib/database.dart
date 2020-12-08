import 'package:agdourapp2/personal.dart';
import 'package:agdourapp2/personaltable.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:agdourapp2/personaltable.dart';
import 'package:agdourapp2/myprofile.dart';
import 'package:agdourapp2/user.dart';
class DatabaseService {
  final String uid;
  DatabaseService({ this.uid });
  // collection reference
  final CollectionReference personal = Firestore.instance.collection('personal');
  Future<void> updateUserData(
  String FullName , String DateofBirth, String Gender, String MobileNumber, String EmergencyContact,
  String Address, String NationalID, String EmailAddress, String Password, String myImg,
  String bloodType , String diabetesRate, String bloodPressure, String medications, String surgery,
  String height,
  String weight,) async {
    return await personal.document(uid).setData({
      'FullName': FullName,
      'Date of Birth': DateofBirth,
      'Gender': Gender,
      'MobileNumber':MobileNumber,
      'EmergencyContact':EmergencyContact,
      'Address':Address,
      'NationalID':NationalID,
      'EmailAddress':EmailAddress,
      'Password':Password,
      'myImg':myImg,
      'bloodType': bloodType ,
      'diabetesRate': diabetesRate ,
      'bloodPressure': bloodPressure ,
      'medications': medications ,
      'surgery': surgery ,
      'height': height ,
      'weight': weight

    });
  }
  /*//newwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww
  List<PersonalTable> _PersonalFormList(QuerySnapshot snapshot)
  {
    return snapshot.documents.map((doc){
      return PersonalTable(
          FullName: doc.data['FullName'] ?? '',
          DateofBirth: doc.data['DateofBirth'] ?? '',
          Gender: doc.data['Gender'] ?? '',
          MobileNumber: doc.data['MobileNumber'] ?? '0',
          EmergencyContact: doc.data['EmergencyContact'] ?? '0',
          Address:doc.data['Address'] ?? '',
          NationalID:doc.data['NationalID'] ?? '0',
          EmailAddress:doc.data['EmailAddress'] ?? '',
          Password:doc.data['Password'] ?? ''
      );
  }).toList();
  }
*/
  /*// get brews stream
  //personal is the query snapshot of the firestore
  Stream<List<PersonalTable>> get personal {
    //personalcollection is the collection reference
    return personalcollection.snapshots()
        .map(_PersonalFormList);
  }*/

  //user data from snapshot
  /*UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
      uid: uid,
      FullName: snapshot.data['FullName'],
      DateofBirth: snapshot.data['DateofBirth'],
      Gender: snapshot.data['Gender'],
      MobileNumber: snapshot.data['MobileNumber'],
      EmergencyContact: snapshot.data['EmergencyContact'],
      Address: snapshot.data['Address'],
      NationalID: snapshot.data['NationalID'],
      EmailAddress: snapshot.data['EmailAddress'],
      Password: snapshot.data['Password']

    );
  }


  // get user doc stream
  Stream<UserData> get userData {
    return personalcollection.document(uid).snapshots()
        .map(_userDataFromSnapshot);
  }*/
}
