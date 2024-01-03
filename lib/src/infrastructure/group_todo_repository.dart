import 'package:heydodo/objectbox.g.dart';

import 'package:heydodo/src/domain/entities/todo_entity.dart';

class GroupToDoRepositoryStore {
  final Box<GroupToDoEntity> _groupBox;

  GroupToDoRepositoryStore(Store store)
      : _groupBox = store.box<GroupToDoEntity>();

  Future<List<GroupToDoEntity>> getAllGroups() async {
    return _groupBox.getAll();
  }

  write(GroupToDoEntity group) {
    return _groupBox.put(group);
  }

  remove(int id) {
    _groupBox.remove(id);
  }

  clear() {
    _groupBox.removeAll();
  }

  update(GroupToDoEntity group) {
    _groupBox.put(group);
  }
}
