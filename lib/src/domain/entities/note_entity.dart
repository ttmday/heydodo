import 'dart:typed_data';

import 'package:intl/intl.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class NoteEntity {
  int id;
  String note;

  DateTime createAt;
  String? title;
  bool isFavorite;
  bool isFixed;
  Uint8List? image;

  NoteEntity(this.note,
      {this.id = 0,
      DateTime? createAt,
      this.title,
      this.isFavorite = false,
      this.image,
      this.isFixed = false})
      : createAt = createAt ?? DateTime.now();

  String get dateFormatted => DateFormat('dd/MM/yyyy').format(createAt);
}
