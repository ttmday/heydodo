import 'dart:async';

import 'package:heydodo/src/domain/entities/todo_entity.dart';

class TodoBloC {
  final StreamController<GroupToDoEntity> _groupdTodoController =
      StreamController<GroupToDoEntity>();

  Stream<GroupToDoEntity> get stream => _groupdTodoController.stream;

  init(GroupToDoEntity group) {
    _groupdTodoController.add(group);
  }

  update(GroupToDoEntity group) {
    _groupdTodoController.add(group);
  }

  dispose() {
    _groupdTodoController.close();
  }
}
