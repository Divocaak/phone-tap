import 'package:call_log/call_log.dart';
import 'package:phone_tap/objects/contact.dart';
import 'package:flutter/material.dart';
import 'package:phone_tap/general.dart';
import 'package:intl/intl.dart';
import 'package:phone_tap/remote/logs.dart';

class Log {
  DateTime dateStart;
  DateTime dateEnd;
  Contact contact;

  Log(this.dateStart, this.dateEnd, {this.contact});

  factory Log.fromJson(Map<dynamic, dynamic> json) {
    return Log(
        DateTime.parse(json["dateStart"]), DateTime.parse(json["dateEnd"]),
        contact: Contact.fromJson(json["contact"]));
  }

  factory Log.fromCallLogEntry(CallLogEntry entry) {
    return Log(DateTime.fromMillisecondsSinceEpoch(entry.timestamp),
        DateTime.fromMillisecondsSinceEpoch(entry.timestamp + entry.duration));
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

  String getStart() {
    return DateFormat("EEE M/d/y – HH:mm").format(dateStart);
  }
}

class LogWidget extends StatefulWidget {
  const LogWidget(this.entry, this.userId, {Key key}) : super(key: key);

  final CallLogEntry entry;
  final int userId;

  @override
  _LogWidgetState createState() => _LogWidgetState();
}

class _LogWidgetState extends State<LogWidget> {
  @override
  Widget build(BuildContext context) {
    Future<Log> log = RemoteLog.getLog(
        widget.entry.number,
        widget.userId,
        DateFormat("y-M-d HH:mm:ss").format(
            DateTime.fromMillisecondsSinceEpoch(widget.entry.timestamp)));
    return FutureBuilder<Log>(
        future: log,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              return logDisplay(snapshot.data, true);
            } else {
              return logDisplay(Log.fromCallLogEntry(widget.entry), false);
            }
          } else {
            return const Center(child: Text("někde se stala chyba"));
          }
        });
  }

  Widget logDisplay(Log log, bool fromDb) {
    return Row(children: [
      callIcon(widget.entry),
      isSavedIcon(widget.entry, fromDb),
      Column(children: [
        Row(children: [
          General.iconText(log.getStart(), Icons.calendar_today),
          General.iconText(log.getDuration(), Icons.timer)
        ]),
        ContactWidget(widget.entry.number, widget.userId)
      ])
    ]);
  }

  Icon isSavedIcon(CallLogEntry entry, bool fromDb) {
    return Icon(fromDb ? Icons.check : Icons.cancel,
        color: fromDb ? Colors.green : Colors.red);
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
