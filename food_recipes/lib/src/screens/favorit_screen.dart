import 'package:flutter/material.dart';
import 'package:food_recipes/src/components/bottom_navbar.dart';
import 'package:food_recipes/src/models/platillo_model.dart'; // Asegúrate de importar tu modelo
import 'package:food_recipes/src/database/food_database.dart'; // Importa tu helper de base de datos

class FavoritScreen extends StatefulWidget {
  const FavoritScreen({super.key});

  @override
  State<FavoritScreen> createState() => _FavoritScreenState();
}

class _FavoritScreenState extends State<FavoritScreen> {
  late Future<List<Platillo>> _favoritos; // Variable para almacenar la lista de favoritos

  @override
  void initState() {
    super.initState();
    _favoritos = DatabaseHelper().getFavoritos(); // Cargar los favoritos al iniciar
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Recetas Favoritas'),
        automaticallyImplyLeading: false,
      ),
      bottomNavigationBar: MyBottomNavBar(),
      body: FutureBuilder<List<Platillo>>(
        future: _favoritos,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator()); // Mostrar un indicador de carga
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}')); // Manejar errores
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No hay recetas favoritas.')); // Mensaje si no hay favoritos
          } else {
            // Lista de favoritos
            final favoritos = snapshot.data!;
            return ListView.builder(
              itemCount: favoritos.length,
              itemBuilder: (context, index) {
                final platillo = favoritos[index];
                return ListTile(
                  title: Text(platillo.nombre),
                  subtitle: Text('Tiempo de preparación: ${platillo.tiempoPreparacion} min'),
                  trailing: IconButton(
                    icon: Icon(Icons.favorite, color: Color.fromARGB(255, 156, 17, 7)),
                    onPressed: () {
                      // Aquí puedes manejar el evento para eliminar de favoritos si lo deseas
                    },
                  ),
                  onTap: () {
                    // Aquí puedes manejar la navegación a la vista de detalles del platillo
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}
