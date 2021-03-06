import 'package:flutter/material.dart';
import 'package:rate_my_app/rate_my_app.dart';
import 'package:shared_preferences/shared_preferences.dart';


/// Main Rate my app instance.
RateMyApp rateMyApp = RateMyApp();


class RateMyAppTestApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue,
        title: const Text('Rate my app !',style: TextStyle(fontSize: 30),),
        iconTheme: new IconThemeData(color: Colors.white),
      ),
      body:
      RateMyAppTestAppBody(),


    ),
  );
}

/// The body of the main Rate my app test widget.
class RateMyAppTestAppBody extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => RateMyAppTestAppBodyState();

}

/// The body state of the main Rate my app test widget.
class RateMyAppTestAppBodyState extends State<RateMyAppTestAppBody> {
  @override
  Widget build(BuildContext context) => Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0),
      child: Container(
        decoration: new BoxDecoration(
          image: new DecorationImage(image: new AssetImage('assets/pn.jpg'),
              fit: BoxFit.fitHeight
          ),
        ),
        child:Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            //Stack(
            //children: <Widget>[
            //Container(
            //child: new Column(
            //mainAxisAlignment: MainAxisAlignment.start,
            //children: <Widget>[
            //],
            //   )
            //)
            //],
            //),
            Padding(
              padding: const EdgeInsets.only(top: 20,left: 30,right: 30),
              child: RaisedButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                color: Colors.blueAccent,
                child: const Text(' "Rate my app" ',style: TextStyle(color: Colors.white,fontSize: 20),),
                onPressed: () => rateMyApp.showRateDialog(context).then((_) => setState(() {})),
                // We launch the default Rate my app dialog.
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10,left: 30,right: 30),
              child: RaisedButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                color: Colors.blueAccent,
                child: const Text(' "Rate my app" star ',style: TextStyle(color: Colors.white,fontSize: 20),),
                onPressed: () => rateMyApp.showStarRateDialog(context, actionsBuilder: (_, count) {
                  final Widget cancelButton = RateMyAppNoButton(
                    // We create a custom "Cancel" button using the RateMyAppNoButton class.
                    rateMyApp,
                    text: 'CANCEL',
                    callback: () => setState(() {}),
                  );
                  if (count == null || count == 0) {
                    // If there is no rating (or a 0 star rating), we only have to return our cancel button.
                    return [cancelButton];
                  }

                  // Otherwise we can do some little more things...
                  String message = 'You\'ve put ' + count.round().toString() + ' star(s). ';
                  Color color;
                  switch (count.round()) {
                    case 1:
                      message += 'Did this app not useful for you ?';
                      color = Colors.red;
                      break;
                    case 2:
                      message += 'That\'s not really not bad';
                      color = Colors.orange;
                      break;
                    case 3:
                      message += 'Well, it\'s average.';
                      color = Colors.yellow;
                      break;
                    case 4:
                      message += 'This is cool, like this app.';
                      color = Colors.lime;
                      break;
                    case 5:
                      message += 'Great ! <3';
                      color = Colors.green;
                      break;
                  }

                  return [
                    FlatButton(
                      child: const Text('OK'),
                      onPressed: () async {
                        print(message);
                        Scaffold.of(context).showSnackBar(
                          SnackBar(
                            content: Text(message),
                            backgroundColor: color,
                          ),
                        );

                        // This allow to mimic a click on the default "Rate" button and thus update the conditions based on it ("Do not open again" condition for example) :
                        await rateMyApp.callEvent(RateMyAppEventType.rateButtonPressed);
                        //Navigator.pop<RateMyAppDialogButton>(context, RateMyAppDialogButton.rate);


                        setState(() {});
                      },
                    ),
                    cancelButton,
                  ];
                }),
              ),),
            Padding(padding: const EdgeInsets.only(top: 10,left: 30,right: 30),
              child: RaisedButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                color: Colors.blueAccent,
                child: const Text('Reset',style: TextStyle(color: Colors.white,fontSize: 20),),
                onPressed: () => rateMyApp.reset().then((_) => setState(() {})), // We reset all Rate my app conditions values.
              ),)
          ],
        ),)
  );

  /// Returns a centered text.
  Text _textCenter(String content) => Text(
    content,
    textAlign: TextAlign.center,
  );
}

