import 'package:heydodo/objectbox.g.dart';

import 'package:heydodo/src/domain/entities/todo_entity.dart';

class ToDoRepositoryStore {
  final Box<ToDoEntity> _toDoBox;

  ToDoRepositoryStore(Store store) : _toDoBox = store.box<ToDoEntity>();

  Future<List<ToDoEntity>> getAllTodos(int groupId) async {
    QueryBuilder<ToDoEntity> builder = _toDoBox.query();
    builder.link(ToDoEntity_.group, GroupToDoEntity_.id.equals(groupId));
    Query<ToDoEntity> query = builder.build();
    final t = query.find();
    query.close();
    return t;
  }

  write(ToDoEntity todos) {
    _toDoBox.put(todos);
  }

  remove(int id) {
    _toDoBox.remove(id);
  }

  clear() {
    _toDoBox.removeAll();
  }

  update(ToDoEntity todos) {
    _toDoBox.put(todos);
  }
}
