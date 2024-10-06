import 'package:flutter/material.dart';
import 'package:food_recipes/src/database/food_database.dart';
import 'package:food_recipes/src/models/platillo_model.dart';
import 'package:food_recipes/src/models/ingredientes_model.dart';

class RecipeForm extends StatefulWidget {
  @override
  _RecipeFormState createState() => _RecipeFormState();
}

class _RecipeFormState extends State<RecipeForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _tiempoController = TextEditingController();
  final TextEditingController _tipoComidaController = TextEditingController();
  final TextEditingController _pasosController = TextEditingController();

  final List<Map<String, TextEditingController>> _ingredientesControllers = [];

  final DatabaseHelper _dbHelper = DatabaseHelper();

  @override
  void dispose() {
    _nombreController.dispose();
    _tiempoController.dispose();
    _tipoComidaController.dispose();
    _pasosController.dispose();
    _ingredientesControllers.forEach((controller) {
      controller['nombre']?.dispose();
      controller['cantidad']?.dispose();
    });
    super.dispose();
  }

  void _addIngredienteField() {
    setState(() {
      _ingredientesControllers.add({
        'nombre': TextEditingController(),
        'cantidad': TextEditingController(),
      });
    });
  }

  void _removeIngredienteField(int index) {
    setState(() {
      _ingredientesControllers.removeAt(index);
    });
  }

  void _saveRecipe() async {
    if (_formKey.currentState!.validate()) {
      // Guardar el platillo
      Platillo nuevoPlatillo = Platillo(
        nombre: _nombreController.text,
        tiempoPreparacion: int.parse(_tiempoController.text),
        tipoComida: _tipoComidaController.text,
        pasos: _pasosController.text,
      );

      int platilloId = await _dbHelper.insertPlatillo(nuevoPlatillo);
      print(
          'Platillo guardado con ID: $platilloId'); // Verificar el platillo ID

      // Guardar los ingredientes
      for (var controller in _ingredientesControllers) {
        String nombre = controller['nombre']!.text;
        String cantidad = controller['cantidad']!.text;

        // Verificar que los ingredientes no estén vacíos
        if (nombre.isEmpty || cantidad.isEmpty) {
          print('Error: Nombre o cantidad de ingrediente están vacíos');
          continue; // Salta si están vacíos
        }

        // Mensaje de depuración
        print('Guardando ingrediente: Nombre: $nombre, Cantidad: $cantidad');

        Ingrediente nuevoIngrediente = Ingrediente(
          nombre: nombre,
          cantidad: cantidad,
          platilloId: platilloId,
        );

        await _dbHelper.insertIngrediente(nuevoIngrediente);
      }

      // Limpia los campos después de guardar
      _nombreController.clear();
      _tiempoController.clear();
      _tipoComidaController.clear();
      _pasosController.clear();
      _ingredientesControllers.clear();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Platillo agregado con sus ingredientes')),
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
          child: ListView(
            children: [
              // Campos para los datos del platillo
              _buildTextFormField(_nombreController, 'Nombre del Platillo'),
              SizedBox(height: 16),
              _buildTextFormField(
                  _tiempoController, 'Tiempo de preparación (min)',
                  keyboardType: TextInputType.number),
              SizedBox(height: 16),
              _buildTextFormField(_tipoComidaController, 'Tipo de comida'),
              SizedBox(height: 16),
              _buildTextFormField(_pasosController, 'Pasos/Instrucciones',
                  maxLines: 4),
              SizedBox(height: 20),

              // Ingredientes dinámicos
              Text(
                'Ingredientes',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),

              ..._ingredientesControllers.asMap().entries.map((entry) {
                int index = entry.key;
                var controller = entry.value;
                return Padding(
                  padding: const EdgeInsets.only(top: 16.0), // Espacio superior
                  child: Row(
                    children: [
                      Expanded(
                        child: _buildTextFormField(
                            controller['nombre']!, 'Ingrediente'),
                      ),
                      SizedBox(
                          width: 16), // Espacio entre ingrediente y cantidad
                      Expanded(
                        child: _buildTextFormField(
                            controller['cantidad']!, 'Cantidad'),
                      ),
                      IconButton(
                        icon: Icon(Icons.remove_circle, color: Colors.red),
                        onPressed: () => _removeIngredienteField(index),
                      ),
                    ],
                  ),
                );
              }).toList(),

              // Botón para agregar más ingredientes
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: _addIngredienteField,
                child: Text('Agregar Ingrediente'),
              ),
              SizedBox(height: 20),

              // Botón de Guardar
              ElevatedButton(
                onPressed: _saveRecipe,
                child: Text('Guardar Platillo'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red, // Color rojo para el botón
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                  textStyle: TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextFormField(TextEditingController controller, String labelText,
      {TextInputType? keyboardType, int maxLines = 1}) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        border: OutlineInputBorder(),
      ),
      keyboardType: keyboardType,
      maxLines: maxLines,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Por favor ingresa $labelText';
        }
        return null;
      },
    );
  }
}
