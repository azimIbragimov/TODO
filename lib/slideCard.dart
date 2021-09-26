import 'package:flutter/material.dart';
import 'package:todo/pageNotification.dart';
import 'constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class SlideCard extends StatelessWidget {
  String name = "Personal";
  int tasksRemaining = 9;
  IconData icon;
  Color color = Color(0xFFE8816D);
  Function onTap;

  SlideCard(
      {this.name, this.tasksRemaining, this.icon, this.color, this.onTap});
  List savedNotifications = [];

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 250,
        color: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(
                icon,
                color: color,
                size: 30,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10),
                  Text("$name", style: kcardLabel),
                  SizedBox(height: 10),
                  Text(
                    "Tap to view more",
                    style: kCardTaskNumber.copyWith(fontSize: 15),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
