import 'package:flutter/material.dart';
import 'package:food_recipes/src/components/bottom_navbar.dart';
import 'package:food_recipes/src/screens/forms/recipe.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Map<String, dynamic>> recipes = [
    {
      'title': 'Hamburguesa Clásica',
      'image': 'assets/images/ensalada.jpg',
      'isFavorite': false,
    },
    {
      'title': 'Ensalada César',
      'image': 'assets/images/hotCakes.jpg',
      'isFavorite': false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mis Recetas'),
      ),
      bottomNavigationBar: MyBottomNavBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 16.0),
          ],
        ),
      ),
    );
  }
}
