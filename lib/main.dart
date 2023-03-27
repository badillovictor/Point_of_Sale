import 'package:flutter/material.dart';
import 'package:pointofsale/elements/category.dart';
import 'package:pointofsale/elements/product.dart';
import 'package:pointofsale/elements/provider.dart';
import 'package:pointofsale/elements/sale.dart';
import 'package:pointofsale/views/viewmenu.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(ProductAdapter());
  Hive.registerAdapter(CategoryAdapter());
  Hive.registerAdapter(ProviderAdapter());
  Hive.registerAdapter(SaleAdapter());
  await Hive.openBox<Product>('productsbox');
  await Hive.openBox<Provider>('providersbox');
  await Hive.openBox<Category>('categoriesbox');
  await Hive.openBox<Sale>('salesbox');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Punto de Venta',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MenuPage(),
    );
  }
}
