import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:heydodo/src/config/constants/colors.dart';
import 'package:heydodo/src/config/constants/utils.dart';
import 'package:heydodo/src/domain/entities/note_entity.dart';
import 'package:heydodo/src/presentation/providers/note_provider.dart';
import 'package:heydodo/src/presentation/screens/my_notes/widgets/my_note_list.dart';
import 'package:heydodo/src/presentation/screens/screens.dart';
import 'package:heydodo/src/presentation/widgets/empty_list_message.dart';
import 'package:heydodo/src/presentation/lib/animations/slide_right_to_left_route_animation.dart';

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
        .push(slideRightToLeftRouteAnimation(NoteScreen(note: note)));
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
    );
  }

  @override
  bool get wantKeepAlive => true;
}
