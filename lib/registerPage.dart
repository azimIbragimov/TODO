import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:todo/firstScreen.dart';
import 'package:todo/myhomepage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class RegisterPage extends StatefulWidget {
  static String id = '/registerPage';
  static String userName;

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<RegisterPage> {
  final String firstName = "";
  final String lastName = "";
  final TextEditingController _controllerFirstName = TextEditingController();
  final TextEditingController _controllerLastName = TextEditingController();
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();

  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Material(
        type: MaterialType.transparency,
        child: Stack(
          children: [
            ColorFiltered(
                colorFilter: ColorFilter.mode(
                    Colors.black54.withOpacity(0.0), BlendMode.darken),
                child: Container(
                  decoration: BoxDecoration(color: Color(0xFFE8816D)),
                )),
            Stack(children: [
              Container(
                color: Colors.black54,
                margin: EdgeInsets.symmetric(horizontal: 40, vertical: 120),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      "Register",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.w800,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      "Enter your first name",
                      style: TextStyle(color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 50),
                      child: TextField(
                        controller: _controllerFirstName,
                        decoration: InputDecoration(
                          fillColor: Colors.white,
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                        ),
                        cursorColor: Colors.white,
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      "Enter your last name",
                      style: TextStyle(color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 50),
                      child: TextField(
                        controller: _controllerLastName,
                        decoration: InputDecoration(
                          fillColor: Colors.white,
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                        ),
                        cursorColor: Colors.white,
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      "Enter your email",
                      style: TextStyle(color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 50),
                      child: TextField(
                        controller: _controllerEmail,
                        decoration: InputDecoration(
                          fillColor: Colors.white,
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                        ),
                        cursorColor: Colors.white,
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      "Enter your Password",
                      style: TextStyle(color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 50),
                      child: TextField(
                        obscureText: true,
                        controller: _controllerPassword,
                        decoration: InputDecoration(
                          fillColor: Colors.white,
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                        ),
                        cursorColor: Colors.white,
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    CurvyButton(
                      colorButton: Colors.green[800],
                      colorText: Colors.white,
                      text: "Register",
                      onTap: () async {
                        print("First name: " + _controllerFirstName.text);
                        print("Last Name: " + _controllerLastName.text);
                        print("Email: " + _controllerEmail.text);
                        print("Password: " + _controllerPassword.text);

                        try {
                          final newUser =
                              await _auth.createUserWithEmailAndPassword(
                                  email: _controllerEmail.text,
                                  password: _controllerPassword.text);

                          if (newUser != null) {
                            FirebaseAuth.instance.currentUser
                                .updateDisplayName(_controllerFirstName.text);

                            Future.delayed(Duration.zero, () {
                              Navigator.pushNamed(context, MyHomePage.id)
                                  .then((value) {
                                setState(() {
                                  RegisterPage.userName = FirebaseAuth
                                      .instance.currentUser.displayName;
                                });
                              });
                            });
                          }
                        } on Exception catch (e) {
                          print(e);
                        }
                      },
                    ),
                    SizedBox(
                      height: 30,
                    )
                  ],
                ),
              ),
            ])
          ],
        ),
      ),
    );
  }
}
