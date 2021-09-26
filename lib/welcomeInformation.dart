import 'constants.dart';
import 'package:flutter/material.dart';

class WelcomeInformation extends StatelessWidget {
  int numberTasks = 3;
  String user = "User";

  WelcomeInformation({this.numberTasks, this.user});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(Icons.account_circle, color: kTextColor, size: 60),
        SizedBox(height: 35),
        Text("Hello, $user!",
            style: TextStyle(
                fontSize: 40, color: kTextColor, fontWeight: FontWeight.bold)),
        SizedBox(height: 10),
        Text("It is a good day today",
            style: TextStyle(
                fontSize: 18, color: kTextColor, fontWeight: FontWeight.w200)),
        SizedBox(height: 5),
        Text("And you have several tasks today",
            style: TextStyle(
                fontSize: 18, color: kTextColor, fontWeight: FontWeight.w200)),
      ],
    );
  }
}
