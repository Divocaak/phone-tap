import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

void main() {
  runApp(const PhoneTap());
}

class PhoneTap extends StatelessWidget {
  const PhoneTap({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(title: 'PhoneTap', home: HomePage());
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
              inputField(phoneController, TextInputType.phone, false),
              inputField(passController, TextInputType.text, true),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                formButton(() {
                  debugPrint(phoneController.text);
                }, "register"),
                formButton(() {
                  debugPrint(passController.text);
                }, "login")
              ])
            ])));
  }

  Widget inputField(TextEditingController controller,
      TextInputType keyboardType, bool obscureText) {
    return TextField(
        controller: controller,
        keyboardType: keyboardType,
        autocorrect: false,
        obscureText: obscureText);
  }

  Widget formButton(Function() onPressed, String text) {
    return TextButton(onPressed: onPressed, child: Text(text));
  }
}
