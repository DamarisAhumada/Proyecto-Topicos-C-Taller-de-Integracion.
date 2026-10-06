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
        appBar: AppBar(title: const Text('APP EN DESARROLLO')),
        body: Center(
          child: Column(
            mainAxisAlignment:
                MainAxisAlignment.center, // Centra todo en medio de la pantalla
            children: [
              //BOTON 1: CALENDARIO
              ElevatedButton(
                onPressed: () {
                  print("Botón de calendario presionado");
                },
                child: const Text('Calendario', style: TextStyle(fontSize: 30)),
              ),
              // Separador entre los botones
              const SizedBox(height: 20),

              // BOTON 2: TAREAS
              ElevatedButton(
                onPressed: () {
                  print("Botón de tareas presionado");
                },
                child: const Text('Tareas', style: TextStyle(fontSize: 30)),
              ),

              // Separador entre los botones
              const SizedBox(height: 20),

              // BOTON 3: HORARIO PASTILLAS
              ElevatedButton(
                onPressed: () {
                  print("Botón de horario de pastillas presionado");
                },
                child: const Text(
                  'Horario de pastillas',
                  style: TextStyle(fontSize: 30),
                ),
              ),
            ], // AQUÍ TERMINA LA LISTA
          ),
        ),
      ),
    );
  }
}
