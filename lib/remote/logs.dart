import 'dart:async';
import "dart:convert";
import 'package:http/http.dart';
import "package:phone_tap/general.dart";
import 'package:phone_tap/objects/contact.dart';

class RemoteLogs {
  static String url = remoteUrl + "logs/";

  static Future<Contact> getContact(String number) async {
    final Response response = await get(
        Uri.parse(Uri.encodeFull(url + "getContact.php?number=" + number)),
        headers: {"Accept": "application/json;charset=UTF-8"});
    if (response.statusCode == 200) {
      return Contact.fromJson(jsonDecode(response.body));
    } else {
      return null;
    }
  }
}
