import 'package:flutter/material.dart';

import 'paciente.dart';

class RegistrarPacientePage extends StatefulWidget {
  const RegistrarPacientePage({super.key});

  @override
  State<RegistrarPacientePage> createState() =>
      _RegistrarPacientePageState();
}

class _RegistrarPacientePageState
    extends State<RegistrarPacientePage> {
  final _formKey = GlobalKey<FormState>();

  final _nombresController = TextEditingController();
  final _apellidosController = TextEditingController();
  final _dniController = TextEditingController();
  final _telefonoController = TextEditingController();
  final _correoController = TextEditingController();
  final _direccionController = TextEditingController();

  DateTime? _fechaNacimiento;
  String? _sexo;

  @override
  void dispose() {
    _nombresController.dispose();
    _apellidosController.dispose();
    _dniController.dispose();
    _telefonoController.dispose();
    _correoController.dispose();
    _direccionController.dispose();

    super.dispose();
  }

  Future<void> _seleccionarFecha() async {
    final fecha = await showDatePicker(
      context: context,
      initialDate: DateTime(2000),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (fecha != null) {
      setState(() {
        _fechaNacimiento = fecha;
      });
    }
  }

  void _guardarPaciente() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (_fechaNacimiento == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Selecciona la fecha de nacimiento.',
          ),
        ),
      );

      return;
    }

    if (_sexo == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Selecciona el sexo.',
          ),
        ),
      );

      return;
    }

    final paciente = Paciente(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      nombres: _nombresController.text.trim(),
      apellidos: _apellidosController.text.trim(),
      dni: _dniController.text.trim(),
      fechaNacimiento: _fechaNacimiento!,
      sexo: _sexo!,
      telefono: _telefonoController.text.trim(),
      correo: _correoController.text.trim(),
      direccion: _direccionController.text.trim(),
    );

    Navigator.pop(context, paciente);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registrar paciente'),
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),

          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: 800,
              ),

              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(24),

                  child: Form(
                    key: _formKey,

                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,

                      children: [
                        const Text(
                          'Datos personales',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 25),

                        TextFormField(
                          controller: _nombresController,
                          decoration: const InputDecoration(
                            labelText: 'Nombres',
                            prefixIcon:
                                Icon(Icons.person),
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value == null ||
                                value.trim().isEmpty) {
                              return 'Ingresa los nombres';
                            }

                            return null;
                          },
                        ),

                        const SizedBox(height: 16),

                        TextFormField(
                          controller: _apellidosController,
                          decoration: const InputDecoration(
                            labelText: 'Apellidos',
                            prefixIcon:
                                Icon(Icons.person_outline),
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value == null ||
                                value.trim().isEmpty) {
                              return 'Ingresa los apellidos';
                            }

                            return null;
                          },
                        ),

                        const SizedBox(height: 16),

                        TextFormField(
                          controller: _dniController,
                          keyboardType:
                              TextInputType.number,
                          maxLength: 8,

                          decoration:
                              const InputDecoration(
                            labelText: 'DNI',
                            prefixIcon:
                                Icon(Icons.badge),
                            border: OutlineInputBorder(),
                            counterText: '',
                          ),

                          validator: (value) {
                            if (value == null ||
                                value.trim().isEmpty) {
                              return 'Ingresa el DNI';
                            }

                            if (value.trim().length != 8) {
                              return 'El DNI debe tener 8 dígitos';
                            }

                            if (!RegExp(
                              r'^[0-9]+$',
                            ).hasMatch(value.trim())) {
                              return 'El DNI solo debe contener números';
                            }

                            return null;
                          },
                        ),

                        const SizedBox(height: 16),

                        InkWell(
                          onTap: _seleccionarFecha,

                          child: InputDecorator(
                            decoration:
                                const InputDecoration(
                              labelText:
                                  'Fecha de nacimiento',
                              prefixIcon:
                                  Icon(Icons.calendar_today),
                              border:
                                  OutlineInputBorder(),
                            ),

                            child: Text(
                              _fechaNacimiento == null
                                  ? 'Seleccionar fecha'
                                  : '${_fechaNacimiento!.day.toString().padLeft(2, '0')}/'
                                      '${_fechaNacimiento!.month.toString().padLeft(2, '0')}/'
                                      '${_fechaNacimiento!.year}',
                            ),
                          ),
                        ),

                        const SizedBox(height: 16),

                        DropdownButtonFormField<String>(
                          initialValue: _sexo,

                          decoration:
                              const InputDecoration(
                            labelText: 'Sexo',
                            prefixIcon:
                                Icon(Icons.wc),
                            border:
                                OutlineInputBorder(),
                          ),

                          items: const [
                            DropdownMenuItem(
                              value: 'Masculino',
                              child: Text('Masculino'),
                            ),
                            DropdownMenuItem(
                              value: 'Femenino',
                              child: Text('Femenino'),
                            ),
                            DropdownMenuItem(
                              value: 'Otro',
                              child: Text('Otro'),
                            ),
                          ],

                          onChanged: (value) {
                            setState(() {
                              _sexo = value;
                            });
                          },
                        ),

                        const SizedBox(height: 30),

                        const Text(
                          'Información de contacto',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 20),

                        TextFormField(
                          controller: _telefonoController,
                          keyboardType:
                              TextInputType.phone,

                          decoration:
                              const InputDecoration(
                            labelText: 'Teléfono',
                            prefixIcon:
                                Icon(Icons.phone),
                            border:
                                OutlineInputBorder(),
                          ),
                        ),

                        const SizedBox(height: 16),

                        TextFormField(
                          controller: _correoController,
                          keyboardType:
                              TextInputType.emailAddress,

                          decoration:
                              const InputDecoration(
                            labelText: 'Correo electrónico',
                            prefixIcon:
                                Icon(Icons.email),
                            border:
                                OutlineInputBorder(),
                          ),
                        ),

                        const SizedBox(height: 16),

                        TextFormField(
                          controller: _direccionController,
                          maxLines: 2,

                          decoration:
                              const InputDecoration(
                            labelText: 'Dirección',
                            prefixIcon:
                                Icon(Icons.location_on),
                            border:
                                OutlineInputBorder(),
                          ),
                        ),

                        const SizedBox(height: 30),

                        Row(
                          mainAxisAlignment:
                              MainAxisAlignment.end,

                          children: [
                            OutlinedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child:
                                  const Text('Cancelar'),
                            ),

                            const SizedBox(width: 12),

                            ElevatedButton.icon(
                              onPressed: _guardarPaciente,
                              icon: const Icon(
                                Icons.save,
                              ),
                              label: const Text(
                                'Guardar paciente',
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}