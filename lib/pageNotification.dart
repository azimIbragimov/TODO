import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:todo/main.dart';
import 'myDrawer.dart';
import 'noteModel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';

class PageNotification extends StatefulWidget {
  final String category;
  const PageNotification({Key key, this.category}) : super(key: key);

  @override
  _PageNotificationState createState() => _PageNotificationState();
}

class _PageNotificationState extends State<PageNotification> {
  int value = 0;

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
      final prefs = await SharedPreferences.getInstance();

      try {
        final rawJson = prefs.getString(widget.category) ?? '';
        Map<String, dynamic> map = jsonDecode(rawJson);
        savedNotifications = map["data"];
        value = savedNotifications.length;
        print("This list has $value components");
        print(savedNotifications.toString());
      } catch (e) {
        print("Currently no data");
      }

      setState(() {
        _textFieldController = new TextEditingController();
      });
    });
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
        backgroundColor: Color(0xFFE8816D),
        centerTitle: true,
        elevation: 0,
        title: Text("TODO"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _displayTextInputDialog(context);
        },
        child: Icon(Icons.add),
        backgroundColor: Color(0xFFE8816D),
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
              child: ListView.builder(
                  itemCount: value,
                  itemBuilder: (context, index) => this._buildRow(index)),
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
                      _addItem();
                      savedNotifications.add([valueText, false]);

                      savedNotifications.toString();
                      valueText = "";
                      _textFieldController.clear();

                      // converting to shared preference
                      Map<String, dynamic> map = {'data': savedNotifications};
                      String rawJson = jsonEncode(map);
                      final prefs = await SharedPreferences.getInstance();
                      prefs.setString(widget.category, rawJson);
                    });
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
        prefs.setString(widget.category, rawJson);
      },
      onLongPress: () {
        setState(() {
          print("DoubleTap acticated");
          _showMyDialog(index);
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

  Future<void> _showMyDialog(int index) async {
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
                setState(() async {
                  savedNotifications.removeAt(index);
                  value -= 1;

                  // converting to shared preference
                  Map<String, dynamic> map = {'data': savedNotifications};
                  String rawJson = jsonEncode(map);
                  final prefs = await SharedPreferences.getInstance();
                  prefs.setString(widget.category, rawJson);

                  print("Saved");

                  Navigator.of(context).pop();
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => super.widget));
                });
              },
            ),
          ],
        );
      },
    );
  }
}
