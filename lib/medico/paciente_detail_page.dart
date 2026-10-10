import 'package:flutter/material.dart';

import 'paciente.dart';
import 'nueva_consulta_page.dart';
import 'historia_clinica_page.dart';
import 'consultas_page.dart';
import 'tratamientos_page.dart';
import 'citas_page.dart';
import 'home_medico_page.dart';

class PacienteDetailPage extends StatelessWidget {
  final Paciente paciente;

  const PacienteDetailPage({
    super.key,
    required this.paciente,
  });

  // ==========================================================
  // COLORES DEL MÓDULO
  // ==========================================================

  static const Color _azulPrincipal =
      Color(0xFF1565C0);

  static const Color _azulClaro =
      Color(0xFFE3F2FD);

  static const Color _fondo =
      Color(0xFFF6F8FA);

  static const Color _textoPrincipal =
      Color(0xFF172033);

  static const Color _textoSecundario =
      Color(0xFF607D8B);

  // ==========================================================
  // BUILD
  // ==========================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _fondo,

      appBar: AppBar(
        title: const Text(
          'Ficha del paciente',
          style: TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),

        backgroundColor: Colors.white,
        foregroundColor: _textoPrincipal,
        elevation: 0,
        surfaceTintColor: Colors.white,

        // ======================================================
        // BOTÓN PARA VOLVER DIRECTAMENTE AL HOME MÉDICO
        // ======================================================

        actions: [
          IconButton(
            tooltip: 'Inicio',

            icon: const Icon(
              Icons.home_outlined,
            ),

            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,

                MaterialPageRoute(
                  builder: (_) =>
                      const HomeMedicoPage(),
                ),

                (route) => false,
              );
            },
          ),

