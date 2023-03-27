import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pointofsale/elements/category.dart';
import 'package:pointofsale/views/viewregistercategories.dart';

class CategoriesPage extends StatefulWidget {
  const CategoriesPage({super.key});
  @override
  State<CategoriesPage> createState() => CategoriesPageState();
}

class CategoriesPageState extends State<CategoriesPage> {
  @override
  Widget build(BuildContext context) {
    var categoriesbox = Hive.box<Category>('categoriesbox');

    List<Category> categorieslist =
        Hive.box<Category>('categoriesbox').values.toList();

    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Lista de Categorias',
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
                        Navigator.push(context, MaterialPageRoute(builder: (c) {
                          return CreateCategory(description: '');
                        })).then((value) {
                          if (value != null) {
                            categoriesbox.add(value);
                            setState(() {});
                          }
                        });
                      },
                    )),
              ),
            ],
          ),
          Expanded(
            child: ListView(
              children: categorieslist.map((category) {
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
                          padding:
                              const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 15.0),
                          child: Text(category.description,
                              style: GoogleFonts.roboto(fontSize: 22)),
                        )),
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
                                    int position = categorieslist.indexOf(category);
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (c) {
                                      return CreateCategory(description: category.description);
                                    })).then((value) {
                                      if (value != null) {
                                        categoriesbox.putAt(position, value);
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
                                  //Elimniar
                                  style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5.0)),
                                      backgroundColor:
                                          Color.fromARGB(255, 185, 25, 25)),
                                  onPressed: () {
                                    int position = categorieslist.indexOf(category);
                                    categoriesbox.deleteAt(position);
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
