import 'package:flutter/material.dart';
import 'package:food_recipes/theme_data.dart';
import 'package:food_recipes/src/screens/auth/login_screen.dart';
import 'package:food_recipes/src/screens/home_screen.dart';
import 'package:food_recipes/src/screens/recipe_details.dart';
import 'package:food_recipes/src/screens/forms/recipe.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'FoodRecipes',
      color: const Color(0xFF3E7CB1),
      //Configuracion del tema
      theme: getThemeConfig(),
      // Configuracion de rutas
      initialRoute: '/',
      routes: {
        '/': (context) => const LoginScreen(),
        '/home': (context) => HomeScreen(),
        '/favorite': (context) => const RecipeDetails(),
        '/recipe-form': (context) =>   RecipeForm(),
      },
      
      // onUnknownRoute: (settings) {
      //   return MaterialPageRoute(builder: (context) => NotFoundScreen());
      // },
    );
  }
}
