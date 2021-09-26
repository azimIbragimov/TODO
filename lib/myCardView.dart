import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'constants.dart';
import 'slideCard.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

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

ListView myCardView =
    ListView(scrollDirection: Axis.horizontal, children: <Widget>[
  SlideCard(
      name: "Personal",
      tasksRemaining: tasksPersonal,
      icon: FontAwesomeIcons.footballBall),
  SizedBox(width: 30),
  SlideCard(
      name: "Study", tasksRemaining: tasksStudy, icon: FontAwesomeIcons.book),
  SizedBox(width: 30),
  SlideCard(
      name: "Household",
      tasksRemaining: tasksHouseHold,
      icon: FontAwesomeIcons.broom),
  SizedBox(width: 30),
  SlideCard(
      name: "Shared",
      tasksRemaining: tasksOthers,
      icon: FontAwesomeIcons.bicycle)
]);
