import 'dart:async';

import 'package:heydodo/src/domain/entities/note_entity.dart';

class NoteBloC {
  final StreamController<NoteEntity> _noteController =
      StreamController<NoteEntity>();

  Stream<NoteEntity> get stream => _noteController.stream;

  init(NoteEntity note) {
    _noteController.add(note);
  }

  update(NoteEntity note) {
    _noteController.add(note);
  }

  dispose() {
    _noteController.close();
  }
}
