import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:puntodeventa_ver2/views/viewcategories.dart';
import 'package:puntodeventa_ver2/views/viewproductos.dart';
import 'package:puntodeventa_ver2/views/viewproviders.dart';
import 'package:puntodeventa_ver2/views/viewreports.dart';
import 'package:puntodeventa_ver2/views/viewventa.dart';

class MenuPage extends StatelessWidget {
  MenuPage({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 100),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Punto de Venta',
                    style: GoogleFonts.firaSans(
                      fontSize: 50,
                    ),
                  )
                ],
              ),
            ),
            Container(
              height: 85,
              child: Row(
                children: [
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.only(left: 7.5),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 15, 113, 224),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                      onPressed: () {
                        Navigator.push(context, 
                        MaterialPageRoute(
                          builder: (c){
                            return ProductsPage();
                          }));
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 5),
                            child: Icon(Icons.inventory),
                          ),
                          Text(
                            'Productos',
                            style: GoogleFonts.inconsolata(
                              fontSize: 18,
                            ),
                          )
                        ],
                      ),
                    ),
                  )),
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 7.5),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 15, 113, 224),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                      onPressed: () {
                        Navigator.push(context, 
                        MaterialPageRoute(
                          builder: (c){
                            return CategoriesPage();
                          }));
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 5.0),
                            child: Icon(Icons.density_medium_rounded),
                          ),
                          Text(
                            'Categorias',
                            style: GoogleFonts.inconsolata(
                              fontSize: 18,
                            ),
                          )
                        ],
                      ),
                    ),
                  )),
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.only(right: 7.5),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 15, 113, 224),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                      onPressed: () {
                        Navigator.push(context, 
                        MaterialPageRoute(
                          builder: (c){
                            return ProvidersPage();
                          }));
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 5.0),
                            child: Icon(Icons.supervised_user_circle),
                          ),
                          Text(
                            'Proveedores',
                            style: GoogleFonts.inconsolata(
                              fontSize: 17.5,
                            ),
                          )
                        ],
                      ),
                    ),
                  ))
                ],
              ),
            ),
            Container(
              height: 175,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 7.5, vertical: 10.0),
                child: Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 46, 90, 46),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 7.5),
                          child: Icon(
                            Icons.sell_outlined,
                          ),
                        ),
                        Text(
                          'Nueva Venta',
                          style: GoogleFonts.inconsolata(
                            fontSize: 25,
                          ),
                        )
                      ],
                    ),
                    onPressed: () {
                      Navigator.push(context, 
                        MaterialPageRoute(
                          builder: (c){
                            return VentaPage();
                          }));
                    },
                  ),
                ),
              ),
            ),
            Container(
              height: 85,
              child: Row(
                children: [
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 7.5),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 86, 46, 180),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) {
                          return ReportGrid();
                        },));
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 5),
                            child: Icon(Icons.wysiwyg),
                          ),
                          Text(
                            'Registro de Ventas',
                            style: GoogleFonts.inconsolata(
                              fontSize: 18,
                            ),
                          )
                        ],
                      ),
                    ),
                  )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
