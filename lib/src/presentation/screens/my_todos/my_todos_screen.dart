import 'package:flutter/material.dart';
import 'package:heydodo/src/config/constants/colors.dart';
import 'package:heydodo/src/config/constants/utils.dart';
import 'package:heydodo/src/domain/entities/todo_entity.dart';
import 'package:heydodo/src/presentation/providers/group_todo_provider.dart';
import 'package:heydodo/src/presentation/screens/my_todos/widgets/my_todo_list.dart';
import 'package:heydodo/src/presentation/screens/screens.dart';
import 'package:heydodo/src/presentation/widgets/empty_list_message.dart';
import 'package:heydodo/src/presentation/widgets/floating_button.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

class MyToDosScreen extends StatefulWidget {
  const MyToDosScreen({super.key});

  @override
  State<MyToDosScreen> createState() => _MyNotesScreenState();
}

class _MyNotesScreenState extends State<MyToDosScreen>
    with AutomaticKeepAliveClientMixin {
  void _onCreateNewToDo() {
    GroupToDoEntity groupToDo = GroupToDoEntity();

    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => ToDoScreen(groupToDo: groupToDo)));
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      backgroundColor: HeyDoDoColors.white,
      body: Consumer<GroupToDoProvider>(
        builder: (context, provider, _) {
          final groups = provider.groups;

          return CustomScrollView(
            slivers: [
              SliverAppBar(
                flexibleSpace: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: heyDoDoPadding * 3,
                      vertical: heyDoDoPadding * 2),
                  child: Text(
                    'Mis toDos',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                ),
              ),
              groups.isNotEmpty
                  ? MyGroupToDoList(groups: groups)
                  : EmptyListMessage(
                      message: 'Tu lista de ToDos esta vacia',
                      actionLabel: 'Crea tu primer ToDo',
                      onPressed: () {
                        _onCreateNewToDo();
                      })
            ],
          );
        },
      ),
      floatingActionButton: HeyDoDoFloatingButton(
        onPressed: () {
          _onCreateNewToDo();
        },
        child: const SizedBox(
          child: Icon(
            Iconsax.add,
            size: heyDoDoPadding * 4,
            color: HeyDoDoColors.light,
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
