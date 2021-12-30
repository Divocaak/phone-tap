import 'dart:async';
import "dart:convert";
import 'package:http/http.dart';
import "package:phone_tap/general.dart";
import "package:phone_tap/objects/user.dart";

class RemoteSign {
  static String url = remoteUrl + "sign/";

  static Future<String> register(
      String phone, String pass, String token) async {
    final Response response = await get(
        Uri.parse(Uri.encodeFull(url +
            "register.php?phone=" +
            phone +
            "&&password=" +
            pass +
            "&&token=" +
            token)),
        headers: {"Accept": "application/json;charset=UTF-8"});
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception("Can't register user");
    }
  }

  static Future<User> login(String phone, String password) async {
    final Response response = await get(
        Uri.parse(Uri.encodeFull(
            url + "login.php?phone=" + phone + "&&password=" + password)),
        headers: {"Accept": "application/json;charset=UTF-8"});
    if (response.statusCode == 200) {
      return User.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Can't login user");
    }
  }
}