/// Here's an example of a custom condition.
/// Will not be met if the dialog has been opened too many times.
class MaxDialogOpeningCondition extends DebuggableCondition {
  /// Maximum default dialog opening count (inclusive).
  final int maxDialogOpeningCount;

  /// Maximum star dialog opening count (inclusive).
  final int maxStarDialogOpeningCount;

  /// Current dialog opening count.
  int dialogOpeningCount;

  /// Current star dialog opening count.
  int starDialogOpeningCount;

  /// Creates a new max dialog opening condition instance.
  MaxDialogOpeningCondition(
      RateMyApp rateMyApp, {
        this.maxDialogOpeningCount = 3,
        this.maxStarDialogOpeningCount = 3,
      })  : assert(maxDialogOpeningCount != null),
        assert(maxStarDialogOpeningCount != null)
  ;// super(rateMyApp);

  @override
  void readFromPreferences(SharedPreferences preferences, String preferencesPrefix) {
    // Here we can read the values (or we set their default values).
    dialogOpeningCount = preferences.getInt(rateMyApp.preferencesPrefix + 'dialogOpeningCount') ?? 0;
    starDialogOpeningCount = preferences.getInt(rateMyApp.preferencesPrefix + 'starDialogOpeningCount') ?? 0;
  }

  @override
  Future<void> saveToPreferences(SharedPreferences preferences, String preferencesPrefix) async {
    // Here we save our current values.
    await preferences.setInt(rateMyApp.preferencesPrefix + 'dialogOpeningCount', dialogOpeningCount);
    return preferences.setInt(rateMyApp.preferencesPrefix + 'starDialogOpeningCount', starDialogOpeningCount);
  }

  @override
  void reset() {
    // Allows to reset this condition values back to their default values.
    dialogOpeningCount = 0;
    starDialogOpeningCount = 0;
  }

  @override
  bool onEventOccurred(RateMyAppEventType eventType) {
    if (eventType == RateMyAppEventType.dialogOpen) {
      // If the default dialog has been opened, we update our default dialog counter.
      dialogOpeningCount++;
      return true; // Returning true allows to trigger a shared preferences save.
    }

    if (eventType == RateMyAppEventType.starDialogOpen) {
      // If the star dialog has been opened, we update our star dialog counter.
      starDialogOpeningCount++;
      return true;
    }

    return false; // Otherwise, no need to save anything.
  }

  @override
  String get valuesAsString {
    // Allows to easily debug this condition.
    return 'Dialog opening count : ' + dialogOpeningCount.toString() + '\nMax dialog opening count : ' + maxDialogOpeningCount.toString() + 'Star dialog opening count : ' + starDialogOpeningCount.toString() + '\nMax star dialog opening count : ' + maxStarDialogOpeningCount.toString();
  }

  @override
  bool get isMet {
    // This allows to check whether this condition is met in its current state.
    return dialogOpeningCount <= maxDialogOpeningCount && starDialogOpeningCount <= maxStarDialogOpeningCount;
  }
}
@override
void initState() {
  WidgetsFlutterBinding
      .ensureInitialized(); // This allows to use async methods in the main method without any problem.

  // _rateMyApp.conditions.add(MaxDialogOpeningCondition(_rateMyApp)); // This one is a little example of a custom condition. See below for more info.
  rateMyApp.init().then((_) {
    // We initialize our Rate my app instance.
    runApp(RateMyAppTestApp());
    rateMyApp.conditions.forEach((condition) {
      if (condition is DebuggableCondition) {
        print(condition.valuesAsString); // We iterate through our list of conditions and we print all debuggable ones.
      }
    });

    print('Are all conditions met ? ' +
        (rateMyApp.shouldOpenDialog ? 'Yes' : 'No'));
  });
}