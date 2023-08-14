import 'package:cinema_booking_ui_flutter/presentation/views/home_view.dart';
import 'package:flutter/material.dart';

import 'package:cinema_booking_ui_flutter/config/constant.dart';
import 'package:cinema_booking_ui_flutter/presentation/widgets/custom_bottom_navgation.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentPage = 0;
  final List<Widget> body = const [
    HomeView(),
    Center(child: Text("compas", style: TextStyle(color: white))),
    Center(child: Text("tick", style: TextStyle(color: white))),
    Center(child: Text("person", style: TextStyle(color: white))),
  ];

  void handlePressed(index) {
    setState(() {
      currentPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: black,
      body: body[currentPage],
      bottomNavigationBar: CustomBottomNavigation(
          currentPage: currentPage, onPressed: handlePressed),
    );
  }
}
