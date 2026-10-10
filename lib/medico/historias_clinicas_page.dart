import 'package:flutter/material.dart';

import 'paciente.dart';
import 'paciente_detail_page.dart';

class HistoriasClinicasPage extends StatefulWidget {
  const HistoriasClinicasPage({super.key});

  @override
  State<HistoriasClinicasPage> createState() =>
      _HistoriasClinicasPageState();
}

class _HistoriasClinicasPageState
    extends State<HistoriasClinicasPage> {
  final TextEditingController _busquedaController =
      TextEditingController();

  String _busqueda = '';

  // ============================================================
  // DATOS TEMPORALES
  // ============================================================

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

  @override
  void initState() {
    super.initState();

    _busquedaController.addListener(_actualizarBusqueda);
  }

  void _actualizarBusqueda() {
    setState(() {
      _busqueda =
          _busquedaController.text.trim().toLowerCase();
    });
  }

  @override
  void dispose() {
    _busquedaController.removeListener(_actualizarBusqueda);
    _busquedaController.dispose();
    super.dispose();
  }

  // ============================================================
  // FILTRO
  // ============================================================

  List<Paciente> get _pacientesFiltrados {
    if (_busqueda.isEmpty) {
      return _pacientes;
    }

    return _pacientes.where((paciente) {
      final nombre =
          paciente.nombreCompleto.toLowerCase();

      final dni = paciente.dni.toLowerCase();

      return nombre.contains(_busqueda) ||
          dni.contains(_busqueda);
    }).toList();
  }

  // ============================================================
  // NAVEGAR A FICHA DEL PACIENTE
  // ============================================================

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

  // ============================================================
  // INFORMACIÓN DEL PACIENTE
  // ============================================================

  void _mostrarInformacion(Paciente paciente) {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          title: Row(
            children: [
              CircleAvatar(
                radius: 23,
                backgroundColor:
                    const Color(0xFFE3F2FD),
                child: Text(
                  paciente.nombres.isNotEmpty
                      ? paciente.nombres[0]
                          .toUpperCase()
                      : '?',
                  style: const TextStyle(
                    color: Color(0xFF1565C0),
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  paciente.nombreCompleto,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF172033),
                  ),
                ),
              ),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _filaInformacion(
                Icons.badge_outlined,
                'DNI',
                paciente.dni,
              ),
              _filaInformacion(
                Icons.cake_outlined,
                'Edad',
                '${paciente.edad} años',
              ),
              _filaInformacion(
                Icons.person_outline,
                'Sexo',
                paciente.sexo,
              ),
              _filaInformacion(
                Icons.phone_outlined,
                'Teléfono',
                paciente.telefono,
              ),
              _filaInformacion(
                Icons.email_outlined,
                'Correo',
                paciente.correo,
              ),
              _filaInformacion(
                Icons.location_on_outlined,
                'Dirección',
                paciente.direccion,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
              },
              child: const Text(
                'Cerrar',
                style: TextStyle(
                  color: Color(0xFF607D8B),
                ),
              ),
            ),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.pop(dialogContext);
                _abrirPaciente(paciente);
              },
              icon: const Icon(
                Icons.folder_open_outlined,
                size: 18,
              ),
              label: const Text('Ver ficha'),
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    const Color(0xFF1565C0),
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(10),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _filaInformacion(
    IconData icono,
    String titulo,
    String valor,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 7,
      ),
      child: Row(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          Icon(
            icono,
            size: 20,
            color: const Color(0xFF607D8B),
          ),
          const SizedBox(width: 10),
          SizedBox(
            width: 75,
            child: Text(
              titulo,
              style: const TextStyle(
                fontSize: 13,
                color: Color(0xFF607D8B),
              ),
            ),
          ),
          Expanded(
            child: Text(
              valor.isEmpty
                  ? 'No registrado'
                  : valor,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Color(0xFF172033),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // TARJETA DEL PACIENTE
  // ============================================================

  Widget _construirPacienteCard(
    Paciente paciente,
  ) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(
        bottom: 12,
      ),
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: Colors.grey.shade200,
        ),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () => _abrirPaciente(paciente),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              CircleAvatar(
                radius: 27,
                backgroundColor:
                    const Color(0xFFE3F2FD),
                child: Text(
                  paciente.nombres.isNotEmpty
                      ? paciente.nombres[0]
                          .toUpperCase()
                      : '?',
                  style: const TextStyle(
                    color: Color(0xFF1565C0),
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
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF172033),
                      ),
                    ),

                    const SizedBox(height: 7),

                    Wrap(
                      spacing: 12,
                      runSpacing: 5,
                      children: [
                        _datoPaciente(
                          Icons.badge_outlined,
                          'DNI ${paciente.dni}',
                        ),
                        _datoPaciente(
                          Icons.cake_outlined,
                          '${paciente.edad} años',
                        ),
                        _datoPaciente(
                          Icons.person_outline,
                          paciente.sexo,
                        ),
                      ],
                    ),

                    const SizedBox(height: 7),

                    Row(
                      children: [
                        const Icon(
                          Icons.phone_outlined,
                          size: 16,
                          color: Color(0xFF78909C),
                        ),
                        const SizedBox(width: 5),
                        Text(
                          paciente.telefono.isEmpty
                              ? 'Sin teléfono'
                              : paciente.telefono,
                          style: const TextStyle(
                            fontSize: 13,
                            color: Color(0xFF607D8B),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              IconButton(
                tooltip: 'Ver información',
                onPressed: () =>
                    _mostrarInformacion(paciente),
                icon: const Icon(
                  Icons.info_outline,
                  color: Color(0xFF1565C0),
                ),
              ),

              const Icon(
                Icons.chevron_right,
                color: Color(0xFF90A4AE),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _datoPaciente(
    IconData icono,
    String texto,
  ) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icono,
          size: 15,
          color: const Color(0xFF78909C),
        ),
        const SizedBox(width: 4),
        Text(
          texto,
          style: const TextStyle(
            fontSize: 13,
            color: Color(0xFF607D8B),
          ),
        ),
      ],
    );
  }

  // ============================================================
  // RESUMEN
  // ============================================================

  Widget _construirResumen() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final bool compacto =
            constraints.maxWidth < 650;

        if (compacto) {
          return Column(
            children: [
              _tarjetaResumen(
                icono: Icons.people_outline,
                titulo: 'Pacientes registrados',
                valor: '${_pacientes.length}',
                color: const Color(0xFF1565C0),
              ),
              const SizedBox(height: 10),
              _tarjetaResumen(
                icono:
                    Icons.folder_shared_outlined,
                titulo: 'Historias disponibles',
                valor: '${_pacientes.length}',
                color: const Color(0xFF00897B),
              ),
            ],
          );
        }

        return Row(
          children: [
            Expanded(
              child: _tarjetaResumen(
                icono: Icons.people_outline,
                titulo: 'Pacientes registrados',
                valor: '${_pacientes.length}',
                color: const Color(0xFF1565C0),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _tarjetaResumen(
                icono:
                    Icons.folder_shared_outlined,
                titulo: 'Historias disponibles',
                valor: '${_pacientes.length}',
                color: const Color(0xFF00897B),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _tarjetaResumen({
    required IconData icono,
    required String titulo,
    required String valor,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.grey.shade200,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: color.withValues(
                alpha: 0.10,
              ),
              borderRadius:
                  BorderRadius.circular(14),
            ),
            child: Icon(
              icono,
              color: color,
              size: 25,
            ),
          ),

          const SizedBox(width: 14),

          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Text(
                  titulo,
                  style: const TextStyle(
                    color: Color(0xFF607D8B),
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  valor,
                  style: const TextStyle(
                    color: Color(0xFF172033),
                    fontSize: 24,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // ESTADO VACÍO
  // ============================================================

  Widget _construirEstadoVacio() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: 24,
        vertical: 50,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: Colors.grey.shade200,
        ),
      ),
      child: Column(
        children: [
          Container(
            width: 72,
            height: 72,
            decoration: BoxDecoration(
              color: const Color(0xFFE3F2FD),
              borderRadius:
                  BorderRadius.circular(20),
            ),
            child: const Icon(
              Icons.search_off_outlined,
              size: 38,
              color: Color(0xFF1565C0),
            ),
          ),

          const SizedBox(height: 18),

          const Text(
            'No se encontraron pacientes',
            style: TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.w700,
              color: Color(0xFF172033),
            ),
          ),

          const SizedBox(height: 8),

          const Text(
            'Prueba con otro nombre o número de DNI.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: Color(0xFF607D8B),
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // BUILD
  // ============================================================

  @override
  Widget build(BuildContext context) {
    final pacientes = _pacientesFiltrados;

    return Scaffold(
      backgroundColor:
          const Color(0xFFF6F8FA),

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        foregroundColor:
            const Color(0xFF172033),

        title: const Text(
          'Historias clínicas',
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 20,
          ),
        ),

        actions: [
          IconButton(
            tooltip: 'Inicio',
            icon: const Icon(
              Icons.home_outlined,
            ),
            onPressed: () {
              // Regresa al Home Médico.
              // No necesitamos importar HomeMedicoPage.
              Navigator.pop(context);
            },
          ),
          const SizedBox(width: 6),
        ],
      ),

      body: SafeArea(
        child: LayoutBuilder(
          builder: (
            context,
            constraints,
          ) {
            final bool escritorio =
                constraints.maxWidth >= 900;

            return SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                horizontal:
                    escritorio ? 50 : 20,
                vertical: 24,
              ),
              child: Center(
                child: ConstrainedBox(
                  constraints:
                      const BoxConstraints(
                    maxWidth: 1150,
                  ),
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [
                      // ==================================================
                      // ENCABEZADO
                      // ==================================================

                      const Text(
                        'Historias clínicas',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.w800,
                          color: Color(0xFF172033),
                        ),
                      ),

                      const SizedBox(height: 6),

                      const Text(
                        'Consulta y accede a la información clínica de tus pacientes.',
                        style: TextStyle(
                          fontSize: 15,
                          color: Color(0xFF607D8B),
                        ),
                      ),

                      const SizedBox(height: 22),

                      // ==================================================
                      // RESUMEN
                      // ==================================================

                      _construirResumen(),

                      const SizedBox(height: 22),

                      // ==================================================
                      // BUSCADOR
                      // ==================================================

                      Container(
                        padding:
                            const EdgeInsets.all(16),
                        decoration:
                            BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                              BorderRadius.circular(
                            16,
                          ),
                          border: Border.all(
                            color:
                                Colors.grey.shade200,
                          ),
                        ),
                        child: TextField(
                          controller:
                              _busquedaController,
                          decoration:
                              InputDecoration(
                            hintText:
                                'Buscar por nombre o DNI',
                            hintStyle:
                                const TextStyle(
                              color:
                                  Color(0xFF90A4AE),
                            ),
                            prefixIcon:
                                const Icon(
                              Icons.search,
                              color:
                                  Color(0xFF1565C0),
                            ),
                            suffixIcon:
                                _busqueda.isNotEmpty
                                    ? IconButton(
                                        tooltip:
                                            'Limpiar búsqueda',
                                        icon:
                                            const Icon(
                                          Icons.clear,
                                        ),
                                        onPressed: () {
                                          _busquedaController
                                              .clear();
                                        },
                                      )
                                    : null,
                            filled: true,
                            fillColor:
                                const Color(
                              0xFFF6F8FA,
                            ),
                            border:
                                OutlineInputBorder(
                              borderRadius:
                                  BorderRadius
                                      .circular(
                                12,
                              ),
                              borderSide:
                                  BorderSide.none,
                            ),
                            enabledBorder:
                                OutlineInputBorder(
                              borderRadius:
                                  BorderRadius
                                      .circular(
                                12,
                              ),
                              borderSide:
                                  BorderSide.none,
                            ),
                            focusedBorder:
                                OutlineInputBorder(
                              borderRadius:
                                  BorderRadius
                                      .circular(
                                12,
                              ),
                              borderSide:
                                  const BorderSide(
                                color:
                                    Color(
                                  0xFF1565C0,
                                ),
                                width: 1.3,
                              ),
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 24),

                      // ==================================================
                      // TÍTULO PACIENTES
                      // ==================================================

                      Row(
                        children: [
                          const Expanded(
                            child: Text(
                              'Pacientes',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight:
                                    FontWeight.w800,
                                color:
                                    Color(
                                  0xFF172033,
                                ),
                              ),
                            ),
                          ),

                          Text(
                            '${pacientes.length} encontrados',
                            style:
                                const TextStyle(
                              fontSize: 14,
                              color:
                                  Color(
                                0xFF607D8B,
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 12),

                      // ==================================================
                      // LISTA
                      // ==================================================

                      if (pacientes.isEmpty)
                        _construirEstadoVacio()
                      else
                        ...pacientes.map(
                          _construirPacienteCard,
                        ),
                    ],
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