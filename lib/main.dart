import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:phone_tap/app/homepage.dart';
import 'package:phone_tap/sign/login.dart';
import 'package:phone_tap/sign/register.dart';

void main() {
  runApp(const PhoneTap());
}

class PhoneTap extends StatelessWidget {
  const PhoneTap({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'PhoneTap', initialRoute: "signLogin", routes: {
      "signLogin": (context) => const SignLogin(),
      "signRegister": (context) => const SignRegister(),
      HomePage.routeName: (context) => const HomePage()
    });
  }
}
