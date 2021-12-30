import 'dart:async';
import "dart:convert";
import 'package:http/http.dart';
import "package:phone_tap/general.dart";
import 'package:phone_tap/objects/log.dart';

class RemoteLog {
  static String url = remoteUrl + "logs/";

  static Future<Log> getLog(String number, int userId, String dateStart) async {
    final Response response = await get(
        Uri.parse(Uri.encodeFull(url +
            "getLog.php?number=" +
            number +
            "&userId=" +
            userId.toString() +
            "&dateStart=" +
            dateStart.toString())),
        headers: {"Accept": "application/json;charset=UTF-8"});
    if (response.statusCode == 200) {
      return Log.fromJson(jsonDecode(response.body));
    } else {
      return null;
    }
  }
}
