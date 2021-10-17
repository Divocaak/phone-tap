import 'package:flutter/material.dart';
import 'package:phone_tap/objects/user.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);
  static const String routeName = "homePage";

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  User loggedUser;

  @override
  Widget build(BuildContext context) {
    loggedUser = ModalRoute.of(context).settings.arguments;

    return Scaffold(body: Center(child: Text(loggedUser.username)));
  }
}
