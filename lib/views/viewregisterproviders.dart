import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:puntodeventa_ver2/elements/provider.dart';

class CreateProvider extends StatelessWidget {
  CreateProvider({Key? key, required this.name});
  String name;
  TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    nameController.text = name;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Nuevo Proveedor',
          style: GoogleFonts.roboto(fontSize: 25),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: nameController,
              decoration: const InputDecoration(
                hintText: 'Ingrese el nombre del proveedor'
              ),
            ),
          ),
          ElevatedButton(
            onPressed: (){
              Provider provider = Provider(name: nameController.text);
              Navigator.pop(context, provider);
            },
            child: const Text('Guardar'))
        ],
      ),
    );
  }
}
