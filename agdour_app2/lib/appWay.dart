import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppWay extends StatefulWidget {
  @override
  _AppWayState createState() => _AppWayState();
}

class _AppWayState extends State<AppWay> {
  final int _numPages = 4;
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  List<Widget> _buildPageIndicator() {
    List<Widget> list = [];
    for (int i = 0; i < _numPages; i++) {
      list.add(i == _currentPage ? _indicator(true) : _indicator(false));
    }
    return list;
  }

  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      height: 8.0,
      width: isActive ? 24.0 : 16.0,
      decoration: BoxDecoration(
        color: isActive ? Colors.white : Colors.lightBlue,
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0.1, 0.4, 0.7, 0.9],
              colors: [
                Colors.lightBlueAccent,
                Colors.lightBlue,
                Colors.blue,
                Colors.blueAccent,
              ],
            ),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 40.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Container(
                  alignment: Alignment.centerRight,
                  child: FlatButton(
                    onPressed: () { Navigator.of(context).pushNamed("main");},
                    child: Text(
                      'Skip',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 400.0,
                  child: PageView(
                    physics: ClampingScrollPhysics(),
                    controller: _pageController,
                    onPageChanged: (int page) {
                      setState(() {
                        _currentPage = page;
                      });
                    },
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(40.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Center(
                              child: Image(
                                image: AssetImage(
                                  'assets/n.jpg',
                                ),
                                height: 160,
                                width: 350,
                              ),
                            ),
                            SizedBox(height: 30.0),
                            Text(
                              '          App Dashboard',
                              style: TextStyle(fontSize: 20,color: Colors.white,height: 1.5),
                            ),
                            SizedBox(height: 15.0),
                            Text(
                              'Dashboared contains emergency\nrelated buttons, click on the required \nbutton during emergencies to raise\nemergency call ',
                              style: TextStyle(fontSize: 16,color: Colors.white,height: 1.2),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(40.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Center(
                              child: Image(
                                image: AssetImage(
                                  'assets/amb.jpg',
                                ),
                                height: 130,
                                width: 300,
                              ),
                            ),
                            SizedBox(height: 20.0),
                            Text(
                              '         Ambulance Request ',
                              style: TextStyle(fontSize: 20,color: Colors.white,height: 1.5),
                            ),
                            SizedBox(height: 15.0),
                            Text(
                              'When needed ambulance during\nemergencies this page provides you \ndetails to create an ambulance request \nand it sends either your current location  ',
                              style: TextStyle(fontSize: 16,color: Colors.white,height: 1.2),
                            ),
                          ],
                        ),
                      ),

                      Padding(
                        padding: EdgeInsets.all(40.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Center(
                              child: Image(
                                image: AssetImage(
                                  'assets/mb.jpg',
                                ),
                                height: 150,
                                width: 400,
                              ),
                            ),
                            SizedBox(height: 30.0),
                            Text(
                              '         Nearby Medical Places',
                              style: TextStyle(fontSize: 20,color: Colors.white,height: 1.5),
                            ),
                            SizedBox(height: 15.0),
                            Text(
                              'This app allows you to search nearby\n  hospitals and pharmacies and gives\nyou the route direction of a select item',
                              style: TextStyle(fontSize: 16,color: Colors.white,height: 1.2),
                            ),
                          ],
                        ),
                      ),

                      Padding(
                        padding: EdgeInsets.all(40.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Center(
                              child: Image(
                                image: AssetImage(
                                  'assets/caal.png',
                                ),
                                height: 120,
                                width: 150,
                              ),
                            ),
                            SizedBox(height: 30.0),
                            Text(
                              '        Emergecny Numbers ',
                              style: TextStyle(fontSize: 20,color: Colors.white,height: 1.5),
                            ),
                            SizedBox(height: 15.0),
                            Text(
                              'With this button, you can find all the\n   emergency numbers you need  \n in differentemergency situations',
                              style: TextStyle(fontSize: 16,color: Colors.white,height: 1.2),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: _buildPageIndicator(),
                ),
                _currentPage != _numPages - 1
                    ? Expanded(
                  child: Align(
                    alignment: FractionalOffset.bottomRight,
                    child: FlatButton(
                      onPressed: () {
                        _pageController.nextPage(
                          duration: Duration(milliseconds: 500),
                          curve: Curves.ease,
                        );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Text(
                            'Next',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 22.0,
                            ),
                          ),
                          SizedBox(width: 10.0),
                          Icon(
                            Icons.arrow_forward,
                            color: Colors.white,
                            size: 30.0,
                          ),
                        ],
                      ),
                    ),
                  ),
                )
                    : Text(''),
              ],
            ),
          ),
        ),
      ),
      bottomSheet: _currentPage == _numPages - 1
          ? Container(
        height: 100.0,
        width: double.infinity,
        color: Colors.white,
        child: GestureDetector(
          onTap: () =>  { Navigator.of(context).pushNamed("main")},
          child: Center(
            child: Padding(
              padding: EdgeInsets.only(bottom: 30.0),
              child: Text(
                'Get started',
                style: TextStyle(
                  color: Colors.lightBlue,
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      )
          : Text(''),
    );
  }
}