import 'package:flutter/material.dart';
import 'package:phone_tap/objects/user.dart';
import 'package:call_log/call_log.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);
  static const String routeName = "homePage";

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  User loggedUser;
  Future<List<CallLogEntry>> calls;

  @override
  Widget build(BuildContext context) {
    loggedUser = ModalRoute.of(context).settings.arguments;
    calls = getEntries();

    return Scaffold(
        body: FutureBuilder<List<CallLogEntry>>(
            future: calls,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, i) {
                      CallLogEntry entry = snapshot.data[i];
                      return Row(children: [
                        if (entry.callType == CallType.incoming)
                          const Icon(Icons.call_received, color: Colors.green)
                        else if (entry.callType == CallType.outgoing)
                          const Icon(Icons.call_made, color: Colors.blue)
                        else
                          const Icon(Icons.phone, color: Colors.red),
                        Text(entry.name),
                        Text(entry.number),
                        Text(entry.duration.toString())
                      ]);
                    });
              } else if (snapshot.hasError) {
                return const Center(child: Text("někde se stala chyba"));
              } else {
                return const Center(child: Text("protokol hovorů je prázdný"));
              }
            }));
  }

  Future<List<CallLogEntry>> getEntries() async {
    /* var now = DateTime.now();
    int from = now.subtract(const Duration(days: 60)).millisecondsSinceEpoch;
    int to = now.subtract(const Duration(days: 30)).millisecondsSinceEpoch;
    Iterable<CallLogEntry> entries = await CallLog.query(
      dateFrom: from,
      dateTo: to,
      durationFrom: 0,
      durationTo: 60,
      name: 'John Doe',
      number: '901700000',
      type: CallType.incoming,
    ); */

    List<CallLogEntry> entries = [];
    //entries = await CallLog.get();
    entries.add(CallLogEntry(
        name: "test",
        number: "123456789",
        duration: 56,
        callType: CallType.incoming));
    entries.add(CallLogEntry(
        name: "test 1",
        number: "987654321",
        duration: 142,
        callType: CallType.outgoing));
    entries.add(CallLogEntry(
        name: "test 2",
        number: "771301042",
        duration: 9,
        callType: CallType.incoming));
    return entries;
  }
}
