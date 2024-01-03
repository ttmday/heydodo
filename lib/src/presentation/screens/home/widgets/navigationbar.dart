import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:heydodo/src/config/constants/colors.dart';
import 'package:heydodo/src/presentation/screens/home/constants/tab_list.dart';
import 'package:heydodo/src/presentation/screens/home/models/tab.dart';

class HeyDoDoNavigationBar extends StatelessWidget {
  final void Function(int index) onChange;
  final int currentPageIndex;

  const HeyDoDoNavigationBar(
      {required this.onChange, required this.currentPageIndex, super.key});

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      backgroundColor: HeyDoDoColors.white,
      elevation: 0,
      height: 50.5,
      indicatorColor: Colors.transparent,
      // labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
      indicatorShape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12))),
      destinations: [
        ...List.generate(tabsList.length, (index) {
          TabModel tab = tabsList[index];
          return NavigationDestination(
              icon: SvgPicture.asset(
                tab.icon,
                color: currentPageIndex == index
                    ? HeyDoDoColors.secondary
                    : HeyDoDoColors.light,
                height: index == 2
                    ? 36
                    : index == 3
                        ? 32
                        : 28,
              ),
              label: tab.label!);
        }),
      ],
      onDestinationSelected: (index) {
        onChange(index);
      },
      selectedIndex: currentPageIndex,
    );
  }
}
