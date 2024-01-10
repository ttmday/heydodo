import 'package:flutter/material.dart';
import 'package:heydodo/src/presentation/screens/home/bloc/home_bloc.dart';
import 'package:heydodo/src/presentation/widgets/floating_button.dart';
import 'package:iconsax/iconsax.dart';
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

  late final HomeBloC _bloC;

  @override
  void initState() {
    _bloC = HomeBloC();
    _pageController = PageController(initialPage: 0);
    context.read<NoteProvider>().getAllNotes();
    context.read<GroupToDoProvider>().getAllGroups();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      HeyDoDoTheme.setStatusBarAndNavigationBarTheme(
          color: HeyDoDoColors.white, brightness: Brightness.dark);
    });

    super.initState();
  }

  @override
  void dispose() {
    _bloC.dispose();
    context.read<StoreProvider>().close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HeyDoDoColors.white,
      body: SafeArea(
          child: PageView(
        controller: _pageController,
        children: const [MyNotesScreen(), MyToDosScreen()],
        onPageChanged: (int page) {
          _bloC.setCurrentPage(page);
        },
      )),
      floatingActionButton: HeyDoDoFloatingButton(
        onPressed: () {
          _bloC.floatingButtonActionExecute(context);
        },
        child: const SizedBox(
          child: Icon(
            Iconsax.add,
            size: heyDoDoPadding * 4,
            color: HeyDoDoColors.light,
          ),
        ),
      ),
      bottomNavigationBar: StreamBuilder<int>(
          stream: _bloC.stream,
          initialData: 0,
          builder: (context, snapshot) {
            return HeyDoDoNavigationBar(
              currentPageIndex: snapshot.data!,
              onChange: (int page) {
                _bloC.setCurrentPage(page);
                _pageController.jumpToPage(page);
              },
            );
          }),
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
    ]);
  }
}
