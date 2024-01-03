import 'package:flutter/material.dart';
import 'package:heydodo/objectbox.g.dart';
import 'package:heydodo/src/domain/entities/note_entity.dart';
import 'package:heydodo/src/infrastructure/note_repository.dart';

class NoteProvider extends ChangeNotifier {
  late final NoteRepositoryStore _noteRepositoryStore;

  List<NoteEntity> notes = [];

  NoteProvider(Store store) {
    _noteRepositoryStore = NoteRepositoryStore(store);
  }

  Future<List<NoteEntity>> getAllNotes() async {
    notes.clear();
    notes = await _noteRepositoryStore.getAllNotes();

    notes.sort((_, b) {
      if (b.isFavorite || b.isFixed) {
        return 1;
      }

      return 0;
    });

    notifyListeners();
    return notes;
  }

  write(NoteEntity note) {
    _noteRepositoryStore.write(note);
    getAllNotes();
  }

  remove(int id) {
    _noteRepositoryStore.remove(id);
    getAllNotes();
  }

  clear() {
    _noteRepositoryStore.clear();
    getAllNotes();
  }
}
