import 'package:agdourapp2/search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class ZoomMap extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _ZoomMapState();
  }}

class _ZoomMapState extends State<ZoomMap> {
  @override
  Widget build(BuildContext context) {
    final currentPosition = Provider.of<Position>(context);

    return Scaffold(
      body:(currentPosition!=null)?  Stack(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child:  GoogleMap(
              mapType: MapType.hybrid,

              initialCameraPosition: CameraPosition(
                  target: LatLng(currentPosition.latitude,
                      currentPosition.longitude),
                  zoom: 16.0),
              zoomGesturesEnabled: true,
              myLocationEnabled: true,
            ),),
          Positioned(
            top: 10,
            left: 10,
            child:FloatingActionButton(
              backgroundColor: Colors.white70,
              child: Icon(Icons.fullscreen_exit,
                color: Colors.black54,),
              onPressed: (){
                Navigator.push(context,
                    MaterialPageRoute(
                        builder: (context) => Search()
                    ));
              },

            ),),],
      ): Center(
        child: CircularProgressIndicator(),),
    );}}