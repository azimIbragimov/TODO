import 'package:flutter/material.dart';
import 'myDrawer.dart';
import 'constants.dart';
import 'package:path_provider/path_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:async';
import 'dart:io';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  XFile _image;

  _imgFromCamera() async {
    XFile image = await ImagePicker()
        .pickImage(source: ImageSource.camera, imageQuality: 50);

    dynamic appDocDir = await getApplicationDocumentsDirectory();
    String path = appDocDir.path;
    await image.saveTo('$path/assets/images/profilePic.png');

    setState(() {
      _image = image;
    });
  }

  _imgFromGallery() async {
    XFile image = await ImagePicker()
        .pickImage(source: ImageSource.gallery, imageQuality: 50);

    dynamic appDocDir = await getApplicationDocumentsDirectory();
    String path = appDocDir.path;
    await image.saveTo('$path/assets/profilePic.png');

    setState(() {
      _image = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        drawer: myDrawer,
        appBar: AppBar(
          backgroundColor: Color(0xFFE8816D),
          centerTitle: true,
          elevation: 0,
          title: Text("TODO"),
        ),
        body: Container(
          child: Padding(
              padding: const EdgeInsets.all(25.0),
              child: Column(
                children: [
                  Expanded(
                    flex: 9,
                    child: Column(
                      children: [
                        Column(
                          children: [
                            Row(
                              children: [
                                // Expanded(
                                //   child: Image(
                                //       image:
                                //           AssetImage('images/profilePic.png')),
                                // )
                              ],
                            ),
                            // name information
                            Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: TextField(
                                    decoration: InputDecoration(
                                        border: OutlineInputBorder(),
                                        hintText: 'Enter your first name here'),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 25,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: TextField(
                                    decoration: InputDecoration(
                                        border: OutlineInputBorder(),
                                        hintText: 'Enter your last name here'),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 40),
                            ElevatedButton(
                              onPressed: () {
                                _imgFromGallery();
                              },
                              child:
                                  Text("Upload a profile picture from gallery"),
                              style: ElevatedButton.styleFrom(
                                primary: Color(0xFFE8816D),
                              ),
                            ),
                            SizedBox(height: 35),
                            ElevatedButton(
                              onPressed: () {
                                _imgFromCamera();
                              },
                              child:
                                  Text("Upload a profile picture from camera"),
                              style: ElevatedButton.styleFrom(
                                primary: Color(0xFFE8816D),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Text(
                          "Save information and go back to the main screen"),
                      style: ElevatedButton.styleFrom(
                        primary: Color(0xFFE8816D),
                      ),
                    ),
                  )
                ],
              )),
        ),
      ),
    );
  }
}
