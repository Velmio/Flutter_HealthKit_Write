import 'dart:async';

import 'package:flutter/services.dart';

class FlutterHkWrite {
  static const MethodChannel _channel =
      const MethodChannel('flutter_hk_write');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  static Future<bool> get requestWritePermissions async {
    final bool permission = await _channel.invokeMethod('requestWritePermissions');
    return permission;
  }

  static Future<bool> writeSleepEntry(int from, int to) async {
    final bool permission = await _channel.invokeMethod('writeSleepEntry', {
      'from': from,
      'to' : to
    });
    return permission;
  } 

  static Future<bool> writeQuantityEntries(List<Map> entries) async {
    final bool permission = await _channel.invokeMethod('writeQuantityEntries', {
      'entries': entries
    });
    return permission;
  } 
}
