import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

 import '../screens/log_in_screen/log_in_screen.dart';

class FloatActionButton extends StatelessWidget {
  const FloatActionButton({
    Key? key,
    required int currentIndex,
    required PageController pageController,
  }) : _currentIndex = currentIndex, _pageController = pageController, super(key: key);

  final int _currentIndex;
  final PageController _pageController;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        if (_currentIndex == 2) {
          Get.to(LoginScreen());


        } else {
          _pageController.nextPage(
            duration: const Duration(milliseconds: 300),
            curve: Curves.linear,
          );
        }
      },
      child: const Icon(CupertinoIcons.chevron_right, color: Colors.white),
      backgroundColor: Colors.transparent,
    );
  }
}
