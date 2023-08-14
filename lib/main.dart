import 'package:cinema_booking_ui_flutter/config/constant.dart';
import 'package:flutter/material.dart';

import 'package:cinema_booking_ui_flutter/presentation/screen/home_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: white),
      home: const HomeScreen(),
    );
  }
}
