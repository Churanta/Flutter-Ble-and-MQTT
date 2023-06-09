import 'package:flutter/material.dart';
import 'package:heat_pump/Dashboard.dart';
import 'package:heat_pump/MainPage.dart';
import 'package:heat_pump/about_user.dart';
import 'package:heat_pump/contact_us.dart';
import 'package:heat_pump/email.dart';
import 'package:heat_pump/login.dart';
import 'package:heat_pump/providers/authProvider.dart';
import 'package:heat_pump/splash.dart';
import 'package:heat_pump/verify.dart';
import 'package:heat_pump/password.dart';
import 'package:heat_pump/wifi_page.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => UserProvider())],
      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: 'logo',
      // home: const SplashScreen(),
      debugShowCheckedModeBanner: false,
      routes: {
        'email': (context) => const MyEmail(),
        'verify': (context) => const MyVerify(),
        'password': (context) => const MyPassword(),
        'login': (context) => const MyLogin(),
        'splash': (context) => const SplashScreen(),
        'mainpage': (context) => const MainPage(),
        'wifi': (context) => const UpdateWiFi(),
        'about': (context) => const AboutUser(),
        'contact': (context) => const ContactUs(),
        'dashboard': (context) => const UserProfile(),
        'logo': (context) =>  Logo(),
      },
    );
  }
}
