import 'package:flutter/material.dart';
import 'package:heydodo/objectbox.g.dart';

import 'package:heydodo/src/domain/entities/colors_entity.dart';
import 'package:heydodo/src/infrastructure/colors_repository.dart';

class ColorsProvider extends ChangeNotifier {
  late final ColorsRepositoryStore _colorsRepositoryStore;

  List<ColorEntity> colors = [];

  ColorsProvider(Store store) {
    _colorsRepositoryStore = ColorsRepositoryStore(store);
  }

  Future<List<ColorEntity>> getAllColors() async {
    colors.clear();
    colors = await _colorsRepositoryStore.getColors();

    // colors.sort((_, b) {
    //   if (b.isFavorite || b.isFixed) {
    //     return 1;
    //   }

    //   return 0;
    // });

    notifyListeners();
    return colors;
  }

  write(ColorEntity color) {
    _colorsRepositoryStore.write(color);
    getAllColors();
  }

  remove(int id) {
    _colorsRepositoryStore.remove(id);
    getAllColors();
  }

  clear() {
    _colorsRepositoryStore.clear();
    getAllColors();
  }
}
