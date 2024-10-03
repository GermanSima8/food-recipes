import 'package:flutter/material.dart';
import 'package:food_recipes/src/screens/home_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 158, 17, 17),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo
              const Image(
                image: AssetImage('assets/images/logo.png'),
                width: 300,
                height: 300,
                      ),
                  const Text(
                  "Bienvenido a Food Recipes",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),

              const SizedBox(height: 40),

              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const HomeScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 100, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  "Iniciar",
                  style: TextStyle(
                      color: Color.fromARGB(255, 0, 0, 0), fontSize: 18),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
