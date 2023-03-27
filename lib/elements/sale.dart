import 'package:hive_flutter/hive_flutter.dart';
import 'package:pointofsale/elements/product.dart';

@HiveType(typeId: 3)
class Sale {
  @HiveField(0)
  DateTime date;
  @HiveField(1)
  List<Product> shoppingcart;
  @HiveField(2)
  double total;

  Sale({
    required this.date,
    required this.shoppingcart,
    required this.total,
  });
}

class SaleAdapter extends TypeAdapter<Sale> {
  @override
  final int typeId = 3;

  @override
  Sale read(BinaryReader reader) {
    return Sale(
      date: reader.read(),
      shoppingcart: reader.read(),
      total: reader.read(),
    );
  }

  @override
  void write(BinaryWriter writer, Sale obj) {
    writer.write(obj.date);
    writer.write(obj.shoppingcart);
    writer.write(obj.total);
  }
  
}