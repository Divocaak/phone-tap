import 'package:flutter/material.dart';
import 'package:phone_tap/sign/widgets.dart';

class SignLogin extends StatefulWidget {
  const SignLogin({Key? key}) : super(key: key);

  @override
  _SignLoginState createState() => _SignLoginState();
}

class _SignLoginState extends State<SignLogin> {
  TextEditingController phoneController = TextEditingController();
  TextEditingController passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              const Text("PhoneTap"),
              SignWidgets.inputField(
                  phoneController, TextInputType.phone, false),
              SignWidgets.inputField(passController, TextInputType.text, true),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                SignWidgets.formButton(
                    () => Navigator.of(context).pushNamed("signRegister"),
                    "register"),
                SignWidgets.formButton(() {
                  debugPrint(passController.text);
                }, "login")
              ])
            ])));
  }
}
