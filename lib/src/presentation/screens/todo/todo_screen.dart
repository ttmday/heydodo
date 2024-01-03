import 'package:flutter/material.dart';
import 'package:heydodo/src/presentation/screens/todo/widgets/todo.dart';
import 'package:provider/provider.dart';

import 'package:heydodo/src/config/constants/colors.dart';
import 'package:heydodo/src/config/constants/utils.dart';
import 'package:heydodo/src/domain/entities/todo_entity.dart';
import 'package:heydodo/src/presentation/providers/group_todo_provider.dart';
import 'package:heydodo/src/presentation/providers/todo_provider.dart';

class ToDoScreen extends StatefulWidget {
  final GroupToDoEntity groupToDo;
  const ToDoScreen({required this.groupToDo, super.key});

  @override
  State<ToDoScreen> createState() => _ToDoScreenState();
}

class _ToDoScreenState extends State<ToDoScreen> {
  late final TextEditingController _titleController;
  late final TextEditingController _descriptionController;
  late final TextEditingController _todoController = TextEditingController();

  late GroupToDoEntity group;

  @override
  void initState() {
    group = widget.groupToDo;
    _titleController = TextEditingController(
        text: widget.groupToDo.title ?? widget.groupToDo.dateFormatted);
    _descriptionController =
        TextEditingController(text: widget.groupToDo.description);

    context.read<ToDoProvider>().getAllToDos(widget.groupToDo.id);
    super.initState();
  }

  // _onSaveNote(NoteEntity note) {
  //   if (_noteController.text.isNotEmpty) {
  //     note.note = _noteController.text;
  //     note.title = _titleController.text;
  //     context.read<NoteProvider>().write(note);
  //   }
  //   Navigator.of(context).pop();
  // }

  _onSaveToDo(GroupToDoEntity group) async {
    if (_todoController.text.isEmpty) {
      return;
    }

    group.title = _titleController.text;
    group.description = _descriptionController.text;
    context.read<GroupToDoProvider>().write(group);

    final text = _todoController.text;
    ToDoEntity todo = ToDoEntity(text);
    todo.group.target = group;

    context.read<ToDoProvider>().write(todo, group.id);
    _todoController.clear();
    setState(() {});
  }

  _onSaveGroup() {
    group.title = _titleController.text;
    group.description = _descriptionController.text;
    context.read<GroupToDoProvider>().write(group);
    Navigator.of(context).pop();
  }

