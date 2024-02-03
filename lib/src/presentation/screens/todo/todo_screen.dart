import 'package:flutter/material.dart';
import 'package:heydodo/src/presentation/lib/helpers/image_picker.dart';
import 'package:heydodo/src/presentation/screens/todo/bloc/todo_bloc.dart';
import 'package:heydodo/src/presentation/screens/todo/widgets/list_todos_completed.dart';
import 'package:heydodo/src/presentation/screens/todo/widgets/list_todos_pending.dart';
import 'package:heydodo/src/presentation/screens/todo/widgets/todo.dart';
import 'package:heydodo/src/presentation/widgets/button.dart';
import 'package:heydodo/src/presentation/widgets/dialog.dart';
import 'package:heydodo/src/presentation/widgets/image_container.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

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

  _onDeleteImage(GroupToDoEntity group) {
    group.image = null;
    _bloC.update(group);

    context.read<GroupToDoProvider>().write(group);
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
        ),
        body: LayoutBuilder(
          builder: (context, contraints) => Container(
            decoration: const BoxDecoration(color: HeyDoDoColors.white),
            child: CustomScrollView(
              slivers: [
                StreamBuilder<GroupToDoEntity>(
                    stream: _bloC.stream,
                    builder: (context, snapshot) {
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
                  child: SizedBox(
                    height: heyDoDoPadding * 2,
                  ),
                ),
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
                          decoration: InputDecoration(
                              suffixIcon: _todoController.text.isNotEmpty
                                  ? IconButton(
                                      onPressed: () {
                                        _todoController.clear();
                                        setState(() {});
                                      },
                                      icon: const Icon(Icons.cancel,
                                          color: HeyDoDoColors.medium))
                                  : null,
                              enabledBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: HeyDoDoColors.secondary)),
                              focusedBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: HeyDoDoColors.secondary)),
                              errorBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: HeyDoDoColors.secondary))),
                        ),
                        const SizedBox(
                          height: heyDoDoPadding * 2,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            // StreamBuilder<int>(
                            //     stream: _bloC.newTodoWrittingStream,
                            //     initialData: 0,
                            //     builder: (context, snapshot) {
                            //       if (snapshot.data == 0) {
                            //         return const SizedBox.shrink();
                            //       }

                            //       return GestureDetector(
                            //         onTap: () {
                            //           _todoController.clear();
                            //           _bloC.setWrittingTodoStatus(0);
                            //         },
                            //         child: Container(
                            //           padding: const EdgeInsets.symmetric(
                            //               horizontal: heyDoDoPadding * 5,
                            //               vertical: heyDoDoPadding),
                            //           decoration: BoxDecoration(
                            //               color: HeyDoDoColors.medium,
                            //               borderRadius:
                            //                   BorderRadius.circular(24.0)),
                            //           child: const Text(
                            //             'Cancelar',
                            //             style: TextStyle(
                            //                 color: HeyDoDoColors.white,
                            //                 fontSize: 16.0,
                            //                 fontWeight: FontWeight.w500),
                            //           ),
                            //         ),
                            //       );
                            //     }),
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
                                    borderRadius: BorderRadius.circular(24.0)),
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
                  child: SizedBox(height: heyDoDoPadding * 2),
                ),
                SliverPadding(
                  padding: const EdgeInsets.all(heyDoDoPadding),
                  sliver: SliverToBoxAdapter(
                    child: SizedBox(
                      width: double.infinity,
                      child: StreamBuilder<int>(
                          stream: _bloC.paginatorStream,
                          initialData: 0,
                          builder: (context, snapshot) {
                            return Row(
                              children: [
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      _bloC.setCurrentPage(0);
                                    },
                                    child: SizedBox(
                                      child: Column(
                                        children: [
                                          Container(
                                            alignment: Alignment.center,
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 12.0,
                                                vertical: 12.0),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(12.0),
                                            ),
                                            child: Text(
                                              'Pendientes',
                                              style: TextStyle(
                                                color: snapshot.data == 0
                                                    ? HeyDoDoColors.medium
                                                    : HeyDoDoColors.white,
                                                fontSize: 18,
                                              ),
                                            ),
                                          ),
                                          AnimatedContainer(
                                            duration: const Duration(
                                                milliseconds: 450),
                                            width: snapshot.data == 0
                                                ? double.infinity
                                                : 0,
                                            height:
                                                snapshot.data == 0 ? 7.0 : 0,
                                            decoration: BoxDecoration(
                                                color: HeyDoDoColors.medium,
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        24.0)),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: heyDoDoPadding,
                                ),
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      _bloC.setCurrentPage(1);
                                    },
                                    child: SizedBox(
                                      child: Column(
                                        children: [
                                          Container(
                                            alignment: Alignment.center,
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 12.0,
                                                vertical: 12.0),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(12.0),
                                            ),
                                            child: Text(
                                              'Completados',
                                              style: TextStyle(
                                                color: snapshot.data == 1
                                                    ? HeyDoDoColors.medium
                                                        .withOpacity(.25)
                                                    : HeyDoDoColors.medium
                                                        .withOpacity(.15),
                                                fontSize: 18,
                                              ),
                                            ),
                                          ),
                                          AnimatedContainer(
                                              duration: const Duration(
                                                  milliseconds: 450),
                                              width: snapshot.data == 1
                                                  ? double.infinity
                                                  : 0,
                                              height:
                                                  snapshot.data == 1 ? 7.0 : 0,
                                              decoration: BoxDecoration(
                                                  color: HeyDoDoColors.medium,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          24.0))),
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            );
                          }),
                    ),
                  ),
                ),
                const SliverToBoxAdapter(
                  child: SizedBox(height: heyDoDoPadding),
                ),
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: 300.0,
                    child: PageView(
                      children: [
                        ListTodosPending(group: group),
                        ListTodosCompleted(group: group)
                      ],
                    ),
                  ),
                )
              ],
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
