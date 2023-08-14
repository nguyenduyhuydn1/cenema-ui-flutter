import 'package:flutter/material.dart';

import 'package:cinema_booking_ui_flutter/config/constant.dart';

class CustomBottomNavigation extends StatelessWidget {
  final int currentPage;
  final Function(int) onPressed;

  const CustomBottomNavigation({
    super.key,
    required this.currentPage,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final List<IconData> icons = [
      Icons.home_filled,
      Icons.favorite,
      Icons.airplane_ticket,
      Icons.person_rounded
    ];

    return SizedBox(
      height: 100,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(
          icons.length,
          (index) => GestureDetector(
            onTap: () => onPressed(index),
            child: Stack(
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  height: currentPage == index ? 24 : 0,
                  width: currentPage == index ? 24 : 0,
                  decoration: BoxDecoration(shape: BoxShape.circle, boxShadow: [
                    BoxShadow(
                      color: white.withOpacity(.1),
                      spreadRadius: 5,
                      blurRadius: 5,
                    )
                  ]),
                ),
                Icon(
                  icons[index],
                  color: currentPage == index ? white : white.withOpacity(.1),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
