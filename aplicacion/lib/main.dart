import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MenuPrincipal(),
    );
  }
}

class MenuPrincipal extends StatelessWidget {
  const MenuPrincipal({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Menú Principal')),
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const PantallaCalendario(),
                        ),
                      );
                    },
                    child: const Text(
                      'Calendario',
                      style: TextStyle(fontSize: 30),
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const PantallaTareas(),
                        ),
                      );
                    },
                    child: const Text('Tareas', style: TextStyle(fontSize: 30)),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              const PantallaHorarioPastillas(),
                        ),
                      );
                    },
                    child: const Text(
                      'Horario de pastillas',
                      style: TextStyle(fontSize: 30),
                    ),
                  ),
                ],
              ),
            ),
          ),

          ElevatedButton(
            onPressed: () {
              //por ahora solo un boton, mas adelante se puede implementar la logica de salir de la app
              debugPrint("Botón salir del menú presionado");
            },
            child: const Text('Salir', style: TextStyle(fontSize: 20)),
          ),

          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

// Molde para no repetir la estructura base (título y botones) en cada vista.
class PlantillaPantalla extends StatelessWidget {
  final String titulo;
  final Widget contenidoCentro;

  const PlantillaPantalla({
    super.key,
    required this.titulo,
    required this.contenidoCentro,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // automaticallyImplyLeading en false oculta la flecha por defecto de Flutter
      appBar: AppBar(title: Text(titulo), automaticallyImplyLeading: false),
      body: Column(
        children: [
          Expanded(child: contenidoCentro),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Regresar', style: TextStyle(fontSize: 20)),
              ),
              ElevatedButton(
                onPressed: () {
                  //por ahora solo un boton, mas adelante se puede implementar la logica de salir de la app
                  debugPrint("Saliendo de la app...");
                },
                child: const Text('Salir', style: TextStyle(fontSize: 20)),
              ),
            ],
          ),

          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

class PantallaCalendario extends StatelessWidget {
  const PantallaCalendario({super.key});

  @override
  Widget build(BuildContext context) {
    return const PlantillaPantalla(
      titulo: 'Calendario',
      contenidoCentro: Center(
        child: Text('Aquí irá el calendario', style: TextStyle(fontSize: 24)),
      ),
    );
  }
}

class PantallaTareas extends StatelessWidget {
  const PantallaTareas({super.key});

  @override
  Widget build(BuildContext context) {
    return const PlantillaPantalla(
      titulo: 'Tareas',
      contenidoCentro: Center(
        child: Text(
          'Aquí irá la lista de tareas',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}

class PantallaHorarioPastillas extends StatelessWidget {
  const PantallaHorarioPastillas({super.key});

  @override
  Widget build(BuildContext context) {
    return const PlantillaPantalla(
      titulo: 'Horario de pastillas',
      contenidoCentro: Center(
        child: Text(
          'Aquí irá el horario de pastillas',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
