import 'dart:typed_data';

import 'package:intl/intl.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class GroupToDoEntity {
  int id;
  String? description;

  DateTime createAt;
  String? title;
  bool? isFavorite;
  bool? isFixed;
  Uint8List? image;

  @Backlink()
  final todos = ToMany<ToDoEntity>();

  GroupToDoEntity(
      {this.id = 0,
      this.description,
      DateTime? createAt,
      this.title,
      this.isFavorite,
      this.image,
      this.isFixed})
      : createAt = createAt ?? DateTime.now();

  String get dateFormatted => DateFormat('dd/MM/yyyy').format(createAt);
}

@Entity()
class ToDoEntity {
  int id;
  String text;

  DateTime createAt;

  bool? isCompleted;
  final group = ToOne<GroupToDoEntity>();

  ToDoEntity(this.text,
      {this.id = 0, DateTime? createAt, this.isCompleted = false})
      : createAt = createAt ?? DateTime.now();

  String get dateFormatted => DateFormat('dd/MM/yyyy').format(createAt);
}
