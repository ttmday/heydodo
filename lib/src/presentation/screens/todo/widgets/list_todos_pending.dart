import 'package:flutter/material.dart';
import 'package:heydodo/src/domain/entities/todo_entity.dart';
import 'package:heydodo/src/presentation/providers/todo_provider.dart';
import 'package:heydodo/src/presentation/screens/todo/widgets/todo.dart';
import 'package:provider/provider.dart';

class ListTodosPending extends StatelessWidget {
  const ListTodosPending({required this.group, super.key});

  final GroupToDoEntity group;

  @override
  Widget build(BuildContext context) {
    return Consumer<ToDoProvider>(builder: (context, provider, _) {
      return ListView.builder(
        itemCount: provider.todos.length,
        itemBuilder: (context, index) {
          final todo = provider.todos[index];
          if (!todo.isCompleted!) {
            return const SizedBox.shrink();
          }
          return ToDo(
            todo: todo,
            group: group,
          );
        },
      );
    });
  }
}
