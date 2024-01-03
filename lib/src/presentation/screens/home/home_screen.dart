import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:heydodo/src/presentation/providers/group_todo_provider.dart';
import 'package:heydodo/src/presentation/screens/my_notes/my_notes_screen.dart';
import 'package:heydodo/src/presentation/screens/my_todos/my_todos_screen.dart';

import 'package:heydodo/src/config/constants/colors.dart';
import 'package:heydodo/src/config/constants/theme.dart';

import 'package:heydodo/src/config/constants/utils.dart';
import 'package:heydodo/src/presentation/providers/note_provider.dart';
import 'package:heydodo/src/presentation/providers/store_provider.dart';

import 'package:heydodo/src/presentation/screens/home/widgets/navigationbar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final PageController _pageController;

  int _currentPage = 0;

  @override
  void initState() {
    _pageController = PageController(initialPage: _currentPage);
    context.read<NoteProvider>().getAllNotes();
    context.read<GroupToDoProvider>().getAllGroups();
    super.initState();
  }

  @override
  void dispose() {
    context.read<StoreProvider>().close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    HeyDoDoTheme.setStatusBarAndNavigationBarTheme(
        color: HeyDoDoColors.white, brightness: Brightness.dark);
    return Scaffold(
      backgroundColor: HeyDoDoColors.white,
      appBar: AppBar(
        title: const SafeArea(child: HeyDoDoAppBar()),
      ),
      body: SafeArea(
          child: PageView(
        controller: _pageController,
        children: const [MyNotesScreen(), MyToDosScreen()],
        onPageChanged: (int page) {
          setState(() {
            _currentPage = page;
          });
        },
      )),
      bottomNavigationBar: HeyDoDoNavigationBar(
        currentPageIndex: _currentPage,
        onChange: (index) {
          setState(() {
            _currentPage = index;
          });
          _pageController.jumpToPage(_currentPage);
        },
      ),
    );
  }
}

class HeyDoDoAppBar extends StatelessWidget {
  const HeyDoDoAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Expanded(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: heyDoDoPadding * 2),
          child: Text(
            'Hey, Do Do',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        ),
      ),
      const SizedBox(
        width: heyDoDoPadding,
      ),
      // MaterialButton(
      //   onPressed: () {},
      //   child: Container(
      //     padding: const EdgeInsets.all(heyDoDoPadding),
      //     decoration: BoxDecoration(
      //         shape: BoxShape.circle,
      //         border: Border.all(width: 1.2, color: HeyDoDoColors.light)),
      //     child: const Icon(
      //       Icons.add,
      //       size: heyDoDoPadding * 4,
      //       color: HeyDoDoColors.light,
      //     ),
      //   ),
      // )
    ]);
  }
}
