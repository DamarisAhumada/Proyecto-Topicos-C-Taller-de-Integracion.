import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:url_launcher/url_launcher.dart';

import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

List<Map<String, dynamic>> horarioDiario = [];
List<Map<String, dynamic>> listaTareas = [];
Map<DateTime, List<String>> citasGlobales = {};

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
    // Definimos un estilo común para que todos los botones del menú
    // tengan el mismo tamaño, color y forma, ideal para adultos mayores.
    final estiloBotonMenu = ElevatedButton.styleFrom(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
      backgroundColor: Colors.blue, // Fondo azul
      foregroundColor: Colors.white, // Letras e ícono blancos
      minimumSize: const Size(320, 80), // Mismo ancho y alto para todos
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15), // Bordes redondeados
      ),
    );

    return Scaffold(
      appBar: AppBar(title: const Text('Menú Principal')),
      body: Column(
        children: [
          Expanded(
            child: Center(
              // SingleChildScrollView evita errores si el teléfono tiene la pantalla pequeña
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton.icon(
                      style: estiloBotonMenu,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const PantallaCalendario(),
                          ),
                        );
                      },
                      icon: const Icon(Icons.calendar_month, size: 40),
                      label: const Text(
                        'Calendario',
                        style: TextStyle(fontSize: 28),
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton.icon(
                      style: estiloBotonMenu,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const PantallaTareas(),
                          ),
                        );
                      },
                      icon: const Icon(Icons.check_circle_outline, size: 40),
                      label: const Text(
                        'Tareas',
                        style: TextStyle(fontSize: 28),
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton.icon(
                      style: estiloBotonMenu,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                const PantallaHorarioPastillas(),
                          ),
                        );
                      },
                      icon: const Icon(Icons.medication, size: 40),
                      // Se acortó el texto para que encaje mejor con el ícono grande
                      label: const Text(
                        'Pastillas',
                        style: TextStyle(fontSize: 28),
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton.icon(
                      style: estiloBotonMenu,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const PantallaContactos(),
                          ),
                        );
                      },
                      icon: const Icon(Icons.contact_phone, size: 40),
                      label: const Text(
                        'Contactos',
                        style: TextStyle(fontSize: 28),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // El botón de salir también recibe su propio ícono y color diferencial
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red[100],
              foregroundColor: Colors.red[900],
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 30),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            onPressed: () {
              debugPrint("Botón salir del menú presionado");
            },
            icon: const Icon(Icons.exit_to_app, size: 30),
            label: const Text('Salir', style: TextStyle(fontSize: 22)),
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

class PantallaContactos extends StatelessWidget {
  const PantallaContactos({super.key});

  // Lista estática de contactos. Puedes agregar o modificar según lo que necesite tu familia.
  final List<Map<String, String>> contactos = const [
    {
      'nombre': 'Rodolfo',
      'relacion': 'Nieto / Hijo',
      'telefono': '+56912345678',
      'icono': 'person',
    },
    {
      'nombre': 'Ambulancia (SAMU)',
      'relacion': 'Emergencia Médica',
      'telefono': '131',
      'icono': 'medical_services',
    },
    {
      'nombre': 'Carabineros',
      'relacion': 'Emergencia Policial',
      'telefono': '133',
      'icono': 'local_police',
    },
    {
      'nombre': 'Bomberos',
      'relacion': 'Emergencia',
      'telefono': '132',
      'icono': 'fire_extinguisher',
    },
    {
      'nombre': 'Cesfam / Médico',
      'relacion': 'Consulta',
      'telefono': '+56612000000',
      'icono': 'local_hospital',
    },
  ];

  // Función asíncrona que le dice al teléfono que abra la app de llamadas
  Future<void> _hacerLlamada(String numero) async {
    final Uri url = Uri.parse('tel:$numero');
    if (!await launchUrl(url)) {
      debugPrint('No se pudo realizar la llamada al $numero');
    }
  }

