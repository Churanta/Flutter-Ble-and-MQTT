import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:heat_pump/models/userModel.dart';
import 'package:heat_pump/providers/authProvider.dart';
import 'package:provider/provider.dart';

Future<bool> login(String email, String password, BuildContext context) async {
  try {
    var response = await http.post(
        Uri.parse("https://api.thinkfinitylabs.com/user_details"),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({"email": email, "password": password}));

    if (response.statusCode == 200) {
      await context
          .read<UserProvider>()
          .updateUid(CusUser.fromJson(jsonDecode(response.body)[0]));
      return true;
    }
  } catch (e) {
    print(e);
  }
  Fluttertoast.showToast(msg: "Something went wrong try again!!");
  return false;
}

// password

Future<bool> password(String old_password, String new_password,
    String confirm_password, BuildContext context) async {
  try {
    var response = await http.post(
        Uri.parse("https://api.thinkfinitylabs.com/update_password"),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "email": context.read<UserProvider>().user.uemail,
          "old_pass": old_password,
          "new_pass": new_password,
          "conform_pass": confirm_password
        }));

    if (response.statusCode == 200) {
      if (jsonDecode(response.body)["status"] == 1) {
        Fluttertoast.showToast(msg: "Successfully updated password");
        return true;
      }
    }
  } catch (e) {
    print(e);
  }
  Fluttertoast.showToast(msg: "Something went wrong try again!!");
  return false;
}

// otplogin

Future<bool> verify_otp(
    String email, String otp, String pwd, BuildContext context) async {
  // print(email);
  try {
    var response = await http.post(
        Uri.parse("https://api.thinkfinitylabs.com/verify_otp"),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({"email": email, "otp": otp, "new_pass": pwd}));

    if (response.statusCode == 200) {
      if (jsonDecode(response.body)["status"] == 1) {
        Fluttertoast.showToast(msg: "Successfully updated password");
        return true;
      }
    }
  } catch (e) {
    print(e);
  }
  Fluttertoast.showToast(msg: "Something went wrong try again!!");
  return false;
}
