import 'package:flutter/material.dart';
import 'package:food_recipes/src/database/food_database.dart';
import 'package:food_recipes/src/models/platillo_model.dart';

class RecipeForm extends StatefulWidget {
  @override
  _RecipeFormState createState() => _RecipeFormState();
}

class _RecipeFormState extends State<RecipeForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nombreController = TextEditingController();
  final DatabaseHelper _dbHelper = DatabaseHelper();

  void _saveRecipe() async {
    if (_formKey.currentState!.validate()) {
      String nombre = _nombreController.text;
      Platillo nuevoPlatillo = Platillo(nombre: nombre);
      await _dbHelper.insertPlatillo(nuevoPlatillo);

      // Limpia el campo después de guardar
      _nombreController.clear();

      // Muestra un mensaje de éxito
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Platillo agregado')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Agregar Platillo'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nombreController,
                decoration: InputDecoration(labelText: 'Nombre del Platillo'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingresa un nombre';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveRecipe,
                child: Text('Guardar Platillo'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}