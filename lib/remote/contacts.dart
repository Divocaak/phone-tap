import 'dart:async';
import "dart:convert";
import 'package:http/http.dart';
import "package:phone_tap/general.dart";
import 'package:phone_tap/objects/contact.dart';

class RemoteContact {
  static String url = remoteUrl + "contacts/";

  static Future<Contact> getContact(String number, int userId) async {
    final Response response = await get(
        Uri.parse(Uri.encodeFull(url +
            "getContact.php?number=" +
            number +
            "&userId=" +
            userId.toString())),
        headers: {"Accept": "application/json;charset=UTF-8"});
    if (response.statusCode == 200) {
      return Contact.fromJson(jsonDecode(response.body));
    } else {
      return null;
    }
  }

  static Future<String> setContact(
      String name, String userId, String contactNum, String categoryId) async {
    final Response response = await get(
        Uri.parse(Uri.encodeFull(url +
            "setContact.php?userId=" +
            userId +
            "&contactNum=" +
            contactNum +
            "&categoryId=" +
            categoryId +
            "&name=" +
            name)),
        headers: {"Accept": "application/json;charset=UTF-8"});
    if (response.statusCode == 200) {
      return response.body;
    } else {
      return null;
    }
  }
}
