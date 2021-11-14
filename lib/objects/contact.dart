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
}

class ContactWidget extends StatefulWidget {
  const ContactWidget(this.numberInput, this.userId, {Key key})
      : super(key: key);

  final String numberInput;
  final int userId;

  @override
  _ContactWidgetState createState() => _ContactWidgetState();
}

class _ContactWidgetState extends State<ContactWidget> {
  TextEditingController inputNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Future<Contact> contact = RemoteLogs.getContact(widget.numberInput);
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
                onPressed: () => showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                          title: const Text("Jak chcete kontakt uložit?"),
                          content: TextField(controller: inputNameController),
                          actions: [
                            TextButton(
                                child: const Text("Osobní"),
                                onPressed: () => saveContact(
                                    inputNameController.text,
                                    widget.userId,
                                    widget.numberInput,
                                    1,
                                    this)),
                            TextButton(
                                child: const Text("Prodávající"),
                                onPressed: () => saveContact(
                                    inputNameController.text,
                                    widget.userId,
                                    widget.numberInput,
                                    2,
                                    this)),
                            TextButton(
                                child: const Text("Kupující"),
                                onPressed: () => saveContact(
                                    inputNameController.text,
                                    widget.userId,
                                    widget.numberInput,
                                    3,
                                    this))
                          ]);
                    }),
                child: Text("uložit kontakt: " + widget.numberInput));
          } else {
            return const Center(child: Text("error"));
          }
        });
  }

  static void saveContact(
      String name, int userId, String contactNum, int categoryId, State cw) {
    Navigator.of(cw.context).pop();
    Future<String> response = RemoteLogs.setContact(
        name, userId.toString(), contactNum, categoryId.toString());

    ScaffoldMessenger.of(cw.context).showSnackBar(SnackBar(
        content: FutureBuilder(
            future: response,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                Future.delayed(Duration.zero, () async {
                  cw.setState(() {});
                });
                return Text(snapshot.data.toString());
              } else if (snapshot.hasError) {
                return const Text("Někde se stala chyba, zkuste to později.");
              }

              return const Center(child: CircularProgressIndicator());
            })));
  }
}