  // Pequeña función para asignar íconos visuales según el tipo de contacto
  IconData _obtenerIcono(String nombreIcono) {
    switch (nombreIcono) {
      case 'medical_services':
        return Icons.medical_services;
      case 'local_police':
        return Icons.local_police;
      case 'fire_extinguisher':
        return Icons.fire_extinguisher;
      case 'local_hospital':
        return Icons.local_hospital;
      default:
        return Icons.person;
    }
  }

  @override
  Widget build(BuildContext context) {
    return PlantillaPantalla(
      titulo: 'Contactos Rápidos',
      contenidoCentro: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: contactos.length,
          itemBuilder: (context, index) {
            final contacto = contactos[index];
            return Card(
              margin: const EdgeInsets.symmetric(vertical: 10),
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.blue[100],
                    child: Icon(
                      _obtenerIcono(contacto['icono']!),
                      size: 35,
                      color: Colors.blue[800],
                    ),
                  ),
                  title: Text(
                    contacto['nombre']!,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    '${contacto['relacion']!}\n${contacto['telefono']!}',
                    style: const TextStyle(fontSize: 18),
                  ),
                  isThreeLine: true,
                  // Botón verde gigante para que sea imposible de fallar al presionar
                  trailing: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      shape: const CircleBorder(),
                      padding: const EdgeInsets.all(15),
                    ),
                    onPressed: () => _hacerLlamada(contacto['telefono']!),
                    child: const Icon(
                      Icons.call,
                      color: Colors.white,
                      size: 35,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class PantallaCalendario extends StatefulWidget {
  const PantallaCalendario({super.key});

  @override
  State<PantallaCalendario> createState() => _PantallaCalendarioState();
}

class _PantallaCalendarioState extends State<PantallaCalendario> {
  DateTime _diaEnfocado = DateTime.now();
  DateTime? _diaSeleccionado;
  CalendarFormat _formatoCalendario = CalendarFormat.month;

  // NUEVO: Controla qué rango de tiempo mostrar en la lista de abajo ('dia', 'semana', 'mes')
  String _modoVistaAgenda = 'dia';

  final TextEditingController _controladorCita = TextEditingController();

  @override
  void initState() {
    super.initState();
    _diaSeleccionado = _diaEnfocado;
  }

  // Se encarga de mostrar los puntitos en el calendario (no cambia)
  List<String> _obtenerCitasDelDia(DateTime dia) {
    final fechaClave = DateTime(dia.year, dia.month, dia.day);
    return citasGlobales[fechaClave] ?? [];
  }

  // NUEVO: Recopila y ordena las citas dependiendo de si elegiste Día, Semana o Mes
  List<String> _obtenerCitasListado() {
    List<MapEntry<DateTime, List<String>>> entradasFiltradas = [];

    if (_modoVistaAgenda == 'dia') {
      final fechaClave = DateTime(
        _diaSeleccionado!.year,
        _diaSeleccionado!.month,
        _diaSeleccionado!.day,
      );
      if (citasGlobales.containsKey(fechaClave)) {
        entradasFiltradas.add(MapEntry(fechaClave, citasGlobales[fechaClave]!));
      }
    } else if (_modoVistaAgenda == 'mes') {
      citasGlobales.forEach((fecha, citas) {
        if (fecha.year == _diaEnfocado.year &&
            fecha.month == _diaEnfocado.month) {
          entradasFiltradas.add(MapEntry(fecha, citas));
        }
      });
    } else if (_modoVistaAgenda == 'semana') {
      // Calcula desde el domingo hasta el sábado de la semana visible
      DateTime inicio = _diaEnfocado.subtract(
        Duration(days: _diaEnfocado.weekday % 7),
      );
      DateTime inicioSemana = DateTime(inicio.year, inicio.month, inicio.day);
      DateTime finSemana = inicioSemana.add(const Duration(days: 6));

      citasGlobales.forEach((fecha, citas) {
        if ((fecha.isAfter(inicioSemana) ||
                fecha.isAtSameMomentAs(inicioSemana)) &&
            (fecha.isBefore(finSemana) || fecha.isAtSameMomentAs(finSemana))) {
          entradasFiltradas.add(MapEntry(fecha, citas));
        }
      });
    }

    // Ordena las citas por fecha (de la más próxima a la más lejana)
    entradasFiltradas.sort((a, b) => a.key.compareTo(b.key));

    // Construye los textos finales
    List<String> listaFinal = [];
    for (var entrada in entradasFiltradas) {
      for (var cita in entrada.value) {
        if (_modoVistaAgenda == 'dia') {
          listaFinal.add(cita);
        } else {
          // Si es semana o mes, le agrega "Día X" antes para que sepas cuándo es
          listaFinal.add('Día ${entrada.key.day} • $cita');
        }
      }
    }

    return listaFinal;
  }

  // Tu función actual con el showTimePicker
  void _mostrarDialogoAgregarCita() {
    showDialog(
      context: context,
      builder: (context) {
        TimeOfDay horaSeleccionada = TimeOfDay.now();

        return StatefulBuilder(
          builder: (context, setStateDialogo) {
            return AlertDialog(
              title: const Text(
                'Agendar nueva cita',
                style: TextStyle(fontSize: 22),
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: _controladorCita,
                    decoration: const InputDecoration(
                      hintText: 'Ej: Kinesiólogo, Médico...',
                      border: OutlineInputBorder(),
                    ),
                    style: const TextStyle(fontSize: 20),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Hora: ${horaSeleccionada.format(context)}',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      ElevatedButton.icon(
                        onPressed: () async {
                          final TimeOfDay? horaElegida = await showTimePicker(
                            context: context,
                            initialTime: horaSeleccionada,
                          );
                          if (horaElegida != null) {
                            setStateDialogo(() {
                              horaSeleccionada = horaElegida;
                            });
                          }
                        },
                        icon: const Icon(Icons.access_time),
                        label: const Text('Elegir hora'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue[100],
                          foregroundColor: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    _controladorCita.clear();
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'Cancelar',
                    style: TextStyle(fontSize: 20, color: Colors.red),
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                  ),
                  onPressed: () {
                    if (_controladorCita.text.isEmpty ||
                        _diaSeleccionado == null)
                      return;

                    final fechaClave = DateTime(
                      _diaSeleccionado!.year,
                      _diaSeleccionado!.month,
                      _diaSeleccionado!.day,
                    );

                    final textoCitaConHora =
                        '${horaSeleccionada.format(context)} - ${_controladorCita.text}';

                    setState(() {
                      if (citasGlobales[fechaClave] != null) {
                        citasGlobales[fechaClave]!.add(textoCitaConHora);
                      } else {
                        citasGlobales[fechaClave] = [textoCitaConHora];
                      }
                    });

                    _controladorCita.clear();
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'Guardar',
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // Obtenemos las citas ya filtradas por el modo seleccionado
    final listaCitasVisibles = _obtenerCitasListado();

    // Título dinámico para reemplazar el "Agenda del..." estático
    String tituloAgenda = '';
    if (_modoVistaAgenda == 'dia') {
      tituloAgenda =
          'Agenda del ${_diaSeleccionado?.day}/${_diaSeleccionado?.month}/${_diaSeleccionado?.year}';
    } else if (_modoVistaAgenda == 'semana') {
      tituloAgenda = 'Agenda de la Semana';
    } else {
      tituloAgenda = 'Agenda del Mes';
    }

    return PlantillaPantalla(
      titulo: 'Calendario y Agenda',
      contenidoCentro: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _modoVistaAgenda == 'dia'
                        ? Colors.blue
                        : Colors.blue[100],
                  ),
                  onPressed: () {
                    setState(() {
                      _diaEnfocado = DateTime.now();
                      _diaSeleccionado = DateTime.now();
                      _formatoCalendario = CalendarFormat.week;
                      _modoVistaAgenda = 'dia'; // Regresa al filtro de hoy
                    });
                  },
                  child: Text(
                    'Ir a Hoy',
                    style: TextStyle(
                      fontSize: 18,
                      color: _modoVistaAgenda == 'dia'
                          ? Colors.white
                          : Colors.black,
                    ),
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _modoVistaAgenda == 'semana'
                        ? Colors.blue
                        : Colors.grey[300],
                  ),
                  onPressed: () => setState(() {
                    _formatoCalendario = CalendarFormat.week;
                    _modoVistaAgenda = 'semana'; // Activa el filtro semanal
                  }),
                  child: Text(
                    '7 Días',
                    style: TextStyle(
                      fontSize: 18,
                      color: _modoVistaAgenda == 'semana'
                          ? Colors.white
                          : Colors.black,
                    ),
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _modoVistaAgenda == 'mes'
                        ? Colors.blue
                        : Colors.grey[300],
                  ),
                  onPressed: () => setState(() {
                    _formatoCalendario = CalendarFormat.month;
                    _modoVistaAgenda = 'mes'; // Activa el filtro mensual
                  }),
                  child: Text(
                    'Mes',
                    style: TextStyle(
                      fontSize: 18,
                      color: _modoVistaAgenda == 'mes'
                          ? Colors.white
                          : Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ),

          TableCalendar(
            firstDay: DateTime.utc(2023, 1, 1),
            lastDay: DateTime.utc(2030, 12, 31),
            focusedDay: _diaEnfocado,
            calendarFormat: _formatoCalendario,
            selectedDayPredicate: (day) => isSameDay(_diaSeleccionado, day),
            eventLoader: _obtenerCitasDelDia,
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _diaSeleccionado = selectedDay;
                _diaEnfocado = focusedDay;
                _modoVistaAgenda = 'dia'; // Al tocar un día específico, muestra solo la agenda de ese día
              });
            },
            onFormatChanged: (format) {
              setState(() {
                _formatoCalendario = format;
              });
            },
            // NUEVO: Fundamental para que al deslizar el calendario hacia los lados (swipe) la lista de mes/semana se actualice
            onPageChanged: (focusedDay) {
              setState(() {
                _diaEnfocado = focusedDay;
              });
            },
            headerStyle: const HeaderStyle(
              formatButtonVisible: false,
              titleCentered: true,
              titleTextStyle: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            calendarStyle: const CalendarStyle(
              defaultTextStyle: TextStyle(fontSize: 18),
              weekendTextStyle: TextStyle(fontSize: 18, color: Colors.red),
              selectedTextStyle: TextStyle(fontSize: 18, color: Colors.white),
              todayTextStyle: TextStyle(fontSize: 18, color: Colors.white),
            ),
          ),

          const SizedBox(height: 10),

          Expanded(
            child: Container(
              padding: const EdgeInsets.all(16.0),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(20),
                ),
              ),
              child: Column(
                children: [
                  Text(
                    tituloAgenda, // NUEVO: Muestra el título dinámico
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Divider(thickness: 2),

                  Expanded(
                    child: listaCitasVisibles.isEmpty
                        ? const Center(
                            child: Text(
                              'No hay citas registradas.',
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.grey,
                              ),
                            ),
                          )
                        : ListView.builder(
                            itemCount: listaCitasVisibles.length,
                            itemBuilder: (context, index) {
                              return Card(
                                color: Colors.white,
                                margin: const EdgeInsets.symmetric(vertical: 5),
                                child: ListTile(
                                  leading: const Icon(
                                    Icons.medical_information,
                                    color: Colors.blue,
                                    size: 30,
                                  ),
                                  title: Text(
                                    listaCitasVisibles[index], // Usa la lista ya formateada
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                  ),

                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      padding: const EdgeInsets.symmetric(
                        vertical: 12,
                        horizontal: 20,
                      ),
                    ),
                    onPressed: _mostrarDialogoAgregarCita,
                    icon: const Icon(Icons.add, color: Colors.white, size: 28),
                    label: const Text(
                      'Agregar Cita',
                      style: TextStyle(fontSize: 22, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PantallaHorarioPastillas extends StatefulWidget {
  const PantallaHorarioPastillas({super.key});

  @override
  State<PantallaHorarioPastillas> createState() =>
      _PantallaHorarioPastillasState();
}

class _PantallaHorarioPastillasState extends State<PantallaHorarioPastillas> {
  // Eliminamos la variable 'horarioDiario' de aquí adentro para que
  // utilice correctamente la que creaste arriba de forma global.

  final TextEditingController _medicamentoController = TextEditingController();
  final TextEditingController _personaController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _cargarHorarioGuardado();
  }

  // ==========================================
  // FUNCIONES PARA GUARDAR Y CARGAR EN MEMORIA
  // ==========================================
  Future<void> _cargarHorarioGuardado() async {
    final prefs = await SharedPreferences.getInstance();
    String? datosGuardados = prefs.getString('mis_pastillas');

    if (datosGuardados != null) {
      List<dynamic> datosDecodificados = json.decode(datosGuardados);

      setState(() {
        // Limpiamos la lista global y la llenamos con lo guardado en el teléfono
        // Esto evita que se dupliquen al entrar y salir de la pantalla
        horarioDiario.clear();
        horarioDiario.addAll(
          datosDecodificados
              .map((item) => Map<String, dynamic>.from(item))
              .toList(),
        );
      });
    }
  }

  Future<void> _guardarHorarioEnTelefono() async {
    final prefs = await SharedPreferences.getInstance();
    String datosEnTexto = json.encode(horarioDiario);
    await prefs.setString('mis_pastillas', datosEnTexto);
  }
  // ==========================================

  void _mostrarDialogoAgregarRecordatorio() {
    TimeOfDay horaSeleccionada = TimeOfDay.now();

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setStateDialog) {
          return AlertDialog(
            title: const Text(
              'Nuevo Recordatorio',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: _medicamentoController,
                    decoration: const InputDecoration(
                      hintText: 'Medicamento (Ej: Losartán)',
                      border: OutlineInputBorder(),
                    ),
                    style: const TextStyle(fontSize: 20),
                  ),
                  const SizedBox(height: 15),
                  TextField(
                    controller: _personaController,
                    decoration: const InputDecoration(
                      hintText: 'Persona (Ej: Abuelo)',
                      border: OutlineInputBorder(),
                    ),
                    style: const TextStyle(fontSize: 20),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      const Text(
                        'Hora: ',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Expanded(
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue[100],
                            padding: const EdgeInsets.symmetric(vertical: 12),
                          ),
                          icon: const Icon(
                            Icons.access_time,
                            color: Colors.black,
                          ),
                          label: Text(
                            horaSeleccionada.format(context),
                            style: const TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                            ),
                          ),
                          onPressed: () async {
                            final TimeOfDay? seleccion = await showTimePicker(
                              context: context,
                              initialTime: horaSeleccionada,
                            );
                            if (seleccion != null) {
                              setStateDialog(() {
                                horaSeleccionada = seleccion;
                              });
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  _medicamentoController.clear();
                  _personaController.clear();
                  Navigator.pop(context);
                },
                child: const Text(
                  'Cancelar',
                  style: TextStyle(fontSize: 20, color: Colors.red),
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                onPressed: () {
                  if (_medicamentoController.text.isEmpty) return;

                  setState(() {
                    horarioDiario.add({
                      'medicamento': _medicamentoController.text,
                      'persona': _personaController.text.isEmpty
                          ? 'Familiar'
                          : _personaController.text,
                      'hora': horaSeleccionada.format(context),
                      'tomado': false,
                    });
                  });

                  // Guardamos en el teléfono inmediatamente
                  _guardarHorarioEnTelefono();

                  _medicamentoController.clear();
                  _personaController.clear();
                  Navigator.pop(context);
                },
                child: const Text(
                  'Guardar',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PlantillaPantalla(
      titulo: 'Horario de pastillas',
      contenidoCentro: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Registro de Hoy',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: horarioDiario.isEmpty
                ? const Center(
                    child: Text(
                      'No hay pastillas registradas aún.',
                      style: TextStyle(fontSize: 18, color: Colors.grey),
                    ),
                  )
                : ListView.builder(
                    itemCount: horarioDiario.length,
                    itemBuilder: (context, index) {
                      final item = horarioDiario[index];
                      return Card(
                        color: item['tomado'] ? Colors.green[50] : Colors.white,
                        margin: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        child: ListTile(
                          leading: Icon(
                            Icons.medication,
                            color: item['tomado']
                                ? Colors.green
                                : Colors.redAccent,
                            size: 35,
                          ),
                          title: Text(
                            item['medicamento'],
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              decoration: item['tomado']
                                  ? TextDecoration.lineThrough
                                  : TextDecoration.none,
                            ),
                          ),
                          subtitle: Text(
                            '${item['persona']} • ${item['hora']}',
                            style: const TextStyle(fontSize: 16),
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Checkbox(
                                value: item['tomado'],
                                activeColor: Colors.green,
                                visualDensity: const VisualDensity(
                                  horizontal: 2.0,
                                  vertical: 2.0,
                                ),
                                onChanged: (bool? valor) {
                                  setState(() {
                                    horarioDiario[index]['tomado'] =
                                        valor ?? false;
                                  });
                                  // Guardar al marcar o desmarcar
                                  _guardarHorarioEnTelefono();
                                },
                              ),
                              IconButton(
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                  size: 28,
                                ),
                                onPressed: () {
                                  setState(() {
                                    horarioDiario.removeAt(index);
                                  });
                                  // Guardar al eliminar un registro
                                  _guardarHorarioEnTelefono();
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _mostrarDialogoAgregarRecordatorio,
                icon: const Icon(
                  Icons.add_circle,
                  color: Colors.white,
                  size: 30,
                ),
                label: const Text(
                  'Agregar Recordatorio',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PantallaTareas extends StatefulWidget {
  const PantallaTareas({super.key});

  @override
  State<PantallaTareas> createState() => _PantallaTareasState();
}

class _PantallaTareasState extends State<PantallaTareas> {
  // Controlador para leer lo que se escribe en el campo de texto
  final TextEditingController _controladorTarea = TextEditingController();

  // Función para agregar una nueva tarea a la lista
  void _agregarTarea() {
    if (_controladorTarea.text.trim().isNotEmpty) {
      setState(() {
        listaTareas.add({
          'titulo': _controladorTarea.text.trim(),
          'completada': false,
        });
        _controladorTarea
            .clear(); // Limpia el campo de texto después de agregar
      });
    }
  }

  // Es buena práctica liberar el controlador cuando el widget se destruye
  @override
  void dispose() {
    _controladorTarea.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PlantillaPantalla(
      titulo: 'Tareas',
      contenidoCentro: Column(
        children: [
          // Sección superior: Campo de texto y botón para agregar
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controladorTarea,
                    decoration: const InputDecoration(
                      hintText: 'Escribe una nueva tarea...',
                      border: OutlineInputBorder(),
                    ),
                    // Permite agregar la tarea presionando "Enter" en el teclado
                    onSubmitted: (_) => _agregarTarea(),
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: _agregarTarea,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(16),
                  ),
                  child: const Icon(Icons.add),
                ),
              ],
            ),
          ),

          // Sección inferior: Lista de tareas
          Expanded(
            child: listaTareas.isEmpty
                ? const Center(
                    child: Text(
                      'No hay tareas pendientes',
                      style: TextStyle(fontSize: 18, color: Colors.grey),
                    ),
                  )
                : ListView.builder(
                    itemCount: listaTareas.length,
                    itemBuilder: (context, index) {
                      final tarea = listaTareas[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 6,
                        ),
                        child: CheckboxListTile(
                          title: Text(
                            tarea['titulo'],
                            style: TextStyle(
                              fontSize: 18,
                              // Tacha el texto si la tarea está completada
                              decoration: tarea['completada']
                                  ? TextDecoration.lineThrough
                                  : TextDecoration.none,
                              color: tarea['completada']
                                  ? Colors.grey
                                  : Colors.black,
                            ),
                          ),
                          value: tarea['completada'],
                          activeColor: Colors.blue,
                          controlAffinity: ListTileControlAffinity.leading,
                          onChanged: (bool? valor) {
                            // Actualiza el estado al marcar o desmarcar la casilla
                            setState(() {
                              listaTareas[index]['completada'] = valor ?? false;
                            });
                          },
                          // Botón opcional para eliminar la tarea
                          secondary: IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () {
                              setState(() {
                                listaTareas.removeAt(index);
                              });
                            },
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
