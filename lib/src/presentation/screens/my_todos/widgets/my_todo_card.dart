import 'package:flutter/material.dart';
import 'package:heydodo/src/domain/entities/todo_entity.dart';
import 'package:heydodo/src/presentation/lib/providers/group_todo_provider.dart';
import 'package:heydodo/src/presentation/widgets/dialog.dart';
import 'package:provider/provider.dart';
import 'package:iconsax/iconsax.dart';

import 'package:heydodo/src/config/constants/colors.dart';
import 'package:heydodo/src/config/constants/utils.dart';

import 'package:heydodo/src/presentation/screens/screens.dart';

class MyGroupToDoCard extends StatelessWidget {
  const MyGroupToDoCard({
    super.key,
    required this.groupToDo,
  });

  final GroupToDoEntity groupToDo;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: heyDoDoPadding + 5, vertical: heyDoDoPadding),
      child: Stack(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ToDoScreen(groupToDo: groupToDo)));
            },
            child: Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: heyDoDoPadding * 2, vertical: heyDoDoPadding),
              height: 130.0,
              decoration: BoxDecoration(
                  color: HeyDoDoColors.secondary,
                  borderRadius: BorderRadius.circular(24.0)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          groupToDo.title ?? '',
                          style: const TextStyle(
                              color: HeyDoDoColors.white,
                              fontSize: 16.0,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: heyDoDoPadding,
                  ),
                  Text(
                    groupToDo.dateFormatted,
                    style: const TextStyle(
                        color: HeyDoDoColors.light,
                        fontSize: 11.0,
                        fontWeight: FontWeight.w300),
                  ),
                  const SizedBox(
                    height: heyDoDoPadding,
                  ),
                  Expanded(
                      child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      groupToDo.description ?? '',
                      maxLines: 3,
                      style: const TextStyle(
                          overflow: TextOverflow.ellipsis,
                          color: HeyDoDoColors.light,
                          fontSize: 14.0),
                    ),
                  )),
                  const SizedBox(
                    height: heyDoDoPadding,
                  ),
                  SizedBox(
                    child: RichText(
                      text: TextSpan(
                          style: const TextStyle(
                              fontSize: 11.0,
                              color: HeyDoDoColors.light,
                              fontWeight: FontWeight.w200),
                          children: [
                            TextSpan(
                                text: groupToDo.todos
                                    .where((e) => e.isCompleted ?? false)
                                    .toList()
                                    .length
                                    .toString()),
                            TextSpan(
                                text:
                                    ' de ${groupToDo.todos.length} completados')
                          ]),
                    ),
                  )
                ],
              ),
            ),
          ),
          Positioned(
              top: heyDoDoPadding + 1,
              right: heyDoDoPadding,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                                text: '${groupToDo.title}',
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
                        if (value != null &&
                            value == HeyDoDoDialogAlertRole.confirmed) {
                          context
                              .read<GroupToDoProvider>()
                              .remove(groupToDo.id);
                        }
                      });
                    },
                    child: const SizedBox(
                      child: Icon(
                        Iconsax.trash,
                        color: HeyDoDoColors.light,
                        size: heyDoDoPadding * 3,
                      ),
                    ),
                  ),
                  // const SizedBox(
                  //   width: heyDoDoPadding / 2,
                  // ),
                  // GestureDetector(
                  //   onTap: () {},
                  //   child: const SizedBox(
                  //     child: Icon(
                  //       Icons.share_outlined,
                  //       color: HeyDoDoColors.light,
                  //       size: heyDoDoPadding * 3,
                  //     ),
                  //   ),
                  // ),
                  const SizedBox(
                    width: heyDoDoPadding / 2,
                  ),
                  GestureDetector(
                    onTap: () {
                      groupToDo.isFixed = groupToDo.isFixed != null
                          ? !groupToDo.isFixed!
                          : true;
                      context.read<GroupToDoProvider>().write(groupToDo);
                    },
                    child: SizedBox(
                      child: Icon(
                        groupToDo.isFixed != null && groupToDo.isFixed!
                            ? Icons.push_pin
                            : Icons.push_pin_outlined,
                        color: HeyDoDoColors.light,
                        size: heyDoDoPadding * 3,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: heyDoDoPadding / 2,
                  ),
                  GestureDetector(
                    onTap: () {
                      groupToDo.isFavorite = groupToDo.isFavorite != null
                          ? !groupToDo.isFavorite!
                          : true;
                      context.read<GroupToDoProvider>().write(groupToDo);
                    },
                    child: SizedBox(
                      child: Icon(
                        groupToDo.isFavorite != null && groupToDo.isFavorite!
                            ? Icons.star_sharp
                            : Icons.star_outline_sharp,
                        color: HeyDoDoColors.light,
                        size: heyDoDoPadding * 3,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: heyDoDoPadding / 2,
                  ),
                ],
              ))
        ],
      ),
    );
  }
}
