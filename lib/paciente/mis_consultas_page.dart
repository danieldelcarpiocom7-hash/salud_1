import 'package:flutter/material.dart';

class MisConsultasPage extends StatelessWidget {
  const MisConsultasPage({super.key});

  @override
  Widget build(BuildContext context) {
    final consultas = [
      _Consulta(
        fecha: '12 Oct 2026',
        motivo: 'Dolor de garganta y fiebre',
        sintomas: 'Dolor al tragar, fiebre y malestar general.',
        diagnostico: 'Infección respiratoria',
        tratamiento: 'Amoxicilina 500 mg',
        indicaciones: '1 cápsula cada 8 horas durante 7 días.',
        observaciones:
            'Se recomienda mantener buena hidratación y cumplir el tratamiento indicado.',
      ),
      _Consulta(
        fecha: '20 Sep 2026',
        motivo: 'Control médico',
        sintomas: 'Sin síntomas nuevos.',
        diagnostico: 'Hipertensión arterial controlada',
        tratamiento: 'Continuar tratamiento habitual.',
        indicaciones: 'Mantener controles periódicos.',
        observaciones: 'Se recomienda continuar con seguimiento médico.',
      ),
      _Consulta(
        fecha: '15 Ago 2026',
        motivo: 'Dolor de cabeza',
        sintomas: 'Dolor de cabeza ocasional.',
        diagnostico: 'Cefalea',
        tratamiento: 'Paracetamol 500 mg',
        indicaciones: 'Tomar según indicación médica.',
        observaciones:
            'Consultar nuevamente si los síntomas aumentan o persisten.',
      ),
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Color(0xFF172033),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Mis consultas',
          style: TextStyle(
            color: Color(0xFF172033),
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildEncabezado(),
              const SizedBox(height: 20),

              _buildResumen(consultas.length),
              const SizedBox(height: 24),

              const Text(
                'Historial de consultas',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF172033),
                ),
              ),

              const SizedBox(height: 6),

              const Text(
                'Consulta los diagnósticos e indicaciones registradas por tu médico.',
                style: TextStyle(fontSize: 14, color: Color(0xFF607D8B)),
              ),

              const SizedBox(height: 18),

              ...consultas.map(
                (consulta) => Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: _buildConsultaCard(context, consulta),
                ),
              ),

              const SizedBox(height: 4),

