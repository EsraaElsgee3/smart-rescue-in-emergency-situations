import 'package:flutter/material.dart';
import 'Alligator.dart';
import 'package:share/share.dart';


class ShareApp extends StatelessWidget {
  List<Alligator>alligators = [
    Alligator(
        name: "Share App" , description: "Link of the app."),
    //Alligator(
    //name: "Munchy" , description: "Has a big belly , eats alot"),
    //Alligator(name: "Grunchy" , description: "Scaly Alligator that looks menacing. ")
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Share Our App",style:TextStyle(color: Colors.white,fontSize: 30) ,),
          backgroundColor: Colors.lightBlue,
        ),
        body:Container(
          decoration: new BoxDecoration(
              image: new DecorationImage(image: new AssetImage('assets/pn.jpg'),
                  fit: BoxFit.cover
              )
          ),
          child:Column(
            children: alligators.map((Alligator alligator)=>Card(
              child: ListTile(
                title: Text(alligator.name),
                subtitle: Text(alligator.description),
                onTap:()=>share(context,alligator),
              ),
            ))
                .toList(),
          ),)

    );
  }
}
void share(BuildContext context,Alligator alligator){
  final RenderBox box=context.findRenderObject();
  final String text="${alligator.name}-${alligator.description}";

  Share.share(text,subject: alligator.description,sharePositionOrigin: box.localToGlobal(Offset.zero)&box.size);
}
