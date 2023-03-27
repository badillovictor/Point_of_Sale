import 'package:hive_flutter/hive_flutter.dart';

@HiveType(typeId: 0)
class Product extends HiveObject {
  @HiveField(0)
  String code;
  @HiveField(1)
  String name;
  @HiveField(2)
  double price;
  @HiveField(3)
  String category;
  @HiveField(4)
  int quantity;

  Product({
    required this.code,
    required this.name,
    required this.price,
    required this.category,
    this.quantity = 0
  });
}

class ProductAdapter extends TypeAdapter<Product> {
  @override
  final int typeId = 0;

  @override
  Product read(BinaryReader reader){
    return Product(code: reader.read(), name: reader.read(), price: reader.read(), category: reader.read(), quantity: reader.read());
  }

  @override void write(BinaryWriter writer, Product obj) {
    writer.write(obj.code);
    writer.write(obj.name);
    writer.write(obj.price);
    writer.write(obj.category);
    writer.write(obj.quantity);
  }
}