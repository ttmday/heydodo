import 'package:flutter/material.dart';
import 'package:heydodo/objectbox.g.dart';
import 'package:heydodo/src/domain/entities/todo_entity.dart';

import 'package:heydodo/src/infrastructure/todo_repository.dart';

class ToDoProvider extends ChangeNotifier {
  late final ToDoRepositoryStore _toDoRepositoryStore;

  List<ToDoEntity> todos = [];

  ToDoProvider(Store store) {
    _toDoRepositoryStore = ToDoRepositoryStore(store);
  }

  Future<List<ToDoEntity>> getAllToDos(int groupId) async {
    todos.clear();
    todos = await _toDoRepositoryStore.getAllTodos(groupId);
    todos.sort((_, b) {
      if (!b.isCompleted!) {
        return 1;
      }

      return 0;
    });
    print('todos ${todos.map((e) => e.isCompleted)}');
    notifyListeners();
    return todos;
  }

  write(ToDoEntity todo, int groupId) {
    _toDoRepositoryStore.write(todo);

    getAllToDos(groupId);
  }

  remove(int id, int groupId) {
    _toDoRepositoryStore.remove(id);
    getAllToDos(groupId);
  }

  clear(int groupId) {
    _toDoRepositoryStore.clear();
    getAllToDos(groupId);
  }
}
