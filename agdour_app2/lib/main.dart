import 'package:agdourapp2/ContactUs.dart';
import 'package:agdourapp2/Profile.dart';
import 'package:agdourapp2/RateApp.dart';
import 'package:agdourapp2/ShareApp.dart';
import 'package:agdourapp2/appWay.dart';
import 'package:agdourapp2/homePage.dart';
import 'package:agdourapp2/loginpage.dart';
import 'package:agdourapp2/logo.dart';
import 'package:agdourapp2/myprofile.dart';
import 'package:agdourapp2/readTerms.dart';
import 'package:agdourapp2/start.dart';
import 'package:agdourapp2/terms.dart';
import 'package:flutter/material.dart';
import 'package:agdourapp2/forgotpass.dart';
import 'package:agdourapp2/personal.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'geolocator_service.dart';
import 'mainPage.dart';



void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final locatorService= GeoLocatorService();


  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        FutureProvider(create: (context) => locatorService.getLocation()),
        FutureProvider(create: (context) {
          ImageConfiguration configuration = createLocalImageConfiguration(context);
          return BitmapDescriptor.fromAssetImage(configuration, 'icon');
        }),

        FutureProvider(create: (context) {
          ImageConfiguration configuration = createLocalImageConfiguration(context);
          return BitmapDescriptor.fromAssetImage(configuration,'icon');
        }),

      ],
      child:MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: <String,WidgetBuilder>{
          '/':(BuildContext context) =>LogoPage(),
          'terms':(BuildContext context) =>TermsScreen(),
          'readTerms':(BuildContext context) =>readTerms(),
          'start':(BuildContext context) =>Start(),
          'login':(BuildContext context) =>LoginPage(),
          'personal' : (BuildContext context) => Personal(),
          'forgot': (BuildContext context) => Forgotpass(),
          'Dialog': (BuildContext context) => Dialog(),
          'appwalk': (BuildContext context) => AppWay(),
          'main':(BuildContext context) =>MainPage('',''),
          'home': (context) =>HomePage(),
          "/MyProfile":(BuildContext context)=>MyProfile(),
          "/Profile":(BuildContext context)=>new FirestoreCRUDPage(),
          "/ShareApp":(BuildContext context)=>new ShareApp(),
          "/RateMyAppTestApp":(BuildContext context)=>new RateMyAppTestApp(),
          "/ContactUs":(BuildContext context)=>new ContactUs(),
          "/LoginPage":(BuildContext context)=>new LoginPage(),



        },
        theme: ThemeData(
          primaryColor: Colors.white,

        ),
        initialRoute: '/',

      ),
    );
  }
}


