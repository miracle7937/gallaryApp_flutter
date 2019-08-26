import 'dart:async';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_ui/wallpapers/wallscreen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: WallScreen(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String myText = '';

  final DocumentReference documentReference =
      Firestore.instance.collection('user').document('myuser');

  StreamSubscription<DocumentSnapshot> subscription;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              height: 34,
              width: double.infinity,
              child: RaisedButton(
                child: Text('Add'),
                onPressed: add,
                color: Colors.lightBlue,
              ),
            ),
            Container(
              height: 34,
              width: double.infinity,
              child: RaisedButton(
                child: Text('Updata'),
                onPressed: updata,
                color: Colors.lightBlue,
              ),
            ),
            Container(
              height: 34,
              width: double.infinity,
              child: RaisedButton(
                child: Text('Delete'),
                onPressed: delete,
                color: Colors.lightBlue,
              ),
            ),
            Container(
              height: 34,
              width: double.infinity,
              child: RaisedButton(
                child: Text('Fetch'),
                onPressed: fetch,
                color: Colors.lightBlue,
              ),
            ),
            Text(
              myText,
              style: TextStyle(fontSize: 34),
            )
          ],
        ),
      ),
    );
  }

  void add() {
    Map<String, String> user = {
      'name': 'chukwude Miracle',
      'description': 'I am a flutter developer'
    };
    documentReference.setData(user).whenComplete(() {
      print('it completed');
    }).catchError((e) => print(e));
  }

  void updata() {
    Map<String, String> user = {
      'name': 'emanuel chinonso',
      'description': 'A business man'
    };
    documentReference.updateData(user).whenComplete(() {
      print('it completed');
    }).catchError((e) => print(e));
  }

  void delete() {
    documentReference.delete();
  }

  void fetch() {
    documentReference.get().then((snapShot) {
      if (snapShot.exists) {
        setState(() {
          myText = snapShot.data['name'];
        });
      } else {
        setState(() {
          myText = '';
        });
      }
    }).whenComplete(() {
      print('data fetched');
    }).catchError((e) => print(e));
  }

  @override
  void initState() {
    subscription = documentReference.snapshots().listen((snapShot) {
      documentReference.get().then((snapShot) {
        if (snapShot.exists) {
          setState(() {
            myText = snapShot.data['name'];
          });
        } else {
          setState(() {
            myText = '';
          });
        }
      }).whenComplete(() {
        print('data fetched');
      }).catchError((e) => print(e));
    });
    super.initState();
  }
}
