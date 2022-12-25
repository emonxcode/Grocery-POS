import 'package:flutter/material.dart';
import 'package:grocery_pos/views/desktop/navigations/navigations.dart';
import 'package:grocery_pos/views/mobile/navigations_mobile/navigation_mobile.dart';
import 'package:grocery_pos/views/mobile/splash_screen/splash_screen.dart';
import 'package:provider/provider.dart';

import 'controller/productController.dart';
import 'dart:io';
import 'package:flutter/foundation.dart';

void main() {
  runApp(ChangeNotifierProvider(
      create: (context) => ProductController(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: !kIsWeb ? SplashScreen() : NavigationsDesktop(),
      )));
}
