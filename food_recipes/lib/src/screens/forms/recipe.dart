import 'package:flutter/material.dart';

class Recipe extends StatefulWidget {
  const Recipe({super.key});

  @override
  State<Recipe> createState() => _RecipeState();
}

class _RecipeState extends State<Recipe> {
  // Controladores para los campos de Receta
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _tipoComidaController = TextEditingController();
  final TextEditingController _tiempoPreparacionController = TextEditingController();
  final TextEditingController _fotoController = TextEditingController();

  // Listas dinámicas para Ingredientes y Pasos
  List<Map<String, String>> _ingredientes = [];
  List<String> _pasos = [];

  // Controladores para los campos dinámicos
  final TextEditingController _ingredienteNombreController = TextEditingController();
  final TextEditingController _cantidadController = TextEditingController();
  final TextEditingController _pasoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white, // Cambia el color de la flecha de regreso
        ),
        title: const Text(
          'Crear Receta',
          style: TextStyle(
            color: Colors.white, // Cambia el color del título
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 158, 17, 17),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Detalles de la Receta',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            _buildTextField('Nombre de la receta', _nombreController),
            _buildTextField('Tipo de comida', _tipoComidaController),
            _buildTextField('Tiempo de preparación (min)', _tiempoPreparacionController, isNumber: true),
            _buildTextField('Foto (URL o archivo)', _fotoController),

            const SizedBox(height: 24),
            const Text(
              'Ingredientes',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: _buildTextField('Ingrediente', _ingredienteNombreController),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _buildTextField('Cantidad', _cantidadController),
                ),
                IconButton(
                  icon: const Icon(Icons.add, color: Colors.green),
                  onPressed: _agregarIngrediente,
                ),
              ],
            ),
            _buildIngredienteList(),

            const SizedBox(height: 24),
            const Text(
              'Pasos/Instrucciones',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: _buildTextField('Descripción del paso', _pasoController),
                ),
                IconButton(
                  icon: const Icon(Icons.add, color: Colors.green),
                  onPressed: _agregarPaso,
                ),
              ],
            ),
            _buildPasosList(),

            const SizedBox(height: 24),
            Center(
              child: ElevatedButton(
                onPressed: _guardarReceta,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 158, 17, 17),
                ),
                child: const Text(
                  'Guardar Receta',
                  style: TextStyle(
                    color: Colors.white, // Cambia el color del texto del botón
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget para crear un campo de texto reutilizable
  Widget _buildTextField(String label, TextEditingController controller, {bool isNumber = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: TextField(
        controller: controller,
        keyboardType: isNumber ? TextInputType.number : TextInputType.text,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
    );
  }

  // Función para agregar un ingrediente a la lista
  void _agregarIngrediente() {
    setState(() {
      _ingredientes.add({
        'nombre': _ingredienteNombreController.text,
        'cantidad': _cantidadController.text,
      });
      _ingredienteNombreController.clear();
      _cantidadController.clear();
    });
  }

  // Función para mostrar la lista de ingredientes
  Widget _buildIngredienteList() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: _ingredientes.length,
      itemBuilder: (context, index) {
        final ingrediente = _ingredientes[index];
        return ListTile(
          title: Text('${ingrediente['nombre']} - ${ingrediente['cantidad']}'),
          trailing: IconButton(
            icon: const Icon(Icons.delete, color: Colors.red),
            onPressed: () => setState(() => _ingredientes.removeAt(index)),
          ),
        );
      },
    );
  }

  // Función para agregar un paso a la lista
  void _agregarPaso() {
    setState(() {
      _pasos.add(_pasoController.text);
      _pasoController.clear();
    });
  }

  // Función para mostrar la lista de pasos
  Widget _buildPasosList() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: _pasos.length,
      itemBuilder: (context, index) {
        final paso = _pasos[index];
        return ListTile(
          title: Text('Paso ${index + 1}: $paso'),
          trailing: IconButton(
            icon: const Icon(Icons.delete, color: Colors.red),
            onPressed: () => setState(() => _pasos.removeAt(index)),
          ),
        );
      },
    );
  }

  // Función para guardar la receta
  void _guardarReceta() {
    // Aquí puedes implementar la lógica para guardar en las tablas correspondientes
    // usando un servicio de base de datos o una API.
    // Los datos que se deberían guardar son:
    // - Nombre de la receta (_nombreController.text)
    // - Tipo de comida (_tipoComidaController.text)
    // - Tiempo de preparación (_tiempoPreparacionController.text)
    // - Foto (_fotoController.text)
    // - Ingredientes (_ingredientes)
    // - Pasos (_pasos)
    print('Receta guardada');
  }
}
