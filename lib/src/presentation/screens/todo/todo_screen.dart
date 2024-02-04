import 'package:flutter/material.dart';
import 'package:heydodo/src/presentation/screens/todo/widgets/add_todo_dialog.dart';
import 'package:heydodo/src/presentation/widgets/color_random_dialog.dart';
import 'package:heydodo/src/presentation/widgets/icon_action.dart';
import 'package:heydodo/src/presentation/widgets/title_edit_dialog.dart';
import 'package:heydodo/src/presentation/screens/todo/widgets/todo_paginating_status.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

import 'package:heydodo/src/presentation/lib/helpers/image_picker.dart';
import 'package:heydodo/src/presentation/screens/todo/bloc/todo_bloc.dart';
import 'package:heydodo/src/presentation/screens/todo/widgets/list_todos_completed.dart';
import 'package:heydodo/src/presentation/screens/todo/widgets/list_todos_pending.dart';

import 'package:heydodo/src/presentation/widgets/dialog.dart';
import 'package:heydodo/src/presentation/widgets/image_container.dart';

import 'package:heydodo/src/config/constants/colors.dart';
import 'package:heydodo/src/config/constants/utils.dart';
import 'package:heydodo/src/domain/entities/todo_entity.dart';
import 'package:heydodo/src/presentation/lib/providers/group_todo_provider.dart';
import 'package:heydodo/src/presentation/lib/providers/todo_provider.dart';

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

    _bloC.setWrittingTodoStatus(0);

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
    if (group.todos.isNotEmpty || group.image != null) {
      group.title = _titleController.text;
      group.description = _descriptionController.text;
      context.read<GroupToDoProvider>().write(group);
      _bloC.update(group);
    }
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

  _onDeleteImage(GroupToDoEntity group) {
    showHeyDoDoAlert(
        context: context,
        title: 'Eliminar imagen',
        content: const HeyDoDoDialogAlertContentText(text: [
          TextSpan(
            text: 'Al presionar continuar la imagen será eliminada.',
          ),
          TextSpan(text: '\n¿Está seguro que desea continuar?')
        ]),
        buttons: [
          HeyDoDoAlertButtonConfirm(
            label: 'Sí, continuar',
            onPressed: () {
              Navigator.of(context).pop();

              group.image = null;
              _bloC.update(group);

              context.read<GroupToDoProvider>().write(group);
            },
          ),
          const SizedBox(
            width: heyDoDoPadding,
          ),
          const HeyDoDoAlertButtonCancel(label: 'cancelar')
        ]);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _todoController.dispose();
    _descriptionController.dispose();
    _bloC.dispose();
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
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.arrow_back,
              size: heyDoDoPadding * 4,
              color: HeyDoDoColors.light,
            ),
          ),
          backgroundColor: HeyDoDoColors.white,
          surfaceTintColor: HeyDoDoColors.white,
          actions: [
            StreamBuilder<GroupToDoEntity>(
                stream: _bloC.stream,
                builder: (context, snapshot) {
                  return IconAction(
                    onPressed: () async {
                      int? color = await showDialog(
                          context: context,
                          builder: (context) => const ColorRandomDialog());

                      if (color != null) {
                        group.color = color;
                        _onSaveGroup();
                      }
                    },
                    icon: Iconsax.colors_square,
                    iconColor: snapshot.data?.color != null
                        ? Color(snapshot.data!.color!)
                        : HeyDoDoColors.secondary,
                  );
                }),
            const SizedBox(
              width: heyDoDoPadding,
            ),
            IconAction(
              onPressed: () {
                _onPickImage(group);
              },
              icon: Iconsax.gallery_add,
            ),
            const SizedBox(
              width: heyDoDoPadding,
            ),
            IconAction(
              onPressed: () {
                _onSaveGroup();
                Navigator.of(context).pop();
              },
              icon: Icons.save,
            ),
            const SizedBox(
              width: heyDoDoPadding + 5,
            )
          ],
        ),
        body: LayoutBuilder(
          builder: (context, contraints) => Container(
            decoration: const BoxDecoration(color: HeyDoDoColors.white),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 7.0),
              child: CustomScrollView(
                slivers: [
                  SliverPadding(
                      padding: const EdgeInsets.all(heyDoDoPadding),
                      sliver: SliverToBoxAdapter(
                          child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              _titleController.text,
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineSmall!
                                  .copyWith(
                                    color: HeyDoDoColors.light,
                                    fontSize: 18.0,
                                  ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              showDialog(
                                  context: context,
                                  builder: (context) => TitleEditDialog(
                                      oldText: _titleController.text,
                                      controller: _titleController));
                            },
                            child: const SizedBox(
                              width: 35.0,
                              height: 35.0,
                              child: Icon(Iconsax.edit),
                            ),
                          )
                        ],
                      ))),
                  const SliverToBoxAdapter(
                    child: SizedBox(height: heyDoDoPadding),
                  ),
                  StreamBuilder<GroupToDoEntity>(
                      stream: _bloC.stream,
                      builder: (context, snapshot) {
                        if (snapshot.data?.image == null) {
                          return const SliverToBoxAdapter(
                            child: SizedBox.shrink(),
                          );
                        }
                        return SliverAppBar(
                            automaticallyImplyLeading: false,
                            collapsedHeight: 240.0,
                            expandedHeight: 240.0,
                            flexibleSpace: ImageContainer(
                              image: snapshot.data?.image,
                              onImageTap: () => _onPickImage(group),
                              onImageDelete: () => _onDeleteImage(group),
                            ));
                      }),
                  const SliverToBoxAdapter(
                    child: SizedBox(height: heyDoDoPadding * 2),
                  ),
                  SliverToBoxAdapter(
                    child: GestureDetector(
                      onTap: () async {
                        await showDialog(
                            context: context,
                            builder: (context) =>
                                AddToDoDialog(controller: _todoController));

                        if (_todoController.text.isNotEmpty) {
                          _onSaveToDo(group);
                        }
                      },
                      child: Container(
                        constraints: const BoxConstraints(maxWidth: 140.0),
                        height: 40.0,
                        alignment: Alignment.center,
                        padding: const EdgeInsets.all(7.0),
                        decoration: BoxDecoration(
                            color: HeyDoDoColors.secondary,
                            borderRadius: BorderRadius.circular(24.0)),
                        child: const Text(
                          'Agregar tarea',
                          style: TextStyle(
                              color: HeyDoDoColors.white,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                  ),
                  TodoPaginatingStatus(bloC: _bloC),
                  const SliverToBoxAdapter(
                    child: SizedBox(height: heyDoDoPadding),
                  ),
                  SliverPadding(
                    padding: const EdgeInsets.only(bottom: 90.0),
                    sliver: StreamBuilder(
                      stream: _bloC.paginatorStream,
                      initialData: 0,
                      builder: (context, snap) {
                        if (snap.data == 0) {
                          return ListTodosPending(group: group);
                        }

                        return ListTodosCompleted(group: group);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
