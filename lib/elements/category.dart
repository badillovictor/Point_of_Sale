import 'package:hive_flutter/hive_flutter.dart';

@HiveType(typeId: 1)
class Category extends HiveObject {
  @HiveField(0)
  String description;

  Category({
    required this.description,
  });
}

class CategoryAdapter extends TypeAdapter<Category> {
  @override
  final int typeId = 1;

  @override
  Category read(BinaryReader reader) {
    return Category(description: reader.read());
  }

  @override
  void write(BinaryWriter writer, Category obj) {
    writer.write(obj.description);
  }
}