import 'package:flutter/material.dart';

import 'paciente.dart';

class HistoriaClinicaPage extends StatelessWidget {
  final Paciente paciente;

  const HistoriaClinicaPage({
    super.key,
    required this.paciente,
  });

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _fondo,

      appBar: AppBar(
        title: const Text(
          'Historia clínica',
          style: TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: Colors.white,
        foregroundColor: _textoPrincipal,
        elevation: 0,
        surfaceTintColor: Colors.white,
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
                _buildPaciente(),

                const SizedBox(height: 18),

                _buildSeccion(
                  icono: Icons.warning_amber_outlined,
                  titulo: 'Alergias',
                  descripcion:
                      'Alergias conocidas registradas en la historia clínica.',
                  mensaje:
                      'No se han registrado alergias.',
                ),

                _buildSeccion(
                  icono: Icons.family_restroom_outlined,
                  titulo: 'Antecedentes familiares',
                  descripcion:
                      'Antecedentes médicos relevantes de familiares.',
                  mensaje:
                      'No se han registrado antecedentes familiares.',
                ),

                _buildSeccion(
                  icono: Icons.medical_information_outlined,
                  titulo: 'Antecedentes personales',
                  descripcion:
                      'Antecedentes médicos y quirúrgicos del paciente.',
                  mensaje:
                      'No se han registrado antecedentes personales.',
                ),

                _buildSeccion(
                  icono: Icons.healing_outlined,
                  titulo: 'Enfermedades crónicas',
                  descripcion:
                      'Enfermedades crónicas o condiciones permanentes.',
                  mensaje:
                      'No se han registrado enfermedades crónicas.',
                ),

                _buildSeccion(
                  icono: Icons.health_and_safety_outlined,
                  titulo: 'Otros antecedentes',
                  descripcion:
                      'Información adicional relevante para la atención.',
                  mensaje:
                      'No se han registrado otros antecedentes.',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPaciente() {
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

        child: Row(
          children: [
            CircleAvatar(
              radius: 32,
              backgroundColor: _azulClaro,
              foregroundColor: _azulPrincipal,

              child: Text(
                paciente.nombres.isNotEmpty
                    ? paciente.nombres[0].toUpperCase()
                    : '?',

                style: const TextStyle(
                  fontSize: 23,
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
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: _textoPrincipal,
                    ),
                  ),

                  const SizedBox(height: 4),

                  Text(
                    'DNI: ${paciente.dni} • '
                    '${paciente.edad} años',
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
      ),
    );
  }

  Widget _buildSeccion({
    required IconData icono,
    required String titulo,
    required String descripcion,
    required String mensaje,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 0,
      color: Colors.white,

      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
        side: BorderSide(
          color: Colors.grey.shade200,
        ),
      ),

      child: Padding(
        padding: const EdgeInsets.all(18),

        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,

          children: [
            Row(
              children: [
                Container(
                  width: 40,
                  height: 40,

                  decoration: BoxDecoration(
                    color: _azulClaro,
                    borderRadius:
                        BorderRadius.circular(9),
                  ),

                  child: Icon(
                    icono,
                    color: _azulPrincipal,
                    size: 22,
                  ),
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: Text(
                    titulo,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: _textoPrincipal,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            Text(
              descripcion,
              style: const TextStyle(
                fontSize: 14,
                color: _textoSecundario,
              ),
            ),

            const SizedBox(height: 16),

            Container(
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

              child: Text(
                mensaje,
                style: const TextStyle(
                  fontSize: 14,
                  color: _textoSecundario,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}