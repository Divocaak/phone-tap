import 'package:flutter/material.dart';
import 'package:phone_tap/sign/widgets.dart';
import 'package:phone_tap/remote/sign.dart';

Future<String>? response;

class SignRegister extends StatefulWidget {
  const SignRegister({Key? key}) : super(key: key);

  @override
  _SignRegisterState createState() => _SignRegisterState();
}

class _SignRegisterState extends State<SignRegister> {
  TextEditingController phoneController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController passConfController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              const Text("Registrace"),
              SignWidgets.inputField(
                  phoneController, TextInputType.phone, false),
              SignWidgets.inputField(passController, TextInputType.text, true),
              SignWidgets.inputField(
                  passConfController, TextInputType.text, true),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                SignWidgets.formButton(
                    () => Navigator.of(context).pop(), "zpět"),
                SignWidgets.formButton(() {
                  if (phoneController.text.isNotEmpty &&
                      passController.text.isNotEmpty) {
                    if (passController.text == passConfController.text) {
                      response = RemoteSign.register(
                          phoneController.text, passController.text, "token");
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: const Text('Hesla se neshodují'),
                          action: SnackBarAction(
                              label: 'Rozumím', onPressed: () {})));
                    }

                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: FutureBuilder(
                            future: response,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return Text(
                                  snapshot.data.toString(),
                                );
                              }

                              return const Center(
                                  child: CircularProgressIndicator());
                            })));
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: const Text('Vyplňte prosím všechny hodnoty'),
                        action: SnackBarAction(
                            label: 'Rozumím', onPressed: () {})));
                  }
                }, "registrovat")
              ])
            ])));
  }
}
