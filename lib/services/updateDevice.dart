import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../providers/authProvider.dart';

Future<bool> updateDevice(BuildContext context, double dt, double temp,
    String devId, bool dstate) async {
  try {
    var response = await http.post(
        Uri.parse("https://api.thinkfinitylabs.com/device_update"),
        headers: {'Content-Type': 'application/json'},
        // send data here
        body: jsonEncode({
          "email": context.read<UserProvider>().user.uemail,
          "uid": context.read<UserProvider>().user.uid,
          "deviceid": devId,
          "dstate": dstate ? 1 : 0,
          "dt": dt,
          "temp": temp,
          "delay_time": 5,
          "address": "yelehanka near reava",
          "city": "Bangalore",
          "state": "karnataka",
          "pincode": "560064"
        }));

    if (response.statusCode == 200) {
      if (jsonDecode(response.body)["status"] == 1) return true;
    }
  } catch (e) {
    print(e);
  }
  Fluttertoast.showToast(msg: "Something went wrong try again!!");
  return false;
}

Future<bool> updateName(
    BuildContext context, String devId, String devName) async {
  try {
    var response = await http.post(
        Uri.parse("https://api.thinkfinitylabs.com/change_name"),
        headers: {'Content-Type': 'application/json'},
        // send data here
        body: jsonEncode({
          "email": context.read<UserProvider>().user.uemail,
          "uid": context.read<UserProvider>().user.uid,
          "deviceid": devId,
          "new_name": devName
        }));

    if (response.statusCode == 200) {
      if (jsonDecode(response.body)["status"] == 1) return true;
    }
  } catch (e) {
    print(e);
  }
  Fluttertoast.showToast(msg: "Something went wrong try again!!");
  return false;
}
