import 'package:heydodo/src/presentation/screens/home/models/tab.dart';
import 'package:flutter/material.dart';

List<TabModel> tabsList = [
  const TabModel(
    icon: 'assets/images/svg/stickynote.svg',
    activeIcon: Icons.home,
    label: 'Notas',
  ),
  const TabModel(
    icon: 'assets/images/svg/clock.svg',
    activeIcon: Icons.search,
    label: 'ToDos',
  ),
];
