import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:puntodeventa_ver2/elements/provider.dart';
import 'package:puntodeventa_ver2/views/viewregisterproviders.dart';

class ProvidersPage extends StatefulWidget {
  const ProvidersPage({super.key});
  @override
  State<ProvidersPage> createState() => ProvidersPageState();
}

class ProvidersPageState extends State<ProvidersPage> {
  @override
  Widget build(BuildContext context) {
    var providersbox = Hive.box<Provider>('providersbox');

    List<Provider> providerslist =
        Hive.box<Provider>('providersbox').values.toList();

    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Lista de Proveedores',
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
                          Navigator.push(context,
                              MaterialPageRoute(builder: (c) {
                            return CreateProvider(name: '');
                          })).then((value) {
                            if (value != null) {
                              providersbox.add(value);
                              setState(() {});
                            }
                          });
                        })),
              ),
            ],
          ),
          Expanded(
            child: ListView(
              children: providerslist.map((provider) {
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
                          child: Text(provider.name,
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
                                    int position =
                                        providerslist.indexOf(provider);
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (c) {
                                      return CreateProvider(
                                          name: provider.name);
                                    })).then((value) {
                                      if (value != null) {
                                        providersbox.putAt(position, value);
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
                                  onPressed: () {},
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
