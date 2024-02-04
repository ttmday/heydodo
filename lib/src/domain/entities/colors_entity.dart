import 'package:objectbox/objectbox.dart';

@Entity()
class ColorEntity {
  int id;
  int color;

  ColorEntity(
    this.color, {
    this.id = 0,
    DateTime? createAt,
  });
}
