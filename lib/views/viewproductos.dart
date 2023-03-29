import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:puntodeventa_ver2/elements/product.dart';
import 'package:puntodeventa_ver2/views/viewregisterproduct.dart';

import '../elements/category.dart';

class ProductsPage extends StatefulWidget {
  const ProductsPage({super.key});
  @override
  State<ProductsPage> createState() => ProductsPageState();
}

class ProductsPageState extends State<ProductsPage> {
  @override
  Widget build(BuildContext context) {
    var productsbox = Hive.box<Product>('productsbox');
    var categoriesbox = Hive.box<Category>('categoriesbox');

    List<Category> categoryList =
        Hive.box<Category>('categoriesbox').values.toList();
    List<String> categoryStringList = categoryList.map((e) {
      return e.description;
    }).toList();
    List<Product> productslist =
        Hive.box<Product>('productsbox').values.toList();

    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Lista de Productos',
            style: GoogleFonts.roboto(fontSize: 25),
          ),
        ),
        body: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          Row(
            children: [
              Expanded(
                child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 7.5, vertical: 10.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromARGB(255, 10, 138, 116),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0))),
                      child: Icon(
                        Icons.add,
                      ),
                      onPressed: () {
                        if (categoryStringList.isNotEmpty) {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (c) {
                            return CreateProduct(
                                defaultProduct: Product(
                                    code: '',
                                    name: '',
                                    price: 0.0,
                                    category: categoryStringList.first),
                                categoryList: categoryStringList,
                                defaultValue: categoryStringList.first);
                          })).then((value) {
                            if (value != null) {
                              productsbox.add(value);
                              setState(() {});
                            }
                          });
                        } else {
                          showDialog<String>(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                              title: const Text('Alerta'),
                              content: const Text('No existen categorias, por favor registre al menos una'),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () =>
                                      Navigator.pop(context),
                                  child: const Text('Ok'),
                                ),
                              ],
                            ),
                          );
                        }
                      },
                    )),
              ),
            ],
          ),
          Expanded(
            child: ListView(
              children: productslist.map((product) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration:
                        const BoxDecoration(color: Colors.white, boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: 5.0,
                        spreadRadius: 2.5,
                      )
                    ]),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ListTile(
                            title: Padding(
                              padding: const EdgeInsets.fromLTRB(
                                  0.0, 10.0, 0.0, 15.0),
                              child: Text(product.name,
                                  style: GoogleFonts.roboto(fontSize: 22)),
                            ),
                            subtitle: Text(product.quantity.toString(),
                                style: GoogleFonts.roboto(fontSize: 22)),
                            trailing: Text("\$" + product.price.toString(),
                                style: GoogleFonts.roboto(fontSize: 22))),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 7.5, vertical: 0.0),
                              child: Expanded(
                                child: ElevatedButton(
                                  //Editar
                                  style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5.0)),
                                      backgroundColor:
                                          Color.fromARGB(255, 185, 25, 25)),
                                  onPressed: () {
                                    int position =
                                        productslist.indexOf(product);
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (c) {
                                      return CreateProduct(
                                          defaultProduct: product,
                                          categoryList: categoryStringList,
                                          defaultValue:
                                              categoryStringList.first);
                                    })).then((value) {
                                      if (value != null) {
                                        productsbox.putAt(position, value);
                                        setState(() {});
                                      }
                                    });
                                  },
                                  child: Icon(Icons.border_color_outlined),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 7.5),
                              child: Expanded(
                                child: ElevatedButton(
                                  //Eliminar
                                  style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5.0)),
                                      backgroundColor:
                                          Color.fromARGB(255, 185, 25, 25)),
                                  onPressed: () {
                                    int position =
                                        productslist.indexOf(product);
                                    productsbox.deleteAt(position);
                                    setState(() {});
                                  },
                                  child: Icon(Icons.delete_forever),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          )
        ]));
  }
}
