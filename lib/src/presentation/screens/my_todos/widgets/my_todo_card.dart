import 'package:flutter/material.dart';
import 'package:heydodo/src/presentation/screens/todo/todo_screen.dart';
import 'package:heydodo/src/presentation/widgets/card.dart';
import 'package:provider/provider.dart';
import 'package:iconsax/iconsax.dart';

import 'package:heydodo/src/domain/entities/todo_entity.dart';
import 'package:heydodo/src/presentation/lib/providers/group_todo_provider.dart';
import 'package:heydodo/src/presentation/widgets/dialog.dart';

import 'package:heydodo/src/config/constants/colors.dart';
import 'package:heydodo/src/config/constants/utils.dart';

class MyGroupToDoCard extends StatelessWidget {
  const MyGroupToDoCard({
    super.key,
    required this.groupToDo,
  });

  final GroupToDoEntity groupToDo;

  @override
  Widget build(BuildContext context) {
    return HeyDoDoCard(
      onPressed: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => ToDoScreen(groupToDo: groupToDo)));
      },
      title: groupToDo.title ?? '',
      subtitle: groupToDo.dateFormatted,
      body: groupToDo.description ?? '',
      color: groupToDo.color != null ? Color(groupToDo.color!) : null,
      textColor: Color(groupToDo.textColor ?? HeyDoDoColors.white.value),
      footer: [
        TextSpan(
            text: groupToDo.todos
                .where((e) => e.isCompleted != null && e.isCompleted!)
                .toList()
                .length
                .toString()),
        TextSpan(text: ' de ${groupToDo.todos.length} completados')
      ],
      actions: [
        GestureDetector(
          onTap: () {
            showHeyDoDoAlert(
                context: context,
                title: 'Confirmar',
                content: HeyDoDoDialogAlertContentText(text: [
                  const TextSpan(
                      text:
                          'Al presionar continuar se eliminará permanentemente el grupo ToDo '),
                  TextSpan(
                      text: groupToDo.title ?? '',
                      style: const TextStyle(
                          color: HeyDoDoColors.medium, fontSize: 18))
                ]),
                buttons: [
                  const HeyDoDoAlertButtonConfirm(label: 'Continuar'),
                  const SizedBox(
                    width: heyDoDoPadding * 2,
                  ),
                  const HeyDoDoAlertButtonCancel(label: 'Cancelar')
                ]).then((value) {
              if (value != null && value == HeyDoDoDialogAlertRole.confirmed) {
                context.read<GroupToDoProvider>().remove(groupToDo.id);
              }
            });
          },
          child: SizedBox(
            child: Icon(
              Iconsax.trash,
              color: Color(groupToDo.textColor ?? HeyDoDoColors.white.value),
              size: heyDoDoPadding * 3,
            ),
          ),
        ),
        const SizedBox(
          width: heyDoDoPadding / 2,
        ),
        GestureDetector(
          onTap: () {
            groupToDo.isFixed =
                groupToDo.isFixed != null ? !groupToDo.isFixed! : true;
            context.read<GroupToDoProvider>().write(groupToDo);
          },
          child: SizedBox(
            child: Icon(
              groupToDo.isFixed != null && groupToDo.isFixed!
                  ? Icons.push_pin
                  : Icons.push_pin_outlined,
              color: Color(groupToDo.textColor ?? HeyDoDoColors.white.value),
              size: heyDoDoPadding * 3,
            ),
          ),
        ),
        const SizedBox(
          width: heyDoDoPadding / 2,
        ),
        GestureDetector(
          onTap: () {
            groupToDo.isFavorite =
                groupToDo.isFavorite != null ? !groupToDo.isFavorite! : true;
            context.read<GroupToDoProvider>().write(groupToDo);
          },
          child: SizedBox(
            child: Icon(
              groupToDo.isFavorite != null && groupToDo.isFavorite!
                  ? Icons.star_sharp
                  : Icons.star_outline_sharp,
              color: Color(groupToDo.textColor ?? HeyDoDoColors.white.value),
              size: heyDoDoPadding * 3,
            ),
          ),
        ),
        const SizedBox(
          width: heyDoDoPadding / 2,
        ),
      ],
    );
  }
}