              _buildNotaInformativa(),
            ],
          ),
        ),
      ),
    );
  }

  // ============================================================
  // ENCABEZADO
  // ============================================================

  Widget _buildEncabezado() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF1565C0), Color(0xFF1976D2)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withValues(alpha: 0.15),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Icon(
              Icons.medical_information_outlined,
              color: Colors.white,
              size: 30,
            ),
          ),
          const SizedBox(width: 16),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Historial médico',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 19,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  'Revisa las consultas y la información registrada por tu médico.',
                  style: TextStyle(
                    color: Color(0xFFE3F2FD),
                    fontSize: 13,
                    height: 1.4,
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
  // RESUMEN
  // ============================================================

  Widget _buildResumen(int cantidad) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFDDE4EC)),
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: const Color(0xFFE3F2FD),
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Icon(
              Icons.history_rounded,
              color: Color(0xFF1565C0),
              size: 25,
            ),
          ),
          const SizedBox(width: 14),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Consultas registradas',
                  style: TextStyle(fontSize: 12, color: Color(0xFF607D8B)),
                ),
                SizedBox(height: 3),
                Text(
                  'Historial médico',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF172033),
                  ),
                ),
              ],
            ),
          ),
          Text(
            '$cantidad',
            style: const TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.w800,
              color: Color(0xFF1565C0),
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // TARJETA DE CONSULTA
  // ============================================================

  Widget _buildConsultaCard(BuildContext context, _Consulta consulta) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFDDE4EC)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.025),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: const Color(0xFFE3F2FD),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: const Icon(
                    Icons.calendar_month_outlined,
                    color: Color(0xFF1565C0),
                    size: 24,
                  ),
                ),
                const SizedBox(width: 13),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Consulta médica',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF172033),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        consulta.fecha,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Color(0xFF607D8B),
                        ),
                      ),
                    ],
                  ),
                ),

                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE8F5E9),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    'Atendida',
                    style: TextStyle(
                      color: Color(0xFF2E7D32),
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 18),

            const Divider(color: Color(0xFFE8EDF2)),

            const SizedBox(height: 15),

            _buildDato(
              icono: Icons.description_outlined,
              titulo: 'Motivo',
              valor: consulta.motivo,
            ),

            const SizedBox(height: 13),

            _buildDato(
              icono: Icons.medical_information_outlined,
              titulo: 'Diagnóstico',
              valor: consulta.diagnostico,
            ),

            const SizedBox(height: 13),

            _buildDato(
              icono: Icons.medication_outlined,
              titulo: 'Tratamiento',
              valor: consulta.tratamiento,
            ),

            const SizedBox(height: 18),

            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () {
                  _mostrarDetalleConsulta(context, consulta);
                },
                icon: const Icon(Icons.visibility_outlined, size: 19),
                label: const Text('Ver detalle de la consulta'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: const Color(0xFF1565C0),
                  side: const BorderSide(color: Color(0xFF1565C0)),
                  padding: const EdgeInsets.symmetric(vertical: 13),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDato({
    required IconData icono,
    required String titulo,
    required String valor,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icono, color: const Color(0xFF78909C), size: 19),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                titulo,
                style: const TextStyle(fontSize: 11, color: Color(0xFF78909C)),
              ),
              const SizedBox(height: 3),
              Text(
                valor,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF263238),
                  height: 1.35,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ============================================================
  // DETALLE
  // ============================================================

  void _mostrarDetalleConsulta(BuildContext context, _Consulta consulta) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          constraints: const BoxConstraints(maxHeight: 680),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(26)),
          ),
          child: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(22, 18, 22, 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      width: 42,
                      height: 5,
                      decoration: BoxDecoration(
                        color: const Color(0xFFD6DDE4),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  Row(
                    children: [
                      Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          color: const Color(0xFFE3F2FD),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: const Icon(
                          Icons.medical_information_outlined,
                          color: Color(0xFF1565C0),
                        ),
                      ),
                      const SizedBox(width: 13),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Detalle de consulta',
                              style: TextStyle(
                                fontSize: 19,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFF172033),
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              consulta.fecha,
                              style: const TextStyle(
                                fontSize: 12,
                                color: Color(0xFF607D8B),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 22),

                  _buildDetalleSeccion(
                    'Motivo de consulta',
                    consulta.motivo,
                    Icons.description_outlined,
                  ),

                  _buildDetalleSeccion(
                    'Síntomas',
                    consulta.sintomas,
                    Icons.sick_outlined,
                  ),

                  _buildDetalleSeccion(
                    'Diagnóstico',
                    consulta.diagnostico,
                    Icons.medical_information_outlined,
                  ),

                  _buildDetalleSeccion(
                    'Tratamiento',
                    consulta.tratamiento,
                    Icons.medication_outlined,
                  ),

                  _buildDetalleSeccion(
                    'Indicaciones',
                    consulta.indicaciones,
                    Icons.assignment_outlined,
                  ),

                  _buildDetalleSeccion(
                    'Observaciones',
                    consulta.observaciones,
                    Icons.notes_outlined,
                  ),

                  const SizedBox(height: 8),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF1565C0),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'Cerrar',
                        style: TextStyle(fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildDetalleSeccion(String titulo, String contenido, IconData icono) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icono, size: 18, color: const Color(0xFF1565C0)),
              const SizedBox(width: 8),
              Text(
                titulo,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF172033),
                ),
              ),
            ],
          ),
          const SizedBox(height: 7),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: const Color(0xFFF8FAFC),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFFE2E8EF)),
            ),
            child: Text(
              contenido,
              style: const TextStyle(
                fontSize: 13,
                height: 1.45,
                color: Color(0xFF455A64),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // NOTA
  // ============================================================

  Widget _buildNotaInformativa() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFEFF6FC),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFD5E8F8)),
      ),
      child: const Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.lock_outline_rounded, color: Color(0xFF1565C0), size: 21),
          SizedBox(width: 12),
          Expanded(
            child: Text(
              'Las consultas y diagnósticos son registrados por el personal médico. Esta sección es únicamente de consulta para el paciente.',
              style: TextStyle(
                fontSize: 12,
                height: 1.5,
                color: Color(0xFF546E7A),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// MODELO TEMPORAL
// ============================================================

class _Consulta {
  final String fecha;
  final String motivo;
  final String sintomas;
  final String diagnostico;
  final String tratamiento;
  final String indicaciones;
  final String observaciones;

  _Consulta({
    required this.fecha,
    required this.motivo,
    required this.sintomas,
    required this.diagnostico,
    required this.tratamiento,
    required this.indicaciones,
    required this.observaciones,
  });
}
