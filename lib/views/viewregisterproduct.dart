import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:puntodeventa_ver2/elements/product.dart';
import 'package:string_validator/string_validator.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class CreateProduct extends StatefulWidget {
  final Product defaultProduct;
  final List<String> categoryList;
  final String defaultValue;

  const CreateProduct(
      {super.key, required this.defaultProduct, required this.categoryList, required this.defaultValue});

  @override
  CreateProductState createState() => CreateProductState(
        defaultProduct: this.defaultProduct,
        categoryList: this.categoryList,
        defaultValue: this.defaultValue
      );
}

class CreateProductState extends State<CreateProduct> {
  Product defaultProduct;
  final List<String> categoryList;

  CreateProductState(
      {required this.defaultProduct, required this.categoryList, required this.defaultValue});

  TextEditingController codeController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  String defaultValue;
  bool errorPrecio = false;

    // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> scanBarcodeNormal() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.BARCODE);
          defaultProduct.code = barcodeScanRes;
          setState(() {
          });
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    codeController.text = defaultProduct.code;
    nameController.text = defaultProduct.name;
    priceController.text = defaultProduct.price.toString();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Nueva Producto',
          style: GoogleFonts.roboto(fontSize: 25),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  flex: 3,
                  child: TextField(
                    controller: codeController,
                    decoration: const InputDecoration(
                        hintText: 'Ingrese el codigo del producto'),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: RotatedBox(
                    quarterTurns: 1,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                      child: ElevatedButton(
                        onPressed: () => scanBarcodeNormal(),
                        child: Icon(Icons.document_scanner),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromARGB(255, 1, 15, 207),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0))),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: nameController,
              decoration: const InputDecoration(
                  hintText: 'Ingrese el nombre del producto'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
                controller: priceController,
                decoration: const InputDecoration(
                    hintText: 'Ingrese el precio del producto'),
                onChanged: (value) {/*
                  if (isNumeric(value)) {
                    setState(() {
                      errorPrecio = false;
                      defaultProduct.price = double.parse(priceController.text);
                    });
                  } else {
                    setState(() {
                      errorPrecio = true;
                      priceController.text = priceController.text;
                    });
                  }*/
                }),
          ),
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: Expanded(
                child: DropdownButton<String>(
                  value: defaultValue,
                  icon: const Icon(Icons.arrow_downward),
                  elevation: 16,
                  style: const TextStyle(color: Colors.deepPurple),
                  underline: Container(
                    height: 2,
                    color: Colors.deepPurpleAccent,
                  ),
                  onChanged: (String? value) {
                    setState(() {
                      defaultProduct.code = codeController.text;
                      defaultProduct.name = nameController.text;
                      defaultProduct.price = toDouble(priceController.text);
                      defaultValue = value!;
                    });
                  },
                  items: categoryList.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(value: value, child: Text(value));
                  }).toList(),
                ),
              )),
          ElevatedButton(
              onPressed: () {
                Product product = Product(
                    code: codeController.text,
                    name: nameController.text,
                    price: double.parse(priceController.text),
                    category: defaultValue);
                Navigator.pop(context, product);
              },
              child: const Text('Guardar'))
        ],
      ),
    );
  }
}
