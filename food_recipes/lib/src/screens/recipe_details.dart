import 'package:flutter/material.dart';
import 'package:food_recipes/src/database/food_database.dart'; // Asegúrate de importar tu DatabaseHelper
import 'package:food_recipes/src/models/ingredientes_model.dart'; // Asegúrate de importar tu modelo de Ingrediente
import 'package:food_recipes/src/models/platillo_model.dart'; // Importar el modelo de Platillo

class RecipeDetails extends StatefulWidget {
  final String nombre;
  final int platilloId; // ID del platillo para obtener los ingredientes

  const RecipeDetails(
      {Key? key, required this.nombre, required this.platilloId})
      : super(key: key);

  @override
  State<RecipeDetails> createState() => _RecipeDetailsState();
}

class _RecipeDetailsState extends State<RecipeDetails> {
  late DatabaseHelper _dbHelper;
  List<Ingrediente> _ingredientes = [];
  Platillo? _platillo; // Agregado para almacenar los detalles del platillo

  @override
  void initState() {
    super.initState();
    _dbHelper = DatabaseHelper();
    _loadIngredientes();
    _loadPlatillo(); // Cargar detalles del platillo
  }

  Future<void> _loadIngredientes() async {
    List<Ingrediente> ingredientes =
        await _dbHelper.getIngredientes(widget.platilloId);
    if (ingredientes.isEmpty) {
      print('No hay ingredientes para el platillo ID: ${widget.platilloId}');
    } else {
      print(
          'Ingredientes cargados: ${ingredientes.map((i) => i.nombre).toList()}');
    }
    setState(() {
      _ingredientes = ingredientes;
    });
  }

  Future<void> _loadPlatillo() async {
    // Cargar detalles del platillo
    Platillo platillo = (await _dbHelper.getPlatillos())
        .firstWhere((platillo) => platillo.id == widget.platilloId);
    setState(() {
      _platillo = platillo;
    });
    print(
        'Platillo cargado: ${platillo.nombre}, Tiempo: ${platillo.tiempoPreparacion}, Tipo: ${platillo.tipoComida}, Pasos: ${platillo.pasos}'); // Debug
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detalle de ${widget.nombre}"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _platillo == null // Verificar si el platillo se ha cargado
            ? Center(child: CircularProgressIndicator())
            : Column(
                children: [
                  Text(
                    _platillo!.nombre,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 36,
                      color: Color.fromARGB(255, 118, 0, 0),
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Tiempo de Preparación: ${_platillo!.tiempoPreparacion} minutos',
                    style: TextStyle(fontSize: 20),
                  ),
                  Text(
                    'Tipo de Comida: ${_platillo!.tipoComida}',
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Pasos:',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                      color: Color.fromARGB(255, 53, 53, 53),
                    ),
                  ),
                  Text(_platillo!.pasos, style: TextStyle(fontSize: 20)),
                  SizedBox(height: 20),
                  Text(
                    'Ingredientes',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                      color: Color.fromARGB(255, 53, 53, 53),
                    ),
                  ),
                  Expanded(
                    child: _ingredientes.isEmpty // Verifica si hay ingredientes
                        ? Center(
                            child: Text('No hay ingredientes disponibles.'))
                        : ListView.builder(
                            itemCount: _ingredientes.length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                title: Text(_ingredientes[index].nombre),
                                subtitle: Text(
                                    'Cantidad: ${_ingredientes[index].cantidad}'),
                              );
                            },
                          ),
                  ),
                ],
              ),
      ),
    );
  }
}
