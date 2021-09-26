import 'dart:io';

import 'package:flutter/material.dart';
import 'constants.dart';
import 'package:path_provider/path_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:no_context_navigation/no_context_navigation.dart';

Drawer myDrawer = Drawer(
  child: ListView(
    padding: EdgeInsets.zero,
    children: <Widget>[
      DrawerHeader(
          decoration: BoxDecoration(
            color: Color(0xFFE8816D),
          ),
          child: Text(
            'Settings',
            style: TextStyle(
                fontSize: 30,
                color: kTextColor,
                fontWeight: FontWeight.w500,
                fontStyle: FontStyle.italic),
            textAlign: TextAlign.center,
          )),
      // ListTile(
      //   title: Text('Edit profile information'),
      //   onTap: () {
      //     navService.pushNamed('/profile');
      //   },
      // ),
      ListTile(
        title: Text('Personal Tasks'),
        onTap: () {},
      ),
      ListTile(
        title: Text('Study Tasks'),
        onTap: () {},
      ),
      ListTile(
        title: Text('Household Tasks'),
        onTap: () {},
      ),
      ListTile(
        title: Text('Other Tasks'),
        onTap: () {},
      ),
    ],
  ),
);
