import 'package:flutter/material.dart';

import 'package:heydodo/src/domain/entities/todo_entity.dart';

import 'package:heydodo/src/presentation/screens/my_todos/widgets/my_todo_card.dart';

class MyGroupToDoList extends StatelessWidget {
  const MyGroupToDoList({
    super.key,
    required this.groups,
  });

  final List<GroupToDoEntity> groups;

  @override
  Widget build(BuildContext context) {
    return SliverList.builder(
        itemCount: groups.length,
        itemBuilder: (context, index) {
          final group = groups[index];
          return MyGroupToDoCard(groupToDo: group);
        });
  }
}
