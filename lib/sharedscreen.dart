import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:todo/main.dart';
import 'myDrawer.dart';
import 'noteModel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SharedScreen extends StatefulWidget {
  @override
  _SharedScreenState createState() => _SharedScreenState();
}

class _SharedScreenState extends State<SharedScreen> {
  int value = 0;

  final _firestore = FirebaseFirestore.instance;
  final user = FirebaseAuth.instance.currentUser;
  TextEditingController _textFieldController;
  String valueText;
  String codeDialog;
  List savedNotifications = [];
  String subcategory;
  Note note;

  @override
  void initState() {
    setState(() {
      super.initState();
      anyncMethod();
    });
  }

  void rebuildAllChildren(BuildContext context) {
    void rebuild(Element el) {
      el.markNeedsBuild();
      el.visitChildren(rebuild);
    }

    (context as Element).visitChildren(rebuild);
  }

  void anyncMethod() async {
    // Getting shared prefernces back

    setState(() async {
      // final prefs = await SharedPreferences.getInstance();

      // try {
      //   final rawJson = prefs.getString(widget.category) ?? '';
      //   Map<String, dynamic> map = jsonDecode(rawJson);
      //   savedNotifications = map["data"];
      //   value = savedNotifications.length;
      //   print("This list has $value components");
      //   print(savedNotifications.toString());
      // } catch (e) {
      //   print("Currently no data");
      // }

      setState(() {
        _textFieldController = new TextEditingController();
      });
    });
  }

  void _getMessages() async {
    final messages = await _firestore.collection("messages").get();
    for (var message in messages.docs) {
      print(message.data());
    }
  }

  void messageStream() async {
    await for (var snapshot in _firestore.collection("messages").snapshots()) {
      snapshot.docs;
    }
  }

  @override
  Widget build(BuildContext context) {
    rebuildAllChildren(context);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () async {
            Navigator.of(context).pop();
          },
        ),
        backgroundColor: Colors.blue[300],
        centerTitle: true,
        elevation: 0,
        title: Text("TODO"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _displayTextInputDialog(context);
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.blue[300],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 30),
        child: Container(
          child: Column(children: [
            SizedBox(
              height: 20,
            ),
            Expanded(
                flex: 20,
                child: StreamBuilder<QuerySnapshot>(
                  stream: _firestore.collection("messages").snapshots(),
                  // ignore: missing_return
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final messages = snapshot.data.docs;

                      List<Widget> messagesWidgets = [];
                      for (var message in messages) {
                        final messageText = message.get("text");
                        final messageSender = message.get("sender");
                        final messageWidget = Padding(
                            padding: EdgeInsets.symmetric(vertical: 5),
                            child: InkWell(
                              onLongPress: () {
                                setState(() {
                                  print("DoubleTap acticated");
                                  _showMyDialog(message);
                                });
                              },
                              onTap: () {
                                print("Hello0");
                                if (message.get("status") == true) {
                                  _firestore
                                      .collection("messages")
                                      .doc(message.id)
                                      .update({"status": false});
                                } else {
                                  _firestore
                                      .collection("messages")
                                      .doc(message.id)
                                      .update({"status": true});
                                }
                              },
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: Text(
                                        message.get("sender"),
                                        textAlign: TextAlign.start,
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.all(10),
                                      margin: EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)),
                                          color: Colors.grey[200]),
                                      child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.stretch,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Row(children: [
                                              message.get("status") == true
                                                  ? Icon(
                                                      Icons.check_circle,
                                                      color: Colors.white,
                                                    )
                                                  : Icon(
                                                      Icons
                                                          .check_box_outline_blank_outlined,
                                                      color: Colors.white,
                                                    ),
                                              SizedBox(width: 20),
                                              Text(message.get("text"),
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      color: Colors.grey[600])),
                                              SizedBox(height: 40)
                                            ]),
                                          ]),
                                    ),
                                  ]),
                            ));
                        messagesWidgets.add(messageWidget);
                      }
                      return Column(children: messagesWidgets);
                    }
                  },
                )

                //ListView.builder(
                //     itemCount: value,
                //     itemBuilder: (context, index) => this._buildRow(index)),
                ),
          ]),
        ),
      ),
    );
  }

  Future<void> _displayTextInputDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              title: Text('Add a note'),
              content: TextField(
                onChanged: (valueLocal) {
                  setState(() {
                    valueText = valueLocal;
                  });
                },
                controller: _textFieldController,
                decoration: InputDecoration(hintText: "Note goes here"),
              ),
              actions: <Widget>[
                FlatButton(
                  color: Colors.green,
                  textColor: Colors.white,
                  child: Text('Add'),
                  onPressed: () {
                    setState(() async {
                      codeDialog = valueText;
                      Navigator.pop(context);
                      // _addItem();
                      // savedNotifications.add([valueText, false]);

                      // savedNotifications.toString();

                      // // converting to shared preference
                      // Map<String, dynamic> map = {'data': savedNotifications};
                      // String rawJson = jsonEncode(map);
                      // final prefs = await SharedPreferences.getInstance();
                      // // prefs.setString(widget.category, rawJson);

                      _firestore.collection("messages").add({
                        "text": valueText,
                        "sender": user.displayName,
                        "status": false
                      });
                    });
                    valueText = "";
                    _textFieldController.clear();
                  },
                ),
              ]);
        });
  }

  _addItem() {
    setState(() {
      value = value + 1;
    });
  }

  _buildRow(int index) {
    Icon theIcon;

    Icon findStatus(bool status) {
      if (status == true) {
        theIcon = Icon(FontAwesomeIcons.checkCircle);
      } else {
        theIcon = Icon(FontAwesomeIcons.circle);
      }
      return theIcon;
    }

    return GestureDetector(
      onTap: () async {
        setState(() {
          if (savedNotifications[index][1] == false) {
            savedNotifications[index][1] = true;
          } else {
            savedNotifications[index][1] = false;
          }
        });

        // converting to shared preference
        Map<String, dynamic> map = {'data': savedNotifications};
        String rawJson = jsonEncode(map);
        final prefs = await SharedPreferences.getInstance();
        // prefs.setString(widget.category, rawJson);
      },
      onLongPress: () {
        setState(() {
          print("DoubleTap acticated");
        });
      },
      child: Container(
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.all(5),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            color: Colors.grey[200]),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(children: [
                findStatus(savedNotifications[index][1]),
                SizedBox(width: 20),
                Text(savedNotifications[index][0].toString(),
                    style: TextStyle(fontSize: 20, color: Colors.grey[600])),
                SizedBox(height: 40)
              ]),
            ]),
      ),
    );
  }

  Future<void> _showMyDialog(QueryDocumentSnapshot<Object> message) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Item removal'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text(
                    'Are you sure you want to remove this item from the list?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Confirm'),
              onPressed: () async {
                _firestore.collection("messages").doc(message.id).delete();

                // converting to shared preference
                Map<String, dynamic> map = {'data': savedNotifications};
                String rawJson = jsonEncode(map);
                final prefs = await SharedPreferences.getInstance();
                // prefs.setString(widget.category, rawJson);

                print("Saved");

                Navigator.of(context).pop();
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => super.widget));
              },
            ),
          ],
        );
      },
    );
  }
}
