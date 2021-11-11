import 'package:call_log/call_log.dart';
import 'package:flutter/material.dart';
import 'package:phone_tap/remote/logs.dart';
import 'package:phone_tap/general.dart';

class Contact {
  String name;
  int number;
  String category;

  Contact(this.name, this.number, this.category);

  factory Contact.fromJson(Map<dynamic, dynamic> json) {
    return Contact(json["name"], int.parse(json["number"]), json["category"]);
  }

  // mby future use?
  factory Contact.fromCallLogEntry(CallLogEntry entry) {
    return Contact(entry.name, int.parse(entry.number), "");
  }

  // for future use
  Map<String, dynamic> toJson() =>
      {"name": name, "number": number, "category": category};

  static Widget contactDisplay(String numberInput) {
    Future<Contact> contact = RemoteLogs.getContact(numberInput);

    return FutureBuilder<Contact>(
        future: contact,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            Contact gotContact = snapshot.data;
            return Row(children: [
              General.iconText(gotContact.name, Icons.person),
              General.iconText(gotContact.number.toString(), Icons.phone),
              General.iconText(gotContact.category, Icons.list),
            ]);
          } else if (!snapshot.hasData) {
            return TextButton(
                onPressed: () => print("save contact"),
                child: const Text("uložit kontakt"));
          } else {
            return const Center(child: Text("error"));
          }
        });
  }
}
