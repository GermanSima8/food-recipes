import 'package:flutter/material.dart';
import 'package:food_recipes/src/components/bottom_navbar.dart';
import 'package:food_recipes/src/database/food_database.dart';
import 'package:food_recipes/src/models/platillo_model.dart';
import 'package:food_recipes/src/models/ingredientes_model.dart'; // Importar el modelo de Ingrediente
import 'package:food_recipes/src/screens/recipe_details.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late DatabaseHelper _dbHelper;
  List<Platillo> _platillos = [];

  @override
  void initState() {
    super.initState();
    _dbHelper = DatabaseHelper();
    _loadPlatillos();
  }

  Future<void> _loadPlatillos() async {
    List<Platillo> platillos = await _dbHelper.getPlatillos();
    setState(() {
      _platillos = platillos;
    });
  }

  Future<void> _deletePlatillo(int id) async {
    await _dbHelper.deletePlatillo(id);
    _loadPlatillos();
  }

  // Método para obtener los ingredientes relacionados a un platillo
  Future<List<Ingrediente>> _getIngredientes(int platilloId) async {
    return await _dbHelper.getIngredientes(
        platilloId); // Método que debes tener en tu DatabaseHelper para obtener ingredientes
  }

  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mis Recetas'),
      ),
      bottomNavigationBar: MyBottomNavBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _platillos.isEmpty
            ? Center(child: Text('No hay platillos agregados'))
            : ListView.builder(
                itemCount: _platillos.length,
                itemBuilder: (context, index) {
                  final platillo = _platillos[index];
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    elevation: 4,
                    margin: const EdgeInsets.symmetric(vertical: 10.0),
                    child: InkWell(
                      onTap: () async {
                        // Navegar a la pantalla de detalles pasando todos los datos
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => RecipeDetails(
                              nombre: platillo.nombre,
                              platilloId:
                                  platillo.id!, // Pasar el ID del platillo
                            ),
                          ),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Center(
                              child: Text(
                                platillo.nombre,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                IconButton(
                                  icon: Icon(
                                    isFavorite
                                        ? Icons.favorite
                                        : Icons.favorite_border,
                                    color: isFavorite
                                        ? Color.fromARGB(255, 156, 17, 7)
                                        : Colors.grey,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      isFavorite = !isFavorite;
                                    });
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          isFavorite
                                              ? 'Añadido a favoritos'
                                              : 'Eliminado de favoritos',
                                        ),
                                      ),
                                    );
                                  },
                                ),
                                SizedBox(width: 20),
                                IconButton(
                                  icon: Icon(Icons.delete,
                                      color: Color.fromARGB(255, 62, 62, 62)),
                                  onPressed: () =>
                                      _deletePlatillo(platillo.id!),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/recipe-form').then((_) {
            _loadPlatillos();
          });
        },
        child: Icon(Icons.add),
        tooltip: 'Agregar Receta',
      ),
    );
  }
}
