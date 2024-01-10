import 'dart:async';

import 'package:flutter/material.dart';
import 'package:heydodo/src/domain/entities/note_entity.dart';
import 'package:heydodo/src/domain/entities/todo_entity.dart';
import 'package:heydodo/src/presentation/lib/animations/slide_right_to_left_route_animation.dart';
import 'package:heydodo/src/presentation/screens/note/note_screen.dart';
import 'package:heydodo/src/presentation/screens/todo/todo_screen.dart';

class HomeBloC {
  final StreamController<int> _paginatorIndicatorController =
      StreamController<int>();

  Stream<int> get stream => _paginatorIndicatorController.stream;

  int _currentPage = 0;

  setCurrentPage(int page) {
    _currentPage = page;
    _paginatorIndicatorController.add(page);
  }

  floatingButtonActionExecute(BuildContext context) {
    if (_currentPage == 0) {
      _onCreateNewNoteRoute(context);
      return;
    }

    _onCreateNewToDoRoute(context);
  }

  void _onCreateNewToDoRoute(BuildContext context) {
    GroupToDoEntity groupToDo = GroupToDoEntity();

    Navigator.of(context).push(
      slideRightToLeftRouteAnimation(ToDoScreen(groupToDo: groupToDo)),
    );
  }

  void _onCreateNewNoteRoute(BuildContext context) {
    NoteEntity note = NoteEntity('');
    Navigator.of(context)
        .push(slideRightToLeftRouteAnimation(NoteScreen(note: note)));
  }

  dispose() {
    _paginatorIndicatorController.close();
  }
}
