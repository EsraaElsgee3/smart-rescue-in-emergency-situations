import 'package:agdourapp2/homePage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:agdourapp2/health.dart';
import 'package:agdourapp2/myprofile.dart';


class MainPage extends StatefulWidget{

  final String EmailAddress;
  final String FullName;

  const MainPage(this.FullName,this.EmailAddress, {Key key}): super(key: key);

  @override

  State<StatefulWidget> createState() {

    return _MainState();
  }
}
class _MainState extends State<MainPage>{
  var _currentIndex=0;
  final _pageOptions=[
    HomePage(),
    MyProfile(),
    Health(),

  ];

  String _title;

//for storing user's database inside list
  //List<Person> items;
  @override
  initState()  {
    _title = 'Home';
  }


  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue,
        centerTitle: true,
        title: Text(_title,style: TextStyle(fontSize: 30,color: Colors.white)),

        iconTheme: new IconThemeData(color: Colors.white),

      ),

      body:
      _pageOptions[_currentIndex],


      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,

          onTap: onTabTapped,

          //type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.lightBlue,
          iconSize: 25,
          selectedFontSize: 20,
          unselectedFontSize: 15,


          items:[
            BottomNavigationBarItem(icon: Icon(Icons.home),title: Text("Home")),
            BottomNavigationBarItem(icon: Icon(Icons.person_pin),title: Text("EditProfile")),
            BottomNavigationBarItem(icon: Icon(Icons.local_hospital),title: Text("Health Info")),

          ]
      ),

      drawer:new Drawer(
          child: ListView(

              children: <Widget>[
                new UserAccountsDrawerHeader(
                  accountName: Text(widget.FullName,style: TextStyle(color: Colors.blue,fontSize: 18),)
                  , accountEmail: Text(widget.EmailAddress,style: TextStyle(color: Colors.blue,fontSize: 18),),
                  currentAccountPicture: GestureDetector(
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      child: Icon(Icons.person,color: Colors.lightBlue,size: 50,),
                    ),
                  ),
                  decoration: new BoxDecoration(
                    //color: Colors.cyan
                      image: new DecorationImage(image: new AssetImage('assets/pn.jpg'),
                          fit: BoxFit.fill
                      )
                  ),
                ),

                InkWell(
                    onTap: (){
                      Navigator.of(context).pushNamed("/Profile");
                    },
                    child:ListTile(
                      title: Text('Profile',style: TextStyle(fontSize: 18)),
                      leading: Icon(Icons.person_pin,color: Colors.lightBlue,size: 35,),
                    )
                ),
                InkWell(
                    onTap: (){
                      Navigator.of(context).pushNamed("readTerms");
                    },
                    child:ListTile(
                      title: Text('Terms and conditions',style: TextStyle(fontSize: 18)),
                      leading: Icon(Icons.assignment,color: Colors.lightBlue,size: 30,),
                    )
                ),
                InkWell(
                    onTap: (){
                      Navigator.of(context).pushNamed("/ShareApp");
                    },
                    child:ListTile(
                      title: Text('Share App',style: TextStyle(fontSize: 18)),
                      leading: Icon(Icons.share,color: Colors.lightBlue,size: 30,),
                    )
                ),

                InkWell(
                    onTap: (){
                      Navigator.of(context).pushNamed("/RateMyAppTestApp");
                    },
                    child:ListTile(
                      title: Text('Rate App',style: TextStyle(fontSize: 18)),
                      leading: Icon(Icons.star_half,color: Colors.lightBlue,size: 35,),
                    )
                ),

                InkWell(
                    onTap: (){
                      Navigator.of(context).pushNamed("/ContactUs");
                    },
                    child:ListTile(
                      title: Text('Contact Us',style: TextStyle(fontSize: 18)),
                      leading: Icon(Icons.contact_phone,color: Colors.lightBlue,size: 30,),
                    )
                ),
                InkWell(
                    onTap: (){
                      Navigator.of(context).pushNamed("appwalk");
                    },
                    child:ListTile(
                      title: Text('App Walk Through',style: TextStyle(fontSize: 18),),
                      leading: Icon(Icons.description,color: Colors.lightBlue,size: 30,),
                    )
                ),
                Divider(),

                InkWell(
                  //delete student from DB

                    onTap: (){
                      Navigator.of(context).pushNamed("/LoginPage");
                    },
                    child:ListTile(
                      title: Text('Log Out',style: TextStyle(fontSize: 18),),
                      leading: Icon(Icons.power_settings_new,color: Colors.lightBlue,size: 30,),
                    )
                ),
              ]
          )

      ),
    );
  }

  getBodywidget() {
    return(_currentIndex==0)? HomePage():Container(); }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
      switch(index) {
        case 0: { _title = 'Home'; }
        break;
        case 1: { _title = 'EditProfile'; }
        break;
        case 2: { _title = 'Health Information'; }
        break;
      }
    });
  }

//void _deleteStudent(buildContext context,Person person){

//}


}
