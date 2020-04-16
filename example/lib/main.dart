import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_hk_write/flutter_hk_write.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';

  @override
  void initState() {
    super.initState();
    FlutterHkWrite.requestWritePermissions.then((status){
      if (status) {
        writeQuantityEntry();
      }
    });   
  }

  // Platform messages are asynchronous, so we initialize in an async method.

  Future<bool> writeSleepEntry() async {
    bool writingStatus = await FlutterHkWrite.writeSleepEntry(1580630400, 1580644800);
    return writingStatus;
  }

  Future<bool> writeQuantityEntry() async {
    bool writingStatus = await FlutterHkWrite.writeQuantityEntries([
      {
        "value" : 3.0,
        "from": 1580630400,
        "to" : 1580644800,
        "type" : "Water",
        "unit": "liter"
      }
    ]);
    return writingStatus;
  }

  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      platformVersion = await FlutterHkWrite.platformVersion;
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Text('Running on: $_platformVersion\n'),
        ),
      ),
    );
  }
}
