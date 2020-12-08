import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class EmergencyNumbers extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {

    return _EmergencyNumbersState();
  }

}
class _EmergencyNumbersState extends State<EmergencyNumbers>{
  List names=["Preventive Medicine","Fire Brigade","Emergency Police","Electricity Emergency","Ambulance","Traffic Police","Tourist police ","Gas emergency","Ministry of health","Anti-addiction"];
  List numbers=["105","180","122","121","123","128","126","129","137","16023"];
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        backgroundColor: Colors.blue,
        centerTitle: true,
        title: Text("Emergency Numbers",
            style: TextStyle(fontSize: 25, color: Colors.white)),
        iconTheme: new IconThemeData(color: Colors.white),

      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/pn.jpg"),
            fit: BoxFit.cover,
          ),
        ),


        child: new ListView.builder(

          itemBuilder:(_,int index)=>listDataItem(this.names[index],this.numbers[index]),
          itemCount: this.names.length,


        ),
      ),
    );
  }}


class listDataItem extends StatelessWidget{
  String names ,numbers;
  listDataItem(this.names  ,this.numbers);

  @override
  Widget build(BuildContext context) {
    return new Card(
      elevation: 15,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),


      child: new Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),

        ),
        margin: EdgeInsets.fromLTRB(10, 20, 5, 20),

        child: new GestureDetector(
          onTap: (){
            call();
          },

          child: new Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,

            children: <Widget>[
              new CircleAvatar(
                child: new Text(names[0]),
                backgroundColor:Colors.blue,
                foregroundColor: Colors.white,

              ),


              Text(names,style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 18),),

              Text(numbers,style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 18),),

              Image(image: AssetImage('assets/pp.png'),
                width:50,
                height:50,

              ),


            ],

          ),

        ),


      ),

    );
  }



  call(){
    String pheneno="tel:"+numbers;
    launch(pheneno);
  }

}