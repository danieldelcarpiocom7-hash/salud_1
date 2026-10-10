import 'package:flutter/material.dart';

import 'paciente.dart';

class TratamientosPage extends StatelessWidget {
  final Paciente paciente;

  const TratamientosPage({
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
          'Tratamientos',
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

                _buildEstadoVacio(),
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
                    'DNI: ${paciente.dni}',
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

  Widget _buildEstadoVacio() {
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
        padding: const EdgeInsets.symmetric(
          horizontal: 25,
          vertical: 55,
        ),

        child: Column(
          children: [
            Container(
              width: 64,
              height: 64,

              decoration: BoxDecoration(
                color: _azulClaro,
                borderRadius:
                    BorderRadius.circular(16),
              ),

              child: const Icon(
                Icons.medication_outlined,
                size: 32,
                color: _azulPrincipal,
              ),
            ),

            const SizedBox(height: 18),

            const Text(
              'No hay tratamientos registrados',
              textAlign: TextAlign.center,

              style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.w600,
                color: _textoPrincipal,
              ),
            ),

            const SizedBox(height: 8),

            const Text(
              'Los tratamientos y medicamentos '
              'indicados para este paciente aparecerán aquí.',
              textAlign: TextAlign.center,

              style: TextStyle(
                fontSize: 14,
                color: _textoSecundario,
              ),
            ),
          ],
        ),
      ),
    );
  }
}