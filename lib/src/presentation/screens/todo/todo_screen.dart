import 'package:flutter/material.dart';
import 'package:heydodo/src/presentation/lib/helpers/image_picker.dart';
import 'package:heydodo/src/presentation/screens/todo/bloc/todo_bloc.dart';
import 'package:heydodo/src/presentation/screens/todo/widgets/todo.dart';
import 'package:heydodo/src/presentation/widgets/button.dart';
import 'package:heydodo/src/presentation/widgets/dialog.dart';
import 'package:iconsax/iconsax.dart';
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

  late final TodoBloC _bloC;

  late final ImageHelper _imageHelper;

  @override
  void initState() {
    group = widget.groupToDo;
    _bloC = TodoBloC()..init(group);
    _imageHelper = ImageHelper();

    _titleController = TextEditingController(
        text: widget.groupToDo.title ?? widget.groupToDo.dateFormatted);
    _descriptionController =
        TextEditingController(text: widget.groupToDo.description);

    context.read<ToDoProvider>().getAllToDos(widget.groupToDo.id);
    super.initState();
  }

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

  _onPickImage(GroupToDoEntity group) async {
    try {
      final file = await _imageHelper.pick();
      if (file == null) return;

      final bytes = _imageHelper.toBytes(file: file);
      group.image = bytes;

      _bloC.update(group);
      if (!mounted) return;

      context.read<GroupToDoProvider>().write(group);
    } catch (e) {
      showHeyDoDoAlert(
          context: context,
          title: '¡Oh no!',
          content: const HeyDoDoDialogAlertContentText(text: [
            TextSpan(text: 'Al parecer algo ha salido muy mal'),
          ]),
          buttons: [
            const HeyDoDoAlertButtonConfirm(label: 'Aceptar'),
          ]);
    }
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
            // Padding(
            //   padding: const EdgeInsets.only(top: 3.5),
            //   child: GestureDetector(
            //     onTap: () {},
            //     child: const SizedBox(
            //       child: Icon(
            //         Icons.share,
            //         color: HeyDoDoColors.light,
            //         size: heyDoDoPadding * 3,
            //       ),
            //     ),
            //   ),
            // ),
            // const SizedBox(
            //   width: heyDoDoPadding,
            // ),
          ],
        ),
        body: LayoutBuilder(
          builder: (context, contraints) => Container(
            decoration: const BoxDecoration(color: HeyDoDoColors.white),
            child: Padding(
              padding: const EdgeInsets.all(heyDoDoPadding),
              child: CustomScrollView(
                slivers: [
                  SliverPadding(
                      padding: const EdgeInsets.all(heyDoDoPadding),
                      sliver: SliverToBoxAdapter(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Título:',
                            softWrap: true,
                            style: TextStyle(
                                color: HeyDoDoColors.light, fontSize: 12.0),
                          ),
                          const SizedBox(
                            height: heyDoDoPadding,
                          ),
                          TextFormField(
                            controller: _titleController,
                            cursorColor: HeyDoDoColors.light,
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall!
                                .copyWith(
                                  color: HeyDoDoColors.light,
                                  fontSize: 18.0,
                                ),
                            decoration: const InputDecoration(
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                errorBorder: InputBorder.none),
                          ),
                        ],
                      ))),
                  SliverToBoxAdapter(
                    child: StreamBuilder<GroupToDoEntity>(
                        stream: _bloC.stream,
                        builder: (context, snapshot) {
                          if (snapshot.hasData &&
                              snapshot.data!.image != null) {
                            return Container(
                              clipBehavior: Clip.hardEdge,
                              constraints:
                                  const BoxConstraints(maxHeight: 240.0),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(24.0)),
                              child: Ink(
                                width: double.infinity,
                                height: 240.0,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(24.0)),
                                child: InkWell(
                                  onTap: () {
                                    _onPickImage(group);
                                  },
                                  child: Image.memory(
                                    snapshot.data!.image!,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            );
                          }

                          return Ink(
                            width: double.infinity,
                            height: 120,
                            decoration: BoxDecoration(
                                border: const Border.fromBorderSide(BorderSide(
                                    color: HeyDoDoColors.medium, width: 1.4)),
                                borderRadius: BorderRadius.circular(24.0)),
                            child: InkWell(
                              onTap: () {
                                _onPickImage(group);
                              },
                              child: const Padding(
                                padding: EdgeInsets.all(6.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Iconsax.image,
                                      size: 32.0,
                                      color: HeyDoDoColors.medium,
                                    ),
                                    SizedBox(
                                      height: heyDoDoPadding * 2,
                                    ),
                                    Text(
                                      'Agregar imagen',
                                      style: TextStyle(
                                          color: HeyDoDoColors.medium,
                                          fontSize: 18.0),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }),
                  ),
                  const SliverToBoxAdapter(
                    child: SizedBox(
                      height: heyDoDoPadding * 2,
                    ),
                  ),
                  SliverPadding(
                    padding: const EdgeInsets.all(heyDoDoPadding),
                    sliver: SliverToBoxAdapter(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text(
                            'ToDo',
                            style: TextStyle(
                                color: HeyDoDoColors.light, fontSize: 12.0),
                          ),
                          const SizedBox(
                            height: heyDoDoPadding,
                          ),
                          TextFormField(
                            controller: _todoController,
                            keyboardType: TextInputType.multiline,
                            onSaved: (String? value) {
                              _onSaveToDo(group);
                            },
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
                    return provider.todos.isNotEmpty
                        ? SliverList.builder(
                            itemCount: provider.todos.length,
                            itemBuilder: (context, index) {
                              final todo = provider.todos[index];
                              if (todo.isCompleted!) {
                                return const SizedBox.shrink();
                              }
                              return GestureDetector(
                                  onTap: () {
                                    _todoController.text = todo.text;
                                  },
                                  child: ToDo(todo: todo, group: group));
                            },
                          )
                        : const SliverToBoxAdapter(
                            child: SizedBox.shrink(),
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
                        return Draggable(
                          data: GestureDetector(
                            onTap: () {
                              _todoController.text = todo.text;
                            },
                            child: ToDo(
                              todo: todo,
                              group: group,
                            ),
                          ),
                          feedback: ToDo(
                            todo: todo,
                            group: group,
                          ),
                          child: ToDo(
                            todo: todo,
                            group: group,
                          ),
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
          child: HeyDoDoButton(
            onPressed: () {
              _onSaveGroup();
            },
            label: 'Guardar',
          ),
        ),
      ),
    );
  }
}
