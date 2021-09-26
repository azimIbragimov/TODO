import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:todo/constants.dart';
import 'package:todo/pageNotification.dart';
import 'package:todo/profile.dart';
import 'package:todo/registerPage.dart';
import 'package:todo/sharedscreen.dart';
import 'welcomeInformation.dart';
import 'myDrawer.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'constants.dart';
import 'slideCard.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:no_context_navigation/no_context_navigation.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MyHomePage extends StatefulWidget {
  static String id = '/mainPage';
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

void rebuildAllChildren(BuildContext context) {
  void rebuild(Element el) {
    el.markNeedsBuild();
    el.visitChildren(rebuild);
  }

  (context as Element).visitChildren(rebuild);
}

class _MyHomePageState extends State<MyHomePage> {
  final user = FirebaseAuth.instance.currentUser;

  List savedNotifications = [];
  int tasksPersonal;
  int tasksStudy;
  int tasksHouseHold;
  int tasksOthers;

  void getTasksNumber(String name) async {
    final prefs = await SharedPreferences.getInstance();
    try {
      final rawJson = prefs.getString(name) ?? '';
      Map<String, dynamic> map = jsonDecode(rawJson);
      savedNotifications = map["data"];

      if (name == "Personal") {
        tasksPersonal = savedNotifications.length;
      } else if (name == "Study") {
        tasksStudy = savedNotifications.length;
      } else if (name == "Household") {
        tasksHouseHold = savedNotifications.length;
      } else if (name == "Others") {
        tasksOthers = savedNotifications.length;
      }
    } catch (e) {
      print("This category does not have enough information");
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getInfo();
  }

  void getInfo() async {
    setState(() {
      getTasksNumber("Personal");
      getTasksNumber("Study");
      getTasksNumber("Household");
      getTasksNumber("Others");
    });
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      getTasksNumber("Personal");
      getTasksNumber("Study");
      getTasksNumber("Household");
      getTasksNumber("Others");
    });

    ListView myCardView =
        ListView(scrollDirection: Axis.horizontal, children: <Widget>[
      SlideCard(
        name: "Shared",
        icon: Icons.share,
        tasksRemaining: 0,
        color: Colors.blue[300],
        onTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => SharedScreen()));
        },
      ),
      SizedBox(
        width: 30,
      ),
      SlideCard(
          name: "Personal",
          tasksRemaining: tasksPersonal,
          icon: FontAwesomeIcons.footballBall,
          color: Color(0xFFE8816D),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        PageNotification(category: "Personal")));
          }),
      SizedBox(width: 30),
      SlideCard(
        name: "Study",
        tasksRemaining: tasksStudy,
        icon: FontAwesomeIcons.book,
        color: Color(0xFFE8816D),
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => PageNotification(category: "Study")));
        },
      ),
      SizedBox(width: 30),
      SlideCard(
        name: "Chores",
        tasksRemaining: tasksHouseHold,
        icon: FontAwesomeIcons.broom,
        color: Color(0xFFE8816D),
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      PageNotification(category: "Household")));
        },
      ),
      SizedBox(width: 30),
      SlideCard(
        name: "Other",
        tasksRemaining: tasksOthers,
        icon: FontAwesomeIcons.bicycle,
        color: Color(0xFFE8816D),
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => PageNotification(category: "Other")));
        },
      )
    ]);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFE8816D),
        centerTitle: true,
        elevation: 0,
        title: Text("TODO"),
      ),
      body: Container(
        padding: EdgeInsets.all(35),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
                child: WelcomeInformation(
                  numberTasks: 3,
                  user: user.displayName == null
                      ? RegisterPage.userName
                      : user.displayName,
                ),
                flex: 1),
            Expanded(child: myCardView, flex: 1)
          ],
        ),
        color: Color(0xFFE8816D),
      ),
    );
  }
}
