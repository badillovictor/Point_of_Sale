import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:puntodeventa_ver2/elements/category.dart';

class CreateCategory extends StatelessWidget {
  CreateCategory({Key? key, required this.description});
  String description;
  TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    descriptionController.text = description;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Nueva Categoria',
          style: GoogleFonts.roboto(fontSize: 25),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: descriptionController,
              decoration: const InputDecoration(
                hintText: 'Ingrese la descripción de la categoria'
              ),
            ),
          ),
          ElevatedButton(
            onPressed: (){
              Category category = Category(description: descriptionController.text);
              Navigator.pop(context, category);
            },
            child: const Text('Guardar'))
        ],
      ),
    );
  }
}