          const SizedBox(width: 6),
        ],
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),

        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: 900,
            ),

            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.stretch,

              children: [
                _buildEncabezado(context),

                const SizedBox(height: 18),

                _buildInformacionPersonal(),

                const SizedBox(height: 18),

                _buildResumenClinico(),

                const SizedBox(height: 18),

                _buildModulos(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ==========================================================
  // ENCABEZADO
  // ==========================================================

  Widget _buildEncabezado(
    BuildContext context,
  ) {
    return Card(
      elevation: 0,
      color: Colors.white,

      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
        side: BorderSide(
          color: Colors.grey.shade200,
        ),
      ),

      child: Padding(
        padding: const EdgeInsets.all(20),

        child: LayoutBuilder(
          builder: (context, constraints) {
            if (constraints.maxWidth < 600) {
              return Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,

                children: [
                  _buildDatosPaciente(),

                  const SizedBox(height: 18),

                  SizedBox(
                    width: double.infinity,
                    child: _buildBotonNuevaConsulta(
                      context,
                    ),
                  ),
                ],
              );
            }

            return Row(
              children: [
                Expanded(
                  child: _buildDatosPaciente(),
                ),

                const SizedBox(width: 20),

                _buildBotonNuevaConsulta(
                  context,
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  // ==========================================================
  // DATOS DEL PACIENTE
  // ==========================================================

  Widget _buildDatosPaciente() {
    return Row(
      children: [
        CircleAvatar(
          radius: 40,

          backgroundColor: _azulClaro,
          foregroundColor: _azulPrincipal,

          child: Text(
            paciente.nombres.isNotEmpty
                ? paciente.nombres[0].toUpperCase()
                : '?',

            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),

        const SizedBox(width: 18),

        Expanded(
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,

            children: [
              Text(
                paciente.nombreCompleto,

                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: _textoPrincipal,
                ),
              ),

              const SizedBox(height: 7),

              Text(
                'DNI: ${paciente.dni}',

                style: const TextStyle(
                  fontSize: 14,
                  color: _textoSecundario,
                ),
              ),

              const SizedBox(height: 4),

              Text(
                '${paciente.edad} años • ${paciente.sexo}',

                style: const TextStyle(
                  fontSize: 14,
                  color: _textoSecundario,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ==========================================================
  // BOTÓN NUEVA CONSULTA
  // ==========================================================

  Widget _buildBotonNuevaConsulta(
    BuildContext context,
  ) {
    return ElevatedButton.icon(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => NuevaConsultaPage(
              paciente: paciente,
            ),
          ),
        );
      },

      style: ElevatedButton.styleFrom(
        backgroundColor: _azulPrincipal,
        foregroundColor: Colors.white,
        elevation: 0,

        padding: const EdgeInsets.symmetric(
          horizontal: 18,
          vertical: 14,
        ),

        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(9),
        ),
      ),

      icon: const Icon(
        Icons.add,
        size: 20,
      ),

      label: const Text(
        'Nueva consulta',
        style: TextStyle(
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  // ==========================================================
  // INFORMACIÓN PERSONAL
  // ==========================================================

  Widget _buildInformacionPersonal() {
    return Card(
      elevation: 0,
      color: Colors.white,

      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
        side: BorderSide(
          color: Colors.grey.shade200,
        ),
      ),

      child: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,

          children: [
            _buildTituloSeccion(
              Icons.person_outline,
              'Información personal',
            ),

            const SizedBox(height: 22),

            LayoutBuilder(
              builder: (context, constraints) {
                if (constraints.maxWidth < 550) {
                  return Column(
                    children: [
                      _buildDato(
                        Icons.badge_outlined,
                        'DNI',
                        paciente.dni,
                      ),

                      _buildDato(
                        Icons.phone_outlined,
                        'Teléfono',
                        paciente.telefono.isEmpty
                            ? 'No registrado'
                            : paciente.telefono,
                      ),

                      _buildDato(
                        Icons.email_outlined,
                        'Correo',
                        paciente.correo.isEmpty
                            ? 'No registrado'
                            : paciente.correo,
                      ),

                      _buildDato(
                        Icons.location_on_outlined,
                        'Dirección',
                        paciente.direccion.isEmpty
                            ? 'No registrada'
                            : paciente.direccion,
                      ),
                    ],
                  );
                }

                return Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: _buildDato(
                            Icons.badge_outlined,
                            'DNI',
                            paciente.dni,
                          ),
                        ),

                        const SizedBox(width: 25),

                        Expanded(
                          child: _buildDato(
                            Icons.phone_outlined,
                            'Teléfono',
                            paciente.telefono.isEmpty
                                ? 'No registrado'
                                : paciente.telefono,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 18),

                    Row(
                      children: [
                        Expanded(
                          child: _buildDato(
                            Icons.email_outlined,
                            'Correo',
                            paciente.correo.isEmpty
                                ? 'No registrado'
                                : paciente.correo,
                          ),
                        ),

                        const SizedBox(width: 25),

                        Expanded(
                          child: _buildDato(
                            Icons.location_on_outlined,
                            'Dirección',
                            paciente.direccion.isEmpty
                                ? 'No registrada'
                                : paciente.direccion,
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  // ==========================================================
  // TÍTULO DE SECCIÓN
  // ==========================================================

  Widget _buildTituloSeccion(
    IconData icono,
    String titulo,
  ) {
    return Row(
      children: [
        Container(
          width: 38,
          height: 38,

          decoration: BoxDecoration(
            color: _azulClaro,
            borderRadius:
                BorderRadius.circular(9),
          ),

          child: Icon(
            icono,
            color: _azulPrincipal,
            size: 21,
          ),
        ),

        const SizedBox(width: 12),

        Text(
          titulo,

          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: _textoPrincipal,
          ),
        ),
      ],
    );
  }

  // ==========================================================
  // DATO
  // ==========================================================

  Widget _buildDato(
    IconData icono,
    String titulo,
    String valor,
  ) {
    return Row(
      crossAxisAlignment:
          CrossAxisAlignment.start,

      children: [
        Icon(
          icono,
          size: 21,
          color: _textoSecundario,
        ),

        const SizedBox(width: 10),

        Expanded(
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,

            children: [
              Text(
                titulo,

                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: _textoSecundario,
                ),
              ),

              const SizedBox(height: 4),

              Text(
                valor,

                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: _textoPrincipal,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ==========================================================
  // RESUMEN CLÍNICO
  // ==========================================================

  Widget _buildResumenClinico() {
    return Card(
      elevation: 0,
      color: Colors.white,

      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
        side: BorderSide(
          color: Colors.grey.shade200,
        ),
      ),

      child: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,

          children: [
            _buildTituloSeccion(
              Icons.medical_information_outlined,
              'Resumen clínico',
            ),

            const SizedBox(height: 20),

            _buildResumenItem(
              Icons.warning_amber_outlined,
              'Alergias',
              'Sin información registrada',
            ),

            const SizedBox(height: 15),

            _buildResumenItem(
              Icons.assignment_outlined,
              'Diagnósticos',
              'Sin información registrada',
            ),

            const SizedBox(height: 15),

            _buildResumenItem(
              Icons.medication_outlined,
              'Tratamiento actual',
              'Sin información registrada',
            ),
          ],
        ),
      ),
    );
  }

  // ==========================================================
  // ELEMENTO DEL RESUMEN
  // ==========================================================

  Widget _buildResumenItem(
    IconData icono,
    String titulo,
    String valor,
  ) {
    return Container(
      width: double.infinity,

      padding: const EdgeInsets.all(14),

      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),

        borderRadius:
            BorderRadius.circular(10),

        border: Border.all(
          color: Colors.grey.shade200,
        ),
      ),

      child: Row(
        crossAxisAlignment:
            CrossAxisAlignment.start,

        children: [
          Icon(
            icono,
            size: 21,
            color: _azulPrincipal,
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,

              children: [
                Text(
                  titulo,

                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: _textoPrincipal,
                  ),
                ),

                const SizedBox(height: 4),

                Text(
                  valor,

                  style: const TextStyle(
                    fontSize: 14,
                    color: _textoSecundario,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ==========================================================
  // MÓDULOS CLÍNICOS
  // ==========================================================

  Widget _buildModulos(
    BuildContext context,
  ) {
    return Column(
      children: [
        // ------------------------------------------------------
        // HISTORIA CLÍNICA
        // ------------------------------------------------------

        _buildModulo(
          context,
          Icons.history,
          'Historia clínica',
          'Ver antecedentes y evolución del paciente.',
          () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => HistoriaClinicaPage(
                  paciente: paciente,
                ),
              ),
            );
          },
        ),

        // ------------------------------------------------------
        // CONSULTAS
        // ------------------------------------------------------

        _buildModulo(
          context,
          Icons.medical_services_outlined,
          'Consultas',
          'Ver las consultas médicas registradas.',
          () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => ConsultasPage(
                  paciente: paciente,
                ),
              ),
            );
          },
        ),

        // ------------------------------------------------------
        // TRATAMIENTOS
        // ------------------------------------------------------

        _buildModulo(
          context,
          Icons.medication_outlined,
          'Tratamientos',
          'Ver tratamientos y medicamentos.',
          () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => TratamientosPage(
                  paciente: paciente,
                ),
              ),
            );
          },
        ),

        // ------------------------------------------------------
        // CITAS
        // ------------------------------------------------------

        _buildModulo(
          context,
          Icons.calendar_month_outlined,
          'Citas',
          'Ver las citas del paciente.',
          () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => CitasPage(
                  paciente: paciente,
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  // ==========================================================
  // MÓDULO
  // ==========================================================

  Widget _buildModulo(
    BuildContext context,
    IconData icono,
    String titulo,
    String descripcion,
    VoidCallback onTap,
  ) {
    return Card(
      margin:
          const EdgeInsets.only(bottom: 10),

      elevation: 0,
      color: Colors.white,

      shape: RoundedRectangleBorder(
        borderRadius:
            BorderRadius.circular(12),

        side: BorderSide(
          color: Colors.grey.shade200,
        ),
      ),

      child: InkWell(
        borderRadius:
            BorderRadius.circular(12),

        onTap: onTap,

        child: Padding(
          padding:
              const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 14,
          ),

          child: Row(
            children: [
              Container(
                width: 44,
                height: 44,

                decoration: BoxDecoration(
                  color: _azulClaro,
                  borderRadius:
                      BorderRadius.circular(10),
                ),

                child: Icon(
                  icono,
                  color: _azulPrincipal,
                  size: 23,
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
                        fontSize: 16,
                        fontWeight:
                            FontWeight.w600,
                        color:
                            _textoPrincipal,
                      ),
                    ),

                    const SizedBox(height: 3),

                    Text(
                      descripcion,

                      style: const TextStyle(
                        fontSize: 13,
                        color:
                            _textoSecundario,
                      ),
                    ),
                  ],
                ),
              ),

              const Icon(
                Icons.chevron_right,
                color: _textoSecundario,
              ),
            ],
          ),
        ),
      ),
    );
  }
}