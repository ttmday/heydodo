import 'dart:async';

import 'package:heydodo/src/domain/entities/todo_entity.dart';

class TodoBloC {
  late final StreamController<GroupToDoEntity> _groupdTodoController;
  late final StreamController<int> _newTodoController;
  late final StreamController<int> _paginatorTodoController;

  Stream<GroupToDoEntity> get stream => _groupdTodoController.stream;
  Stream<int> get newTodoWrittingStream => _newTodoController.stream;
  Stream<int> get paginatorStream => _paginatorTodoController.stream;

  int _currentListPage = 0;

  init(GroupToDoEntity group) {
    _groupdTodoController = StreamController<GroupToDoEntity>.broadcast()
      ..add(group);

    _newTodoController = StreamController<int>();
    _paginatorTodoController = StreamController<int>.broadcast();
  }

  update(GroupToDoEntity group) {
    _groupdTodoController.add(group);
  }

  setCurrentPage(int page) {
    _currentListPage = page;
    _paginatorTodoController.add(page);
  }

  int get getCurrentPage => _currentListPage;

  setWrittingTodoStatus(int status) {
    status = status.clamp(0, 1);
    _newTodoController.add(status);
  }

  dispose() {
    _groupdTodoController.close();
    _newTodoController.close();
    _paginatorTodoController.close();
  }
}
