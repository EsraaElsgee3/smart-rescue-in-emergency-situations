import 'package:agdourapp2/emergencynumbers.dart';
import 'package:agdourapp2/forgotpass.dart';
import 'package:agdourapp2/mainPage.dart';
import 'package:agdourapp2/personal.dart';
import 'package:agdourapp2/terms.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:agdourapp2/DB.dart';
void main() {
  runApp(MaterialApp(
    routes: <String,WidgetBuilder>{
      '/': (context) =>MainPage('',''),
      '/personal' : (BuildContext context) => Personal(),
      '/forgot': (BuildContext context) => Forgotpass()
    },
  ));
}
class  LoginPage extends StatefulWidget {

  @override
  _State createState() => _State();
}

class _State extends State<LoginPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final AuthService _auth = AuthService();
  final _FormKey =GlobalKey<FormState>();
  String EmailAddress='';
  String Password='';
  String error = '';
  @override
  Widget build(BuildContext context) {
    return Container(decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/pn.jpg'),
          fit: BoxFit.cover,
        )),

      child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
          ),
          body: Padding(
              padding: EdgeInsets.all(10),
              child:Form(
                  key:_FormKey,

              child: ListView(
                children: <Widget>[
                  Icon(Icons.supervised_user_circle,
                    size: 50,
                    color: Colors.blueAccent,
                  ),
                  Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(10),
                      child:
                      Text(
                        'Login',
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                        ),
                      )),
                  Container(
                    padding: EdgeInsets.all(10),
                    child: TextFormField(
                      validator: (val) =>val.isEmpty ? 'Enter your E-mail Address': null,
                      onChanged: (val){
                        setState(() => EmailAddress = val );
                      },
                      controller: nameController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Email',
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                    child: TextFormField(
                      validator: (val) => val.length < 6 ? 'Enter a password 6+ chars long' : null,
                      onChanged: (val){
                      setState(() => Password = val );
                    },
                      obscureText: true,
                      controller: passwordController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Password',
                      ),),),
                  FlatButton(
                    textColor: Colors.black,
                    child: Text('Forgot Password',style: TextStyle(fontSize: 17),),
                    onPressed: (){

                      Navigator.push(context, MaterialPageRoute(
                          builder: (context) => Forgotpass()
                      ));
                    },),
                  SizedBox(height: 12.0),
                  Text(
                    error,
                    style: TextStyle(color: Colors.red, fontSize: 14.0),
                  ),
                  Container(
                      height: 70,
                      padding: EdgeInsets.fromLTRB(10, 0, 10, 5),
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        textColor: Colors.white,
                        color: Colors.blueAccent,
                        child: Text('Login',
                          style: TextStyle(
                              fontSize: 23,
                              color: Colors.white
                          ),
                        ),
                        onPressed: () async{
                          if(_FormKey.currentState.validate()) {
                            dynamic result = await _auth
                                .signInWithEmailAndPassword(EmailAddress,
                                Password);
                            if (result == null) {
                              setState(() {
                                error =
                                'Could not sign in with those credentials';
                              });
                            }
                            else {
                              final db = Firestore.instance;
                              DocumentSnapshot snap =
                              await db.collection('personal').document(result.uid).get();
                              Navigator.push(context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          MainPage(snap.data['FullName'],EmailAddress)
                                  ));}}
                          print(nameController.text);
                          print(passwordController.text);
                          },)),
                  Container(
                    child: Padding(padding: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width*0.1,
                        MediaQuery.of(context).size.width*0.03,
                        0,
                        MediaQuery.of(context).size.width*0.03),
                      child: Text(
                        '----------- OR -----------',
                        style: TextStyle(
                          color: Colors.lightBlue,
                          fontWeight: FontWeight.bold,
                          fontSize:18 ,
                        ),
                      ),),),
                  Container(
                      height: 70,
                      padding: EdgeInsets.fromLTRB(10, 0, 10, 5),
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        textColor: Colors.white,
                        color: Colors.blueAccent,
                        child: Text('Emergency Numbers',
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.white),),
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(
                                  builder: (context) => EmergencyNumbers(),
                              ));
                          print(nameController.text);
                          print(passwordController.text);},)),
                  SizedBox(height: 20,),
                  Container(
                      child: Row(
                        children: <Widget>[
                          Text('Does not have account?',
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.black),),
                          FlatButton(
                              textColor: Colors.blueAccent,
                              child: Text(
                                'Sign up',
                                style: TextStyle(fontSize: 25),),
                              onPressed: (){
                                Navigator.push(context,
                                    MaterialPageRoute(
                                        builder: (context) => TermsScreen()));})],
                        mainAxisAlignment: MainAxisAlignment.center,
                      ))],))),));}}
