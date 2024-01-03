import 'package:heydodo/objectbox.g.dart';
import 'package:heydodo/src/domain/entities/note_entity.dart';

class NoteRepositoryStore {
  final Box<NoteEntity> _noteBox;

  NoteRepositoryStore(Store store) : _noteBox = store.box<NoteEntity>();

  Future<List<NoteEntity>> getAllNotes() async {
    return _noteBox.getAll();
  }

  write(NoteEntity note) {
    _noteBox.put(note);
  }

  remove(int id) {
    _noteBox.remove(id);
  }

  clear() {
    _noteBox.removeAll();
  }

  update(NoteEntity note) {
    _noteBox.put(note);
  }
}
