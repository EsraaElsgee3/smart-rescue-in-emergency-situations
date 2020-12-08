import 'package:flutter/material.dart';
void main() {
  runApp(MaterialApp(
  ));
}
class Forgotpass extends StatefulWidget {
  @override
  _State createState() => _State();
}
class _State extends State<Forgotpass> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/pn.jpg'),
              fit: BoxFit.cover,
            )),
        child: MaterialApp(home: Scaffold(
            backgroundColor: Colors.transparent,
            body: SingleChildScrollView(
                child: Container(
                    padding: EdgeInsets.only(top: 70),
                    child: Column(children: <Widget>[
                      Container(padding: EdgeInsets.all(15),
                          child: Row(children: <Widget>[
                            Icon(
                              Icons.mail,
                              size: 30,
                              color: Colors.black,
                            ),
                            Text(
                              'Enter Your Email',
                              style: TextStyle(fontSize: 25),),])
                      ),
                      SizedBox(
                          width: 350.0,
                          height: 70,
                          child: TextField(
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
                              hintText: 'Enter email',
                              hintStyle: TextStyle(
                                color: Colors.grey,),),
                          )),
                      FlatButton(
                        textColor: Colors.lightBlue,
                        child: Text(
                          'Submit',
                          style: TextStyle(fontSize: 25),),
                        onPressed: (){
                          sendData(context);
                        },
                      )]))
            ))));
  }
  void sendData(BuildContext context){
    var alertDialog=AlertDialog(
      title: Text("Data has been sent successfully!"),
      content: Text("Check your email",style: TextStyle(fontSize: 13),),
    );
    showDialog(
        context: context,
        builder: (BuildContext context){
          return alertDialog;
        });
  }}