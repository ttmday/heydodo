import 'package:flutter/material.dart';
import 'package:heydodo/src/config/constants/colors.dart';
import 'package:heydodo/src/config/constants/utils.dart';
import 'package:heydodo/src/domain/entities/note_entity.dart';
import 'package:heydodo/src/presentation/providers/note_provider.dart';
import 'package:heydodo/src/presentation/screens/my_notes/widgets/my_note_list.dart';
import 'package:heydodo/src/presentation/screens/screens.dart';
import 'package:heydodo/src/presentation/widgets/empty_list_message.dart';
import 'package:heydodo/src/presentation/widgets/floating_button.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

class MyNotesScreen extends StatefulWidget {
  const MyNotesScreen({super.key});

  @override
  State<MyNotesScreen> createState() => _MyNotesScreenState();
}

class _MyNotesScreenState extends State<MyNotesScreen>
    with AutomaticKeepAliveClientMixin {
  void _onCreateNewNote() {
    NoteEntity note = NoteEntity('');
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => NoteScreen(note: note)));
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      backgroundColor: HeyDoDoColors.white,
      body: Consumer<NoteProvider>(
        builder: (context, provider, _) {
          final notes = provider.notes;

          return CustomScrollView(
            slivers: [
              SliverAppBar(
                flexibleSpace: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: heyDoDoPadding * 3,
                      vertical: heyDoDoPadding * 2),
                  child: Text(
                    'Mis notas',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                ),
              ),
              notes.isNotEmpty
                  ? MyNoteList(notes: notes)
                  : EmptyListMessage(
                      message: 'Tu lista de notas esta vacia',
                      actionLabel: 'Crea tu primera nota',
                      onPressed: () {
                        _onCreateNewNote();
                      })
            ],
          );
        },
      ),
      floatingActionButton: HeyDoDoFloatingButton(
        onPressed: () {
          _onCreateNewNote();
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
