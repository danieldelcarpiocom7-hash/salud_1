import 'package:flutter/material.dart';
import 'paciente.dart';
import 'registrar_paciente_page.dart';
import 'paciente_detail_page.dart';

class PacientesPage extends StatefulWidget {
  const PacientesPage({super.key});

  @override
  State<PacientesPage> createState() => _PacientesPageState();
}

class _PacientesPageState extends State<PacientesPage> {
  final TextEditingController _buscarController =
      TextEditingController();

  final List<Paciente> _pacientes = [
    Paciente(
      id: '1',
      nombres: 'Juan',
      apellidos: 'Pérez',
      dni: '74563218',
      fechaNacimiento: DateTime(1991, 5, 12),
      sexo: 'Masculino',
      telefono: '999999999',
      correo: 'juan@email.com',
      direccion: 'Lima',
    ),
    Paciente(
      id: '2',
      nombres: 'María',
      apellidos: 'López',
      dni: '72345671',
      fechaNacimiento: DateTime(1984, 8, 20),
      sexo: 'Femenino',
      telefono: '988888888',
      correo: 'maria@email.com',
      direccion: 'Lima',
    ),
    Paciente(
      id: '3',
      nombres: 'Pedro',
      apellidos: 'García',
      dni: '71234567',
      fechaNacimiento: DateTime(1978, 2, 15),
      sexo: 'Masculino',
      telefono: '977777777',
      correo: 'pedro@email.com',
      direccion: 'Lima',
    ),
  ];

  String _busqueda = '';

  @override
  void dispose() {
    _buscarController.dispose();
    super.dispose();
  }

  List<Paciente> get _pacientesFiltrados {
    if (_busqueda.trim().isEmpty) {
      return _pacientes;
    }

    final texto = _busqueda.toLowerCase().trim();

    return _pacientes.where((paciente) {
      return paciente.nombreCompleto
              .toLowerCase()
              .contains(texto) ||
          paciente.dni.contains(texto);
    }).toList();
  }

  Future<void> _registrarPaciente() async {
    final paciente = await Navigator.push<Paciente>(
      context,
      MaterialPageRoute(
        builder: (_) => const RegistrarPacientePage(),
      ),
    );

    if (paciente == null) {
      return;
    }

    setState(() {
      _pacientes.add(paciente);
    });

    if (!mounted) {
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => PacienteDetailPage(
          paciente: paciente,
        ),
      ),
    );
  }

  void _abrirPaciente(Paciente paciente) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => PacienteDetailPage(
          paciente: paciente,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final pacientes = _pacientesFiltrados;

    return Scaffold(
      backgroundColor: const Color(0xFFF6F8FA),

      appBar: AppBar(
        title: const Text(
          'Mis pacientes',
          style: TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: Colors.white,
        foregroundColor: const Color(0xFF1F2937),
        elevation: 0,
        surfaceTintColor: Colors.white,
      ),

      floatingActionButton: FloatingActionButton.extended(
        onPressed: _registrarPaciente,
        backgroundColor: const Color(0xFF1565C0),
        foregroundColor: Colors.white,
        elevation: 4,
        icon: const Icon(Icons.person_add),
        label: const Text(
          'Nuevo paciente',
          style: TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
      ),

      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(
              20,
              20,
              20,
              10,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Pacientes',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF172033),
                  ),
                ),

                const SizedBox(height: 5),

                Text(
                  'Busca y administra la información de tus pacientes.',
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 15,
                  ),
                ),

                const SizedBox(height: 20),

                TextField(
                  controller: _buscarController,
                  onChanged: (valor) {
                    setState(() {
                      _busqueda = valor;
                    });
                  },
                  decoration: InputDecoration(
                    hintText: 'Buscar por nombre o DNI',
                    hintStyle: TextStyle(
                      color: Colors.grey.shade500,
                    ),

                    prefixIcon: const Icon(
                      Icons.search,
                      color: Color(0xFF546E7A),
                    ),

                    suffixIcon: _busqueda.isNotEmpty
                        ? IconButton(
                            onPressed: () {
                              _buscarController.clear();

                              setState(() {
                                _busqueda = '';
                              });
                            },
                            icon: const Icon(
                              Icons.clear,
                              color: Color(0xFF546E7A),
                            ),
                          )
                        : null,

                    filled: true,
                    fillColor: Colors.white,

                    contentPadding:
                        const EdgeInsets.symmetric(
                      vertical: 17,
                      horizontal: 16,
                    ),

                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: Colors.grey.shade300,
                      ),
                    ),

                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: Colors.grey.shade300,
                      ),
                    ),

                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                        color: Color(0xFF1565C0),
                        width: 1.5,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          Expanded(
            child: pacientes.isEmpty
                ? _buildSinResultados()
                : ListView.builder(
                    padding: const EdgeInsets.fromLTRB(
                      20,
                      10,
                      20,
                      100,
                    ),
                    itemCount: pacientes.length,
                    itemBuilder: (context, index) {
                      final paciente = pacientes[index];

                      return _buildPacienteCard(paciente);
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildPacienteCard(Paciente paciente) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 0,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: Colors.grey.shade200,
        ),
      ),

      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () => _abrirPaciente(paciente),

        child: Padding(
          padding: const EdgeInsets.all(16),

          child: Row(
            children: [
              CircleAvatar(
                radius: 28,
                backgroundColor: const Color(0xFFE3F2FD),
                foregroundColor: const Color(0xFF1565C0),

                child: Text(
                  paciente.nombres.isNotEmpty
                      ? paciente.nombres[0].toUpperCase()
                      : '?',

                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              const SizedBox(width: 15),

              Expanded(
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,

                  children: [
                    Text(
                      paciente.nombreCompleto,
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF172033),
                      ),
                    ),

                    const SizedBox(height: 6),

                    Text(
                      'DNI: ${paciente.dni}',
                      style: TextStyle(
                        color: Colors.grey.shade700,
                        fontSize: 14,
                      ),
                    ),

                    const SizedBox(height: 3),

                    Text(
                      '${paciente.edad} años • ${paciente.sexo}',
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),

              const Icon(
                Icons.chevron_right,
                color: Color(0xFF607D8B),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSinResultados() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(30),

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [
            Icon(
              Icons.person_search,
              size: 70,
              color: Colors.grey.shade400,
            ),

            const SizedBox(height: 15),

            const Text(
              'No se encontraron pacientes',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF172033),
              ),
            ),

            const SizedBox(height: 8),

            Text(
              'Puedes registrar un nuevo paciente.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey.shade600,
              ),
            ),

            const SizedBox(height: 20),

            ElevatedButton.icon(
              onPressed: _registrarPaciente,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1565C0),
                foregroundColor: Colors.white,
                elevation: 0,
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 13,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              icon: const Icon(Icons.person_add),
              label: const Text(
                'Registrar paciente',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}