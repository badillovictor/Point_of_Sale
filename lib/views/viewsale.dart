import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../elements/sale.dart';

class ViewSale extends StatelessWidget {
  ViewSale({Key? key, required this.sale});
  Sale sale;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Venta',
          style: GoogleFonts.roboto(fontSize: 25),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  sale.date.toString(),
                  style: GoogleFonts.openSans(fontSize: 22),
                ),
                Text(
                  '\$${sale.total}',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.openSans(fontSize: 30),
                )
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(5.0),
            child: SingleChildScrollView(
              child: Column(
                children: sale.shoppingcart.map((e) {
                  return ListTile(
                    title: Text(e.name, style: GoogleFonts.openSans(fontSize: 22)),
                    leading: Text(e.quantity.toString(), style: GoogleFonts.openSans(fontSize: 22)),
                    subtitle: Text('\$${e.quantity * e.price}', style: GoogleFonts.openSans(fontSize: 22)),
                  );
                }).toList(),
              ),
            ),
          )
        ],
      ),
    );
  }
}
