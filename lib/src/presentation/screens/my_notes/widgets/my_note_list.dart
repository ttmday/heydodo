import 'package:flutter/material.dart';

import 'package:heydodo/src/domain/entities/note_entity.dart';

import 'package:heydodo/src/presentation/screens/my_notes/widgets/my_note_card.dart';

class MyNoteList extends StatelessWidget {
  const MyNoteList({
    super.key,
    required this.notes,
  });

  final List<NoteEntity> notes;

  @override
  Widget build(BuildContext context) {
    return SliverList.builder(
        itemCount: notes.length,
        itemBuilder: (context, index) {
          final note = notes[index];
          return MyNoteCard(note: note);
        });
  }
}
