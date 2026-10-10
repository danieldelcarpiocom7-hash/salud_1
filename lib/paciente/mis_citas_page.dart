import 'package:flutter/material.dart';

class MisCitasPage extends StatelessWidget {
  const MisCitasPage({super.key});

  @override
  Widget build(BuildContext context) {
    final proximasCitas = [
      _Cita(
        fecha: '20 Oct 2026',
        hora: '10:00 AM',
        tipo: 'Consulta de control',
        medico: 'Dr. Carlos Mendoza',
        especialidad: 'Medicina general',
        estado: 'Confirmada',
      ),
    ];

    final citasAnteriores = [
      _Cita(
        fecha: '12 Oct 2026',
        hora: '09:00 AM',
        tipo: 'Consulta general',
        medico: 'Dr. Carlos Mendoza',
        especialidad: 'Medicina general',
        estado: 'Atendida',
      ),
      _Cita(
        fecha: '20 Sep 2026',
        hora: '11:00 AM',
        tipo: 'Control médico',
        medico: 'Dra. María Torres',
        especialidad: 'Medicina interna',
        estado: 'Atendida',
      ),
      _Cita(
        fecha: '15 Ago 2026',
        hora: '03:00 PM',
        tipo: 'Evaluación médica',
        medico: 'Dr. Carlos Mendoza',
        especialidad: 'Medicina general',
        estado: 'Atendida',
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
          'Mis citas',
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

              if (proximasCitas.isNotEmpty) ...[
                const Text(
                  'Próxima cita',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF172033),
                  ),
                ),
                const SizedBox(height: 12),
                _buildProximaCita(context, proximasCitas.first),
                const SizedBox(height: 28),
              ],

              const Text(
                'Historial de citas',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF172033),
                ),
              ),

              const SizedBox(height: 6),

              const Text(
                'Consulta tus citas médicas anteriores.',
                style: TextStyle(fontSize: 14, color: Color(0xFF607D8B)),
              ),

              const SizedBox(height: 18),

              ...citasAnteriores.map(
                (cita) => Padding(
                  padding: const EdgeInsets.only(bottom: 14),
                  child: _buildCitaAnterior(cita),
                ),
              ),

              const SizedBox(height: 6),

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
              Icons.calendar_month_outlined,
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
                  'Mis citas médicas',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 19,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  'Consulta tus próximas citas y el historial de atenciones.',
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
  // PRÓXIMA CITA
  // ============================================================

  Widget _buildProximaCita(BuildContext context, _Cita cita) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFBBD7F2)),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withValues(alpha: 0.06),
            blurRadius: 14,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: const Color(0xFFE3F2FD),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Icon(
                  Icons.event_available_rounded,
                  color: Color(0xFF1565C0),
                  size: 26,
                ),
              ),
              const SizedBox(width: 14),

              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Próxima atención',
                      style: TextStyle(fontSize: 12, color: Color(0xFF607D8B)),
                    ),
                    SizedBox(height: 4),
                    Text(
                      '20 de octubre',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF172033),
                      ),
                    ),
                  ],
                ),
              ),

              _buildEstado(cita.estado),
            ],
          ),

          const SizedBox(height: 20),

          const Divider(color: Color(0xFFE8EDF2)),

          const SizedBox(height: 16),

          _buildDatoCita(Icons.access_time_rounded, 'Hora', cita.hora),

          const SizedBox(height: 13),

          _buildDatoCita(
            Icons.medical_services_outlined,
            'Tipo de consulta',
            cita.tipo,
          ),

          const SizedBox(height: 13),

          _buildDatoCita(Icons.person_outline_rounded, 'Médico', cita.medico),

          const SizedBox(height: 13),

          _buildDatoCita(
            Icons.local_hospital_outlined,
            'Especialidad',
            cita.especialidad,
          ),

          const SizedBox(height: 20),

          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: const Color(0xFFF5F9FD),
              borderRadius: BorderRadius.circular(13),
            ),
            child: const Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.info_outline_rounded,
                  color: Color(0xFF1565C0),
                  size: 20,
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'Recuerda asistir a tu cita en la fecha y hora programadas.',
                    style: TextStyle(
                      fontSize: 12,
                      height: 1.4,
                      color: Color(0xFF546E7A),
                    ),
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
  // CITA ANTERIOR
  // ============================================================

  Widget _buildCitaAnterior(_Cita cita) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFDDE4EC)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: const Color(0xFFF1F5F9),
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Icon(
              Icons.calendar_today_outlined,
              color: Color(0xFF607D8B),
              size: 23,
            ),
          ),
          const SizedBox(width: 14),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        cita.tipo,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF172033),
                        ),
                      ),
                    ),
                    _buildEstado(cita.estado),
                  ],
                ),

                const SizedBox(height: 7),

                Text(
                  cita.fecha,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFF607D8B),
                  ),
                ),

                const SizedBox(height: 8),

                Row(
                  children: [
                    const Icon(
                      Icons.access_time_outlined,
                      size: 15,
                      color: Color(0xFF78909C),
                    ),
                    const SizedBox(width: 5),
                    Text(
                      cita.hora,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Color(0xFF607D8B),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 6),

                Row(
                  children: [
                    const Icon(
                      Icons.person_outline_rounded,
                      size: 15,
                      color: Color(0xFF78909C),
                    ),
                    const SizedBox(width: 5),
                    Expanded(
                      child: Text(
                        cita.medico,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Color(0xFF607D8B),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // DATOS
  // ============================================================

  Widget _buildDatoCita(IconData icono, String titulo, String valor) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icono, size: 20, color: const Color(0xFF1565C0)),
        const SizedBox(width: 11),
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
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ============================================================
  // ESTADO
  // ============================================================

  Widget _buildEstado(String estado) {
    final bool atendida = estado == 'Atendida';

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
      decoration: BoxDecoration(
        color: atendida ? const Color(0xFFE8F5E9) : const Color(0xFFE3F2FD),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            atendida ? Icons.check_circle : Icons.check_circle_outline,
            size: 13,
            color: atendida ? const Color(0xFF2E7D32) : const Color(0xFF1565C0),
          ),
          const SizedBox(width: 4),
          Text(
            estado,
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w700,
              color: atendida
                  ? const Color(0xFF2E7D32)
                  : const Color(0xFF1565C0),
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
          Icon(Icons.info_outline_rounded, color: Color(0xFF1565C0), size: 21),
          SizedBox(width: 12),
          Expanded(
            child: Text(
              'Las citas son programadas y gestionadas por el personal de la clínica. Esta sección permite al paciente consultar su agenda médica.',
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

class _Cita {
  final String fecha;
  final String hora;
  final String tipo;
  final String medico;
  final String especialidad;
  final String estado;

  _Cita({
    required this.fecha,
    required this.hora,
    required this.tipo,
    required this.medico,
    required this.especialidad,
    required this.estado,
  });
}
