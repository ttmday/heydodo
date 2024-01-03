import 'package:flutter/material.dart';

class TabModel {
  final String icon;
  final IconData? activeIcon;
  final String? label;

  const TabModel({this.activeIcon, required this.icon, required this.label});
}
