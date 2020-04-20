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
 
  bool _successState;

  @override
  void initState() {
    super.initState();
    FlutterHkWrite.requestWritePermissions.then((status) {
      if (status) {
        writeQuantityEntry().then((success) {
          setState(() {
            _successState = success;
          });
        });
      }
    });
  }

  // Platform messages are asynchronous, so we initialize in an async method.

  Future<bool> writeSleepEntry() async {
    bool writingStatus =
        await FlutterHkWrite.writeSleepEntry(1580630400, 1580644800);
    return writingStatus;
  }

  Future<bool> writeQuantityEntry() async {
    var nutrients = [
      "Fat",
      "Protein",
      "Carbohydrate",
      "Saturated fat",
      "Cholesterol",
      "Fiber",
      "Sugar",
      "Calcium, Ca",
      "Iron, Fe",
      "Potassium, K",
      "Sodium, Na",
      "Vitamin A",
      "Vitamin C",
      "Vitamin D",
      "Body Mass",
      "Folate",
      "Folic acid",
      "Thiamin (Vitamin B1)",
      "Riboflavin (Vitamin B2)",
      "Niacin (Vitamin B3)",
      "Vitamin B6",
      "Vitamin B12",
      "Vitamin E",
      "Zinc, Zn",
      "Retinol (Vitamin A1)",
      "Magnesium, Mg"
    ];

    bool success = true;

    for (var nutrient in nutrients) {
      bool writingStatus = await FlutterHkWrite.writeQuantityEntries([
        {
          "value": 1.0,
          "from": 1580630400,
          "to": 1580644800,
          "type": nutrient,
          "unit": "MG"
        }
      ]);

      if (!writingStatus) {
        print("Error case occured");
        success = false;
        break;
      }
    }

    return success;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('HK Writing Test'),
        ),
        body: Center(
          child: Text('Writing state: $_successState\n'),
        ),
      ),
    );
  }
}
