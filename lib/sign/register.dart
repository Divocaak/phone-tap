import 'package:flutter/material.dart';
import 'package:phone_tap/sign/widgets.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'dart:io';

class SignRegister extends StatefulWidget {
  const SignRegister({Key? key}) : super(key: key);

  @override
  _SignRegisterState createState() => _SignRegisterState();
}

class _SignRegisterState extends State<SignRegister> {
  TextEditingController phoneController = TextEditingController();
  TextEditingController passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Future<dynamic> deviceId = getId();
    print(deviceId);
    return Scaffold(
        body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              const Text("Registrace"),
              SignWidgets.inputField(
                  phoneController, TextInputType.phone, false),
              SignWidgets.inputField(passController, TextInputType.text, true),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                SignWidgets.formButton(
                    () => Navigator.of(context).pop(), "zpět"),
                SignWidgets.formButton(() {
                  debugPrint("asd");
                }, "registrovat")
              ])
            ])));
  }

  Future<dynamic> getId() async {
    var deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS) {
      var iosDeviceInfo = await deviceInfo.iosInfo;
      return iosDeviceInfo.identifierForVendor;
    } else {
      var androidDeviceInfo = await deviceInfo.androidInfo;
      return androidDeviceInfo.androidId;
    }
  }
}
