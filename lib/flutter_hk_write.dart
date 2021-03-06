import 'dart:async';

import 'package:flutter/services.dart';

class FlutterHkWrite {
  static const MethodChannel _channel = const MethodChannel('flutter_hk_write');

  static Future<bool> get requestWritePermissions async {
    final bool permission =
        await _channel.invokeMethod('requestWritePermissions');
    return permission;
  }

  static Future<bool> requestReadWritePermissionsForTypes(
      List<String> types) async {
    final bool permission = await _channel
        .invokeMethod('requestReadWritePermissionsForTypes', {'types': types});
    return permission;
  }

  static Future<bool> writeSleepEntry(int from, int to) async {
    final bool permission = await _channel
        .invokeMethod('writeSleepEntry', {'from': from, 'to': to});
    return permission;
  }

  static Future<bool> writeQuantityEntries(List<Map> entries) async {
    final bool permission = await _channel
        .invokeMethod('writeQuantityEntries', {'entries': entries});
    return permission;
  }

  static Future<bool> deleteObjectForType(String type, String id) async {
    final bool deletionStatus = await _channel
        .invokeMethod('deleteObjectForType', {'typeKey': type, 'id': id});
    return deletionStatus;
  }
}
