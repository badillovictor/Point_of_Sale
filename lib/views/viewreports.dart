import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:pointofsale/widgets/salegrid.dart';
import '../elements/sale.dart';

class ReportGrid extends StatelessWidget {
  ReportGrid({Key? key});

  @override
  Widget build(BuildContext context) {
    List<Sale> salesbox = Hive.box<Sale>('salesbox').values.toList();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Reportes de Ventas',
          style: GoogleFonts.roboto(fontSize: 25),
        ),
      ),
      body: GridView.count(
        primary: false,
        padding: const EdgeInsets.all(20),
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        crossAxisCount: 2,
        children: salesbox.map((e) => getSaleGrid(e, context)).toList(),
      ),
      );
  }
}
