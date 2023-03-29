import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:puntodeventa_ver2/elements/product.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:collection/collection.dart';
import '../elements/sale.dart';

class VentaPage extends StatefulWidget {
  @override
  State<VentaPage> createState() => VentaPageState();
}

class VentaPageState extends State<VentaPage> {
  final TextEditingController codeController = TextEditingController();
  final List<Product> cartList = [];
  List<Product> productsList = Hive.box<Product>('productsbox').values.toList();
  var salesbox = Hive.box<Sale>('salesbox');

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> scanBarcodeNormal() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.BARCODE);
      codeController.text = barcodeScanRes;
      insertarProducto();
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {});
  }

  void insertarProducto() {
    var product = productsList.firstWhereOrNull((element) {
      return element.code == codeController.text;
    });
    if (product != null) {
      if (cartList.contains(product)) {
        product.quantity++;
        setState(() {});
      } else {
        cartList.add(product);
        setState(() {});
      }
    } else {
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Alerta'),
          content: const Text('El codigo ingresado no existe'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Ok'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    double total = 0;
    for (Product element in cartList) {
      total += (element.price * element.quantity);
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Total: \$$total',
          style: GoogleFonts.roboto(fontSize: 25),
        ),
      ),
      body: Column(
        children: [
          Row(
            children: [
              Expanded(
                  child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 30),
                child: TextField(
                  controller: codeController,
                  decoration: InputDecoration(
                    labelText: 'Codigo',
                  ),
                ),
              )),
              Padding(
                padding: EdgeInsets.only(right: 20),
                child: ElevatedButton(
                  onPressed: insertarProducto,
                  child: Icon(Icons.add_circle),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 1, 15, 207),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0))),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 15, 0),
                child: RotatedBox(
                  quarterTurns: 2,
                  child: ElevatedButton(
                    onPressed: () => scanBarcodeNormal(),
                    child: Icon(Icons.document_scanner),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 102, 201, 37),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0))),
                  ),
                ),
              )
            ],
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: cartList.map((e) {
                  return ListTile(
                    title: Text(e.name),
                    leading: Text(e.quantity.toString()),
                    subtitle: Text((e.quantity * e.price).toString()),
                    trailing: Container(
                      height: 100,
                      width: 150,
                      child: Row(
                        children: [
                          IconButton(
                              onPressed: () {
                                cartList.remove(e);
                                setState(() {});
                              },
                              icon: Icon(Icons.delete)),
                          IconButton(
                              onPressed: () {
                                e.quantity++;
                                setState(() {});
                              },
                              icon: Icon(Icons.add)),
                          IconButton(
                              onPressed: () {
                                e.quantity--;
                                setState(() {});
                              },
                              icon: Icon(Icons.remove)),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(5.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 52, 75, 15),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text('Confirmar Venta',
                      style: GoogleFonts.roboto(fontSize: 25)),
                  Icon(Icons.point_of_sale)
                ],
              ),
              onPressed: () {
                salesbox.add(Sale(
                    date: DateTime.now(),
                    shoppingcart: cartList,
                    total: total));
                Navigator.pop(context);
              },
            ),
          )
        ],
      ),
    );
  }
}
