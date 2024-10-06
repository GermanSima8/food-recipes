import 'package:flutter/material.dart';
import 'package:food_recipes/src/components/bottom_navbar.dart';
import 'package:food_recipes/src/database/food_database.dart'; // Asegúrate de importar tu DatabaseHelper
import 'package:food_recipes/src/models/platillo_model.dart'; // Asegúrate de importar tu modelo Platillo

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
    _loadPlatillos(); // Recargar la lista de platillos después de eliminar
  }

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
                    margin: const EdgeInsets.symmetric(vertical: 8.0),
                    child: ListTile(
                      title: Text(platillo.nombre),
                      trailing: IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: () => _deletePlatillo(platillo.id!),
                      ),
                    ),
                  );
                },
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/recipe-form').then((_) {
            _loadPlatillos(); // Recargar la lista después de regresar
          });
        },
        child: Icon(Icons.add),
        tooltip: 'Agregar Receta',
      ),
    );
  }
}
