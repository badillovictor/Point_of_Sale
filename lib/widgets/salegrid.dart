import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:puntodeventa_ver2/views/viewsale.dart';
import 'package:intl/intl.dart';
import '../elements/sale.dart';

Widget getSaleGrid(Sale sale, BuildContext context) {
  return ElevatedButton(
      onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: ((context) {
          return ViewSale(sale: sale);
        })));
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(DateFormat('yyyy-MM-dd HH:mm:ss').format(sale.date),
          textAlign: TextAlign.center,
          style: GoogleFonts.openSans(fontSize: 22)),
          Text('\$${sale.total}',
          textAlign: TextAlign.center,
          style: GoogleFonts.openSans(fontSize: 30),)
        ],
      ));
}
