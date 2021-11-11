import 'package:flutter/material.dart';

String remoteUrl = "http://10.0.2.2/phone_tap_server/";

class General {
  static Widget iconText(String text, IconData iconData) {
    return Row(children: [Icon(iconData), Text(text)]);
  }
}
