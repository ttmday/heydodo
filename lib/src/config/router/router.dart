import 'package:flutter/material.dart';
import 'package:heydodo/src/config/constants/routes.dart';
import 'package:heydodo/src/domain/entities/note_entity.dart';
import 'package:heydodo/src/domain/entities/todo_entity.dart';
import 'package:heydodo/src/presentation/screens/my_notes/my_notes_screen.dart';
import 'package:heydodo/src/presentation/screens/my_todos/my_todos_screen.dart';

import 'package:heydodo/src/presentation/screens/screens.dart';

import 'package:go_router/go_router.dart';

class HeyDoDoRouter {
  HeyDoDoRouter();

  final GlobalKey<NavigatorState> _rootNavigatorKey =
      GlobalKey<NavigatorState>(debugLabel: 'shellRoot');

  late final GoRouter router = GoRouter(
    initialLocation: '/${HeyDoDoRoutesPath.home}',
    navigatorKey: _rootNavigatorKey,
    routes: [
      GoRoute(
        path: '/${HeyDoDoRoutesPath.home}',
        name: HeyDoDoRoutesPath.home,
        builder: (context, state) {
          return HomeScreen(
            key: state.pageKey,
          );
        },
      ),
      GoRoute(
        path: '/${HeyDoDoRoutesPath.createNote}',
        name: HeyDoDoRoutesPath.createNote,
        builder: (context, state) {
          return NoteScreen(
            key: state.pageKey,
            note: state.extra as NoteEntity,
          );
        },
      ),
      GoRoute(
        path: '/${HeyDoDoRoutesPath.createToDo}',
        name: HeyDoDoRoutesPath.createToDo,
        builder: (context, state) {
          return ToDoScreen(
            key: state.pageKey,
            groupToDo: state.extra as GroupToDoEntity,
          );
        },
      ),
      GoRoute(
        path: '/${HeyDoDoRoutesPath.myNotes}',
        name: HeyDoDoRoutesPath.myNotes,
        builder: (context, state) {
          return MyNotesScreen(
            key: state.pageKey,
          );
        },
      ),
      GoRoute(
        path: '/${HeyDoDoRoutesPath.myToDos}',
        name: HeyDoDoRoutesPath.myToDos,
        builder: (context, state) {
          return MyToDosScreen(
            key: state.pageKey,
          );
        },
      ),
    ],
  );
}
