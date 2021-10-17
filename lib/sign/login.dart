import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:phone_tap/objects/user.dart';
import 'package:phone_tap/sign/widgets.dart';
import 'package:phone_tap/remote/sign.dart';

class SignLogin extends StatefulWidget {
  const SignLogin({Key key}) : super(key: key);

  @override
  _SignLoginState createState() => _SignLoginState();
}

Future<User> response;

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
                  if (phoneController.text.isNotEmpty &&
                      passController.text.isNotEmpty) {
                    response = RemoteSign.login(
                        phoneController.text, passController.text);

                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: FutureBuilder(
                            future: response,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                Future.delayed(
                                    Duration.zero,
                                    () => Navigator.of(context).pushNamed(
                                        "homePage",
                                        arguments: snapshot.data));
                              } else if (snapshot.hasError) {
                                return const Text(
                                    "Někde se stala chyba, zkuste to později.");
                              }

                              return const Center(
                                  child: CircularProgressIndicator());
                            })));
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: const Text('Vyplňte prosím obě pole'),
                        action: SnackBarAction(
                            label: 'Rozumím', onPressed: () {})));
                  }
                }, "login")
              ])
            ])));
  }
}
