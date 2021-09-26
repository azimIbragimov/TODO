import 'package:flutter/material.dart';

class Group1Widget extends StatefulWidget {
  static String id = "/demo";
  @override
  _Group1WidgetState createState() => _Group1WidgetState();
}

class _Group1WidgetState extends State<Group1Widget> {
  @override
  Widget build(BuildContext context) {
    // Figma Flutter Generator Group1Widget - GROUP

    return Container(
        width: 375,
        height: 812,
        child: Stack(children: <Widget>[
          Positioned(
              top: 0,
              left: 0,
              child: Container(
                  width: 375,
                  height: 812,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/images/Img_01761.png'),
                        fit: BoxFit.fitWidth),
                  ))),
          Positioned(
              top: 0,
              left: 0,
              child: Container(
                  width: 375,
                  height: 812,
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(175, 141, 101, 0.5400000214576721),
                  ))),
          Positioned(
              top: 464,
              left: 19,
              child: Container(
                  width: 261,
                  height: 327,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(9),
                      topRight: Radius.circular(9),
                      bottomLeft: Radius.circular(9),
                      bottomRight: Radius.circular(9),
                    ),
                    color: Color.fromRGBO(255, 150, 97, 1),
                  ))),
          Positioned(
              top: 464,
              left: 310,
              child: Container(
                  width: 40,
                  height: 327,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(5),
                      topRight: Radius.circular(5),
                      bottomLeft: Radius.circular(5),
                      bottomRight: Radius.circular(5),
                    ),
                    color: Color.fromRGBO(255, 150, 97, 1),
                  ))),
          Positioned(top: 331, left: 16, child: null),
          Positioned(top: 323, left: 60, child: null),
          Positioned(
              top: 279,
              left: 258,
              child: Container(
                  width: 100,
                  height: 101,
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(255, 150, 97, 1),
                    borderRadius: BorderRadius.all(Radius.elliptical(100, 101)),
                  ))),
          Positioned(top: 298, left: 277, child: null),
          Positioned(top: 330, left: 284, child: null),
          Positioned(top: 302, left: 297, child: null),
        ]));
  }
}
