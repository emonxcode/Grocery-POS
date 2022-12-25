import 'dart:async';

import 'package:flutter/material.dart';
import 'package:grocery_pos/views/mobile/navigations_mobile/navigation_mobile.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void initState() {
    super.initState();
    Timer(
      Duration(seconds: 2),
      () => Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => NavigationsMobile(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        color: Color.fromARGB(255, 16, 15, 19),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("GroceryPOS",
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white)),
                    SizedBox(height: 8),
            Text("A total pos solution", style: TextStyle(color: Colors.white)),
          ],
        ),
      ),
    );
  }
}
