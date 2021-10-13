import 'dart:async';
import "dart:convert";
import 'package:http/http.dart';
import "package:phone_tap/general.dart";

class RemoteSign {
  static String url = remoteUrl;

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
    print(url +
        "register.php?phone=" +
        phone +
        "&&password=" +
        pass +
        "&&token=" +
        token);
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception("Can't register user");
    }
  }

  static Future<User> login(String phone, String password) async {
    final Response response = await get(
        Uri.parse(Uri.encodeFull(
            url + "userLogin.php?phone=" + phone + "&&password=" + password)),
        headers: {"Accept": "application/json;charset=UTF-8"});
    if (response.statusCode == 200) {
      final Map parsed = jsonDecode(response.body);
      return User.fromJson(parsed);
    } else {
      throw Exception("Can't login user");
    }
  }
}
