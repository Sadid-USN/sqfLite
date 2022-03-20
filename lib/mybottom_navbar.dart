import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';

class MyBottomNavigationBarItem {
  final IconData? icon;
  final LocaleText? lable;
  const MyBottomNavigationBarItem({
    Key? key,
    required this.icon,
    this.lable,
  });
}
