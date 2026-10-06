import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: const Text('Menú Principal')),
        body: Center(
          // Botón principal de acceso al calendario
          child: ElevatedButton(
            onPressed: () {
              // TODO: Agregar navegación a la pantalla del calendario
              print("Botón de calendario presionado");
            },
            child: const Text(
              'Calendario',
              style: TextStyle(
                fontSize: 30, // Fuente ampliada para facilitar la lectura
              ),
            ),
          ),
        ),
      ),
    );
  }
}
