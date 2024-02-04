import 'dart:async';

import 'package:heydodo/src/domain/entities/note_entity.dart';

class NoteBloC {
  late final StreamController<NoteEntity> _noteController;

  Stream<NoteEntity> get stream => _noteController.stream;

  init(NoteEntity note) {
    _noteController = StreamController<NoteEntity>.broadcast()..add(note);
  }

  update(NoteEntity note) {
    _noteController.add(note);
  }

  dispose() {
    _noteController.close();
  }
}
