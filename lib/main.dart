import 'package:fitbasix/View/HomeScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer_pro/sizer.dart';

void main() {
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return const GetMaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomeScreen(),
      );
    });
  }
}
