import 'package:flutter/material.dart';
import 'package:heydodo/objectbox.g.dart';
import 'package:heydodo/src/domain/entities/todo_entity.dart';
import 'package:heydodo/src/infrastructure/group_todo_repository.dart';

class GroupToDoProvider extends ChangeNotifier {
  late final GroupToDoRepositoryStore _groupToDoRepositoryStore;

  List<GroupToDoEntity> groups = [];

  GroupToDoProvider(Store store) {
    _groupToDoRepositoryStore = GroupToDoRepositoryStore(store);
  }

  Future<List<GroupToDoEntity>> getAllGroups() async {
    groups.clear();
    groups = await _groupToDoRepositoryStore.getAllGroups();

    notifyListeners();
    return groups;
  }

  Future<GroupToDoEntity> getGroup(int groupId) async {
    groups.clear();
    groups = await _groupToDoRepositoryStore.getAllGroups();

    notifyListeners();
    return groups.firstWhere((element) => element.id == groupId);
  }

  write(GroupToDoEntity group) {
    final r = _groupToDoRepositoryStore.write(group);

    getAllGroups();
    return r;
  }

  update(group) {
    _groupToDoRepositoryStore.update(group);
  }

  remove(int id) {
    _groupToDoRepositoryStore.remove(id);
    getAllGroups();
  }

  clear() {
    _groupToDoRepositoryStore.clear();
    getAllGroups();
  }
}
