import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:phone_tap/app/homepage.dart';
import 'package:phone_tap/sign/login.dart';
import 'package:phone_tap/sign/register.dart';
import 'package:workmanager/workmanager.dart';

const myTask = "syncWithTheBackEnd";

void main() {
  /* Workmanager().initialize(callbackDispatcher);
  Workmanager().registerOneOffTask(
    "1",
    myTask,
    initialDelay: Duration(minutes: 5),
    constraints: WorkManagerConstraintConfig(
      requiresCharging: true,
      networkType: NetworkType.connected,
    ),
  ); */
  runApp(const PhoneTap());
}

/* void callbackDispatcher() {
  Workmanager().executeTask((task) {
    switch (task) {
      case myTask:
        print("this method was called from native!");
        break;
      case Workmanager.iOSBackgroundTask:
        print("iOS background fetch delegate ran");
        break;
    }

    //Return true when the task executed successfully or not
    return Future.value(true);
  });
} */

class PhoneTap extends StatelessWidget {
  const PhoneTap({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'PhoneTap', initialRoute: "signLogin", routes: {
      "signLogin": (context) => const SignLogin(),
      "signRegister": (context) => const SignRegister(),
      HomePage.routeName: (context) => const HomePage()
    });
  }
}