  GroupToDoEntity getGroupFrom(List<GroupToDoEntity> groups) {
    final g = groups.firstWhere((element) => element.id == group.id);

    return g;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _todoController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BackButtonListener(
      onBackButtonPressed: () async {
        _onSaveGroup();
        return true;
      },
      child: Scaffold(
        backgroundColor: HeyDoDoColors.white,
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              _onSaveGroup();
            },
            icon: const Icon(
              Icons.arrow_back,
              size: heyDoDoPadding * 4,
              color: HeyDoDoColors.light,
            ),
          ),
          backgroundColor: HeyDoDoColors.white,
          surfaceTintColor: HeyDoDoColors.white,
          title: Text(
            'ToDos',
            style: Theme.of(context)
                .textTheme
                .headlineSmall!
                .copyWith(color: HeyDoDoColors.light),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(top: 3.5),
              child: GestureDetector(
                onTap: () {},
                child: const SizedBox(
                  child: Icon(
                    Icons.share,
                    color: HeyDoDoColors.light,
                    size: heyDoDoPadding * 3,
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: heyDoDoPadding,
            ),
          ],
        ),
        body: LayoutBuilder(
          builder: (context, contraints) => Container(
            decoration: const BoxDecoration(color: HeyDoDoColors.white),
            child: Padding(
              padding: const EdgeInsets.all(heyDoDoPadding),
              child: CustomScrollView(
                slivers: [
                  SliverAppBar(
                    automaticallyImplyLeading: false,
                    backgroundColor: HeyDoDoColors.white,
                    surfaceTintColor: HeyDoDoColors.white,
                    pinned: true,
                    flexibleSpace: Container(
                      alignment: Alignment.topCenter,
                      child: TextFormField(
                        controller: _titleController,
                        maxLines: 3,
                        cursorColor: HeyDoDoColors.light,
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall!
                            .copyWith(
                                color: HeyDoDoColors.light, fontSize: 22.0),
                        decoration: const InputDecoration(
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            errorBorder: InputBorder.none),
                      ),
                    ),
                  ),
                  const SliverToBoxAdapter(
                    child: SizedBox(
                      height: heyDoDoPadding / 2,
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: heyDoDoPadding),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: heyDoDoPadding * 3,
                          ),
                          const Text(
                            'ToDo',
                            style: TextStyle(
                                color: HeyDoDoColors.light, fontSize: 14.0),
                          ),
                          const SizedBox(
                            height: heyDoDoPadding,
                          ),
                          TextFormField(
                            controller: _todoController,
                            keyboardType: TextInputType.multiline,
                            textInputAction: TextInputAction.newline,
                            autofocus: true,
                            cursorColor: HeyDoDoColors.light,
                            style: const TextStyle(
                                color: HeyDoDoColors.light, fontSize: 16.0),
                            decoration: const InputDecoration(
                                enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: HeyDoDoColors.secondary)),
                                focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: HeyDoDoColors.secondary)),
                                errorBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: HeyDoDoColors.secondary))),
                          ),
                          const SizedBox(
                            height: heyDoDoPadding * 2,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              if (_todoController.text.isNotEmpty)
                                GestureDetector(
                                  onTap: () {
                                    _todoController.clear();
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: heyDoDoPadding * 5,
                                        vertical: heyDoDoPadding),
                                    decoration: BoxDecoration(
                                        color: HeyDoDoColors.medium,
                                        borderRadius:
                                            BorderRadius.circular(24.0)),
                                    child: const Text(
                                      'Cancelar',
                                      style: TextStyle(
                                          color: HeyDoDoColors.white,
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                ),
                              const SizedBox(
                                width: heyDoDoPadding,
                              ),
                              GestureDetector(
                                onTap: () {
                                  _onSaveToDo(group);
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: heyDoDoPadding * 5,
                                      vertical: heyDoDoPadding),
                                  decoration: BoxDecoration(
                                      color: HeyDoDoColors.secondary,
                                      borderRadius:
                                          BorderRadius.circular(24.0)),
                                  child: const Text(
                                    'Crear',
                                    style: TextStyle(
                                        color: HeyDoDoColors.white,
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SliverToBoxAdapter(
                    child: SizedBox(height: heyDoDoPadding),
                  ),
                  Consumer<ToDoProvider>(builder: (context, provider, _) {
                    return SliverList.builder(
                      itemCount: provider.todos.length,
                      itemBuilder: (context, index) {
                        final todo = provider.todos[index];
                        if (todo.isCompleted!) {
                          return const SizedBox.shrink();
                        }
                        return ToDo(todo: todo, group: group);
                      },
                    );
                  }),
                  Consumer<ToDoProvider>(builder: (context, provider, _) {
                    final completes = provider.todos
                        .where((element) => element.isCompleted!)
                        .toList()
                        .length;

                    if (completes > 0) {
                      return const SliverPadding(
                        padding: EdgeInsets.all(heyDoDoPadding),
                        sliver: SliverToBoxAdapter(
                          child: Text(
                            'Completados',
                            style: TextStyle(
                              color: HeyDoDoColors.light,
                              fontSize: 12.0,
                            ),
                          ),
                        ),
                      );
                    }

                    return const SliverToBoxAdapter(
                      child: SizedBox.shrink(),
                    );
                  }),
                  Consumer<ToDoProvider>(builder: (context, provider, _) {
                    return SliverList.builder(
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
                  })
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: Container(
          padding: const EdgeInsets.all(heyDoDoPadding * 2),
          child: GestureDetector(
            onTap: () {
              _onSaveGroup();
            },
            child: Container(
              alignment: Alignment.center,
              height: 56.0,
              padding: const EdgeInsets.symmetric(
                  horizontal: heyDoDoPadding * 5, vertical: heyDoDoPadding * 2),
              decoration: BoxDecoration(
                  color: HeyDoDoColors.secondary,
                  borderRadius: BorderRadius.circular(24.0)),
              child: const Text(
                'Guardar',
                style: TextStyle(
                    color: HeyDoDoColors.white,
                    fontSize: 18.0,
                    fontWeight: FontWeight.w500),
              ),
            ),
          ),
        ),
        // floatingActionButton: HeyDoDoFloatingButton(
        //   onPressed: () {
        //     showModalBottomSheet(
        //         context: context,
        //         backgroundColor: Colors.transparent,
        //         useSafeArea: true,
        //         enableDrag: true,
        //         isScrollControlled: true,
        //         constraints: BoxConstraints(
        //             maxWidth: q.width * 9, maxHeight: q.height * .7),
        //         builder: (context) {
        //           return Container(
        //             padding: const EdgeInsets.all(heyDoDoPadding * 2),
        //             margin: EdgeInsets.only(bottom: q.height * .3),
        //             decoration: BoxDecoration(
        //                 borderRadius: BorderRadius.circular(24.0),
        //                 color: HeyDoDoColors.white),
        //             child: Column(
        //               children: [
        //                 Stack(
        //                   children: [
        //                     Text(
        //                       'Todo',
        //                       style: Theme.of(context)
        //                           .textTheme
        //                           .headlineSmall!
        //                           .copyWith(color: HeyDoDoColors.secondary),
        //                     ),
        //                     const Positioned(
        //                         top: 3.5,
        //                         right: 3.5,
        //                         child: Icon(
        //                           Icons.close,
        //                           size: heyDoDoPadding * .3,
        //                           color: HeyDoDoColors.light,
        //                         ))
        //                   ],
        //                 ),
        //                 const SizedBox(
        //                   height: heyDoDoPadding * 2,
        //                 ),
        //                 Column(
        //                   crossAxisAlignment: CrossAxisAlignment.start,
        //                   children: [
        //                     const Text(
        //                       'Actividad',
        //                       style: TextStyle(
        //                           color: HeyDoDoColors.medium, fontSize: 14.0),
        //                     ),
        //                     const SizedBox(
        //                       height: heyDoDoPadding,
        //                     ),
        //                     TextFormField(
        //                       cursorColor: HeyDoDoColors.medium,
        //                       autofocus: true,
        //                       style: const TextStyle(
        //                           color: HeyDoDoColors.medium,
        //                           fontSize: heyDoDoPadding + 12.0),
        //                       decoration: const InputDecoration(
        //                           enabledBorder: UnderlineInputBorder(
        //                               borderSide: BorderSide(
        //                                   color: HeyDoDoColors.medium)),
        //                           focusedBorder: UnderlineInputBorder(
        //                               borderSide: BorderSide(
        //                                   color: HeyDoDoColors.light)),
        //                           errorBorder: UnderlineInputBorder(
        //                               borderSide: BorderSide(
        //                                   color: HeyDoDoColors.light))),
        //                     ),
        //                   ],
        //                 ),
        //                 const Spacer(),
        //                 Row(
        //                   mainAxisAlignment: MainAxisAlignment.center,
        //                   children: [
        //                     GestureDetector(
        //                       onTap: () {
        //                         Navigator.of(context).pop();
        //                       },
        //                       child: Container(
        //                         padding: const EdgeInsets.symmetric(
        //                             horizontal: heyDoDoPadding * 5,
        //                             vertical: heyDoDoPadding * 2),
        //                         decoration: BoxDecoration(
        //                             color: HeyDoDoColors.medium,
        //                             borderRadius: BorderRadius.circular(24.0)),
        //                         child: const Text(
        //                           'Cancelar',
        //                           style: TextStyle(
        //                               color: HeyDoDoColors.white,
        //                               fontSize: 16.0,
        //                               fontWeight: FontWeight.w500),
        //                         ),
        //                       ),
        //                     ),
        //                     const SizedBox(
        //                       width: heyDoDoPadding,
        //                     ),
        //                     GestureDetector(
        //                       onTap: () {
        //                         _onSaveToDo(group);
        //                         Navigator.of(context).pop();
        //                       },
        //                       child: Container(
        //                         padding: const EdgeInsets.symmetric(
        //                             horizontal: heyDoDoPadding * 5,
        //                             vertical: heyDoDoPadding * 2),
        //                         decoration: BoxDecoration(
        //                             color: HeyDoDoColors.secondary,
        //                             borderRadius: BorderRadius.circular(24.0)),
        //                         child: const Text(
        //                           'Guardar',
        //                           style: TextStyle(
        //                               color: HeyDoDoColors.white,
        //                               fontSize: 16.0,
        //                               fontWeight: FontWeight.w500),
        //                         ),
        //                       ),
        //                     )
        //                   ],
        //                 ),
        //                 const SizedBox(
        //                   height: heyDoDoPadding * 2,
        //                 )
        //               ],
        //             ),
        //           );
        //         });
        //   },
        //   child: const Icon(
        //     Iconsax.add,
        //     size: heyDoDoPadding * 4,
        //     color: HeyDoDoColors.light,
        //   ),
        // ),
      ),
    );
  }
}
