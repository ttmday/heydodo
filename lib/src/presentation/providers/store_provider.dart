import 'package:objectbox/objectbox.dart';

class StoreProvider {
  late final Store _store;

  StoreProvider(Store store) : _store = store;

  close() {
    _store.close();
  }
}
