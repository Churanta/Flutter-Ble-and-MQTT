import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:heat_pump/models/userModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProvider with ChangeNotifier {
  CusUser user = CusUser();
  Future<void> updateUid(CusUser user) async {
    final prefs = await SharedPreferences.getInstance();
    this.user = user;

    await prefs.setString("user", jsonEncode(user.toJson()));
    notifyListeners();
    return;
  }

  Future<void> loadAuthLocal() async {
    final prefs = await SharedPreferences.getInstance();
    user = CusUser.fromJson(jsonDecode(prefs.getString("user") ?? "{}"));
    notifyListeners();
    return;
  }

  Future<void> deleteUser() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('user');
    user = CusUser();
  }
}
