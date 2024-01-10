import 'dart:async';

import 'package:heydodo/src/domain/entities/todo_entity.dart';

class TodoBloC {
  final StreamController<GroupToDoEntity> _groupdTodoController =
      StreamController<GroupToDoEntity>();

  Stream<GroupToDoEntity> get stream => _groupdTodoController.stream;

  final StreamController<int> _newTodoController = StreamController<int>();
  Stream<int> get newTodoWrittingStream => _newTodoController.stream;

  final StreamController<int> _paginatorTodoController =
      StreamController<int>();

  Stream<int> get paginatorStream => _paginatorTodoController.stream;

  init(GroupToDoEntity group) {
    _groupdTodoController.add(group);
  }

  update(GroupToDoEntity group) {
    _groupdTodoController.add(group);
  }

  setCurrentPage(int page) {
    _paginatorTodoController.add(page);
  }

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
