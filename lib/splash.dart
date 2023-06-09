import 'dart:async';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:heat_pump/providers/authProvider.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    context.read<UserProvider>().loadAuthLocal();

    Timer(const Duration(seconds: 3), () {
      // print(context.read<UserProvider>().user.uid);
      if (context.read<UserProvider>().user.uid != null)
        Navigator.pushReplacementNamed(context, 'mainpage');
      else {
        Navigator.pushReplacementNamed(context, 'login');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Set background color to black
      body: Center(
        child: Lottie.asset(
          'assets/splash_animation.json',
          height: 300, // Set height as needed
          width: 300, // Set width as needed
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}

class Logo extends StatefulWidget {
  @override
  _LogoState createState() => _LogoState();
}

class _LogoState extends State<Logo> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 1), () {
      // After 3 seconds, navigate to the home screen.
      Navigator.pushReplacementNamed(context, 'splash');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Set background color to black
      body: Center(
        child: Container(
          width: 200, // Set width to 200
          height: 200, // Set height to 200
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/p3.png'),
              fit: BoxFit.contain,
              colorFilter: ColorFilter.mode(
                Colors.grey.withOpacity(0.5), // Apply opacity to the image
                BlendMode.darken, // Blend mode to darken the image
              ),
            ),
            // Add a shadow effect to the container
            // You can adjust the shadow properties as needed
            // For example, change the spreadRadius, blurRadius, and offset values
            // to achieve the desired shadow effect
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 10,
                offset: Offset(0, 3),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
