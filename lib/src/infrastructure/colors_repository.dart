import 'package:heydodo/objectbox.g.dart';
import 'package:heydodo/src/domain/entities/colors_entity.dart';

class ColorsRepositoryStore {
  final Box<ColorEntity> _colorsBox;

  ColorsRepositoryStore(Store store) : _colorsBox = store.box<ColorEntity>();

  Future<List<ColorEntity>> getColors() async {
    return _colorsBox.getAll();
  }

  write(ColorEntity color) {
    _colorsBox.put(color);
  }

  remove(int id) {
    _colorsBox.remove(id);
  }

  clear() {
    _colorsBox.removeAll();
  }

  update(ColorEntity color) {
    _colorsBox.put(color);
  }
}
