import 'package:hive_flutter/hive_flutter.dart';

@HiveType(typeId: 2)
class Provider extends HiveObject {
  @HiveField(0)
  String name;

  Provider({
    required this.name,
  });
}

class ProviderAdapter extends TypeAdapter<Provider> {
  @override
  final int typeId = 2;

  @override
  Provider read(BinaryReader reader) {
    return Provider(name: reader.read());
  }

  @override
  void write(BinaryWriter writer, Provider obj) {
    writer.write(obj.name);
  }
}