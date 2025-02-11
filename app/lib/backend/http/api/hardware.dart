import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:friend_private/backend/http/shared.dart';
import 'package:friend_private/env/env.dart';

Future<void> saveFcmTokenServer(
    {required String token, required String timeZone}) async {
  var response = await makeApiCall(
    url: '${Env.apiBaseUrl}v1/firmware/battery-alert',
    headers: {'Content-Type': 'application/json'},
    method: 'POST',
    body: jsonEncode({'fcm_token': token, 'time_zone': timeZone}),
  );

  debugPrint('saveToken: ${response?.body}');
  if (response?.statusCode == 200) {
    debugPrint("Token saved successfully");
  } else {
    debugPrint("Failed to save token");
  }
}

Future<void> low_battery_noti(
    {required String uid, required int batteryLevel}) async {
  var response = await makeApiCall(
    url: '${Env.apiBaseUrl}/v1/firmware/battery-alert',
    headers: {'Content-Type': 'application/json'},
    method: 'GET',
    queryParameters: {
      'battery_percentage': batteryLevel.toString(),
      'uid': uid,
    },
  );
}
