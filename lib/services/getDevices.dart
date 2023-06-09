import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:heat_pump/models/deviceModel.dart';
import 'package:http/http.dart' as http;
import 'package:heat_pump/providers/authProvider.dart';
import 'package:provider/provider.dart';

Future<List<DeviceModel>> getDevices(BuildContext context) async {
  try {
    var response = await http.post(
        Uri.parse("https://api.thinkfinitylabs.com/device_list"),
        headers: {
          'Content-Type': 'application/json',
          'Cookie':
              'session=eyJ1aWQiOiI4RzlMOTE5VFRZRlBQQTM5In0.Y9_foA.YPzLzgchuBg2d228HchIDg6D37o'
        },
        body: jsonEncode({
          "uid": context.read<UserProvider>().user.uid,
          "email": context.read<UserProvider>().user.uemail
        }));
    // context.read<UserProvider>().user.uid

    // print(jsonDecode(response.body.toString())["Total_devices"]);

    if (response.statusCode == 200) {
      List<DeviceModel> devs = [];
      var devData = jsonDecode(response.body.toString());

      for (var i = 1; i <= devData["Total_devices"]; i++) {
        // print(devData[i.toString()]);
        devs.add(DeviceModel.fromJson(devData[i.toString()]));
      }

      return devs;
    }
  } catch (e) {
    print(e);
  }
  Fluttertoast.showToast(msg: "Something went wrong try again!!");
  return [];
}
