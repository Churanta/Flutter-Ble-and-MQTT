import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:heat_pump/models/deviceModel.dart';
import 'package:http/http.dart' as http;
import 'package:heat_pump/providers/authProvider.dart';
import 'package:provider/provider.dart';

Future<bool> sendDevTemp(String dTmp, String temp, String devId) async {
  try {
    var response = await http.post(
        Uri.parse("http://api.thinkfinitylabs.com:5000/api/device_info.php"),
        headers: {
          'Content-Type': 'application/json',
          'Cookie':
              'session=eyJ1aWQiOiI4RzlMOTE5VFRZRlBQQTM5In0.Y9_foA.YPzLzgchuBg2d228HchIDg6D37o'
        },
        body: jsonEncode({"dTemp": dTmp, "temp": temp, "deviceid": devId}));
    // context.read<UserProvider>().user.uid

    print(response.body);

    if (response.statusCode == 200) {
      return true;
    }
  } catch (e) {
    print(e);
  }
  Fluttertoast.showToast(msg: "Something went wrong try again!!");
  return false;
}
