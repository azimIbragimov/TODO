import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:todo/loginpage.dart';
// import 'package:musicapp/database.dart';
// import 'package:musicapp/google_sign_in_provider.dart';
// import 'package:musicapp/loginpage.dart';
// import 'package:musicapp/musicPage.dart';
// import 'package:musicapp/registerPage.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:provider/provider.dart';
// import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo/myhomepage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:todo/registerPage.dart';

class HomePage extends StatefulWidget {
  static String id = '/homePage';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasData) {
            WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
              Navigator.pushNamed(context, MyHomePage.id);
            });
          }
          return Material(
            type: MaterialType.transparency,
            child: (Stack(
              alignment: Alignment.center,
              children: [
                // This is background image
                ColorFiltered(
                    colorFilter: ColorFilter.mode(
                        Colors.black54.withOpacity(0.0), BlendMode.darken),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color(0xFFE8816D),
                      ),
                    )),
                // This is column for buttons

                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.account_circle_outlined,
                                color: Colors.white,
                                size: 180,
                              ),
                              Column(children: [
                                Text(
                                  "TODO",
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 50,
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                                SizedBox(height: 30),
                              ])
                            ],
                          ),
                        ],
                      ),
                      flex: 2,
                    ),
                    Expanded(
                      flex: 1,
                      child: Column(
                        children: [
                          CurvyButton(
                            colorButton: (Colors.blue[300]),
                            text: "Login",
                            colorText: Colors.white54,
                            onTap: () {
                              Navigator.pushNamed(context, LoginPage.id);
                            },
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          CurvyButton(
                            colorButton: Colors.white60,
                            colorText: Colors.black54,
                            text: "Register",
                            onTap: () {
                              Navigator.pushNamed(context, RegisterPage.id);
                            },
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ],
            )),
          );
        });
  }
}

class CurvyButton extends StatelessWidget {
  Color colorButton;
  String text;
  Color colorText;
  final VoidCallback onTap;

  CurvyButton({this.colorButton, this.text, this.colorText, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          alignment: Alignment.center,
          child: Text(
            text,
            style: TextStyle(
                color: colorText, fontSize: 20, fontWeight: FontWeight.w400),
          ),
          height: 55,
          width: 250,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(50)),
            color: colorButton,
          ),
        ),
      ),
    );
  }
}
