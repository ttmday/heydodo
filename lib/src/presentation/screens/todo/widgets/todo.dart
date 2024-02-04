import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:heydodo/src/config/constants/colors.dart';
import 'package:heydodo/src/config/constants/utils.dart';
import 'package:heydodo/src/domain/entities/todo_entity.dart';
import 'package:heydodo/src/presentation/lib/providers/todo_provider.dart';

class ToDo extends StatelessWidget {
  const ToDo({
    super.key,
    required this.todo,
    required this.group,
  });

  final ToDoEntity todo;
  final GroupToDoEntity group;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: heyDoDoPadding / 2),
      child: Container(
        decoration: BoxDecoration(
            color: HeyDoDoColors.white,
            borderRadius: BorderRadius.circular(14.0),
            boxShadow: [
              BoxShadow(
                  color: HeyDoDoColors.light.withOpacity(.25),
                  offset: const Offset(1.0, 2.5),
                  blurRadius: 4.4)
            ]),
        child: Row(
          children: [
            Checkbox(
                value: todo.isCompleted,
                onChanged: (value) {
                  todo.isCompleted = !todo.isCompleted!;
                  context.read<ToDoProvider>().write(todo, group.id);
                }),
            const SizedBox(
              width: heyDoDoPadding,
            ),
            Expanded(
              child: Text(
                todo.text,
                style: TextStyle(
                  color: HeyDoDoColors.medium,
                  decoration: todo.isCompleted!
                      ? TextDecoration.lineThrough
                      : TextDecoration.none,
                  fontSize: 14.0,
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                context.read<ToDoProvider>().remove(todo.id, group.id);
              },
              child: const SizedBox(
                child: Icon(
                  Icons.close,
                  size: heyDoDoPadding * 3,
                  color: HeyDoDoColors.secondary,
                ),
              ),
            ),
            const SizedBox(
              width: heyDoDoPadding,
            )
          ],
        ),
      ),
    );
  }
}
