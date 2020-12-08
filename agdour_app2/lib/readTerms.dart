import 'package:agdourapp2/personal.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class readTerms extends StatefulWidget {
  @override
  readTermsState createState() => readTermsState();
}

class readTermsState extends State<readTerms> {
  bool _readConditions = false;
  bool _seeMore = false;
  String _conditions =
      'Thank you for  using the AGDOUR Service. \n You must read and accept the following terms and conditions that apply to the Service By accessing, using or downloading the Service. AGDOUR works through a mobile application that may be downloaded from third party services such as Apple or Google, through their online "stores" \n This User Agreement is between AGDOUR and the User, Contains: \n *Profile information on the Mobile application is accurate and up dated. \n *Emergency health record and insurance information are always kept up to date. \n *Phone numbers and other contact details are up to date.  *Latest patches (updates) are downloaded to ensure the latest functionality is available to you. \n *The data on the Mobile Application is collected by us from healthcare professionals and organizations and it is used to create a database of information that is accessible to the Users in case of a medical emergency. \n *The first respondent must be non-medical, not a voluntary person who has received the basic level of first aid training and perhaps the one who must first reach the emergency site. The person registered as the first respondent will be able to access the emergency GPS address. \n *Your emergency contact is a person who is willing to assist you in case of an emergency and will have access to your address, age, gender, profile picture, insurance details, the contact information of your emergency contacts and your emergency health record. The emergency contact should be someone from your close family or friends circle. \n *Each user hereby agrees that through entering, registering, or using the mobile app or any other information contained therein, he enters into a legally binding agreement based on terms and conditions, as it is updated from time to time, which is incorporated under this document as a reference \n *If you are found to be in violation of the User Agreement or if the information you have provided is inaccurate or counterfeit to any identity from your location, AGDOUR reserves the right to suspend your account and initiate legal proceedings against you.';

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
    new Container(
    height: double.infinity,
      width: double.infinity,
      decoration: new BoxDecoration(
        image: new DecorationImage(
          image: new AssetImage("assets/oo.jpg"),
          fit: BoxFit.cover,
        ),
      ),
    ),
    Scaffold(
    backgroundColor: Colors.transparent,
    appBar: new AppBar(
    centerTitle: true,
    title: new Text( "Terms and Conditions",
    style: TextStyle(
    color: Colors.black,
    ),
    ),
    backgroundColor: Colors.transparent,
    elevation: 1,
    ),
    body: Padding(
    padding: EdgeInsets.only(left: 10, right: 30),
    child: SingleChildScrollView(
    child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
    Center(
    child: Container(

    height: MediaQuery.of(context).size.height * .45,
    child: Container(
    width:210,
    height: 60,
    decoration: BoxDecoration(
    image: DecorationImage(
    image: AssetImage('assets/ww.png',),),),
    ),
    ),
    ),
    Container(
    constraints: BoxConstraints(
    minHeight: 280.0,
    ),
    child: Column(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
    Text('Terms and Conditions',
    style: TextStyle(
    fontSize: 21,
    fontWeight: FontWeight.w700,
    letterSpacing: 1),
    ),
    Text('$_conditions',
    maxLines: !_seeMore ? 3 : null,
    overflow: !_seeMore ? TextOverflow.ellipsis : null,
    ),
    InkWell(
    onTap: () {
    setState(() {
    _seeMore = !_seeMore;
    });
    },
    child: Text(
    _seeMore ? 'see less' : 'see more',
    style: TextStyle(color: Colors.red,fontSize:13 ,),
    ),
    ),
    ],
    ),
    )
    ],
    ),
    ),
    ),
    ),
      ],
    );
  }
}
