import 'package:call_log/call_log.dart';
import 'package:phone_tap/objects/contact.dart';
import 'package:flutter/material.dart';
import 'package:phone_tap/general.dart';
import 'package:intl/intl.dart';

class Log {
  DateTime dateStart;
  DateTime dateEnd;
  Contact contact;

  Log(this.dateStart, this.dateEnd, this.contact);

  factory Log.fromJson(Map<dynamic, dynamic> json) {
    return Log(DateTime.parse(json["dateStart"]),
        DateTime.parse(json["dateEnd"]), Contact.fromJson(json["category"]));
  }

  // for future use
  Map<String, dynamic> toJson() =>
      {"dateStart": dateStart, "dateEnd": dateEnd, "contact": contact};

  String getDuration() {
    Duration duration =
        Duration(seconds: dateStart.difference(dateEnd).inSeconds);
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return twoDigits(duration.inHours) +
        ":" +
        twoDigitMinutes +
        ":" +
        twoDigitSeconds;
  }
}

class LogWidget extends StatefulWidget {
  const LogWidget(this.entry, {Key key}) : super(key: key);

  final CallLogEntry entry;

  @override
  _LogWidgetState createState() => _LogWidgetState();
}

class _LogWidgetState extends State<LogWidget> {
  TextEditingController inputNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      callIcon(widget.entry),
      Column(children: [
        Row(children: [
          General.iconText(
              DateFormat("EEE M/d/y – HH:mm").format(
                  DateTime.fromMillisecondsSinceEpoch(widget.entry.timestamp)),
              Icons.calendar_today),
          General.iconText(
              printDuration(Duration(seconds: widget.entry.duration)),
              Icons.timer)
        ])
      ])
    ]);
  }

  Icon callIcon(CallLogEntry entry) {
    if (entry.callType == CallType.incoming) {
      return const Icon(Icons.call_received, color: Colors.green);
    } else if (entry.callType == CallType.outgoing) {
      return const Icon(Icons.call_made, color: Colors.blue);
    } else {
      return const Icon(Icons.phone, color: Colors.red);
    }
  }
}
