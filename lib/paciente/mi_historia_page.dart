import 'package:flutter/material.dart';

class MiHistoriaPage extends StatelessWidget {
  const MiHistoriaPage({super.key});

  @override
  Widget build(BuildContext context) {
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
          'Mi historia clínica',
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

              _buildDatosPaciente(),
              const SizedBox(height: 18),

              _buildSeccion(
                titulo: 'Alergias',
                icono: Icons.warning_amber_rounded,
                color: const Color(0xFFC62828),
                fondo: const Color(0xFFFFEBEE),
                contenido: ['Penicilina'],
              ),

              _buildSeccion(
                titulo: 'Antecedentes personales',
                icono: Icons.person_outline_rounded,
                color: const Color(0xFF1565C0),
                fondo: const Color(0xFFE3F2FD),
                contenido: ['Hipertensión arterial', 'Gastritis'],
              ),

              _buildSeccion(
                titulo: 'Antecedentes familiares',
                icono: Icons.family_restroom_outlined,
                color: const Color(0xFF6A1B9A),
                fondo: const Color(0xFFF3E5F5),
                contenido: ['Antecedentes de hipertensión materna'],
              ),

              _buildSeccion(
                titulo: 'Enfermedades crónicas',
                icono: Icons.favorite_border_rounded,
                color: const Color(0xFF00897B),
                fondo: const Color(0xFFE0F2F1),
                contenido: ['Hipertensión arterial controlada'],
              ),

              _buildDiagnosticos(),
              const SizedBox(height: 18),

              _buildTratamientoActual(),
              const SizedBox(height: 18),

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
            width: 58,
            height: 58,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(17),
            ),
            child: const Icon(
              Icons.folder_shared_outlined,
              color: Colors.white,
              size: 31,
            ),
          ),
          const SizedBox(width: 16),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Información clínica',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 19,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  'Consulta la información registrada por tu médico.',
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
  // DATOS DEL PACIENTE
  // ============================================================

  Widget _buildDatosPaciente() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: _decoracionTarjeta(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Datos del paciente',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Color(0xFF172033),
            ),
          ),
          const SizedBox(height: 18),

          Row(
            children: [
              Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  color: const Color(0xFFE3F2FD),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Icon(
                  Icons.person_outline_rounded,
                  color: Color(0xFF1565C0),
                  size: 28,
                ),
              ),
              const SizedBox(width: 14),

              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Juan Pérez',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF172033),
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'DNI: 74563218',
                      style: TextStyle(fontSize: 13, color: Color(0xFF607D8B)),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 18),

          const Divider(color: Color(0xFFE8EDF2)),

          const SizedBox(height: 14),

          Row(
            children: [
              Expanded(child: _buildDato('Edad', '35 años')),
              Expanded(child: _buildDato('Sexo', 'Masculino')),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDato(String titulo, String valor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          titulo,
          style: const TextStyle(fontSize: 11, color: Color(0xFF78909C)),
        ),
        const SizedBox(height: 4),
        Text(
          valor,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Color(0xFF263238),
          ),
        ),
      ],
    );
  }

  // ============================================================
  // SECCIONES CLÍNICAS
  // ============================================================

  Widget _buildSeccion({
    required String titulo,
    required IconData icono,
    required Color color,
    required Color fondo,
    required List<String> contenido,
  }) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 18),
      padding: const EdgeInsets.all(20),
      decoration: _decoracionTarjeta(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: fondo,
                  borderRadius: BorderRadius.circular(13),
                ),
                child: Icon(icono, color: color, size: 23),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  titulo,
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF172033),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          ...contenido.map(
            (item) => Padding(
              padding: const EdgeInsets.only(bottom: 9),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 6),
                    width: 6,
                    height: 6,
                    decoration: BoxDecoration(
                      color: color,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      item,
                      style: const TextStyle(
                        fontSize: 14,
                        height: 1.4,
                        color: Color(0xFF455A64),
                      ),
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

  // ============================================================
  // DIAGNÓSTICOS
  // ============================================================

  Widget _buildDiagnosticos() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: _decoracionTarjeta(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: const Color(0xFFEDE7F6),
                  borderRadius: BorderRadius.circular(13),
                ),
                child: const Icon(
                  Icons.medical_information_outlined,
                  color: Color(0xFF5E35B1),
                  size: 23,
                ),
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: Text(
                  'Diagnósticos registrados',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF172033),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 18),

          _buildDiagnosticoItem(
            fecha: '12 Oct 2026',
            diagnostico: 'Infección respiratoria',
            detalle: 'Diagnóstico registrado durante consulta médica.',
          ),

          const SizedBox(height: 12),

          _buildDiagnosticoItem(
            fecha: '20 Sep 2026',
            diagnostico: 'Hipertensión arterial',
            detalle: 'Control médico y seguimiento.',
          ),
        ],
      ),
    );
  }

  Widget _buildDiagnosticoItem({
    required String fecha,
    required String diagnostico,
    required String detalle,
  }) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE2E8EF)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.check_circle_outline_rounded,
            color: Color(0xFF5E35B1),
            size: 22,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  diagnostico,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF263238),
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  detalle,
                  style: const TextStyle(
                    fontSize: 12,
                    height: 1.4,
                    color: Color(0xFF607D8B),
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  fecha,
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF78909C),
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
  // TRATAMIENTO ACTUAL
  // ============================================================

  Widget _buildTratamientoActual() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: _decoracionTarjeta(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: const Color(0xFFFFF3E0),
                  borderRadius: BorderRadius.circular(13),
                ),
                child: const Icon(
                  Icons.medication_outlined,
                  color: Color(0xFFEF6C00),
                  size: 23,
                ),
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: Text(
                  'Tratamiento actual',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF172033),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 18),

          _buildMedicamento(
            nombre: 'Amoxicilina 500 mg',
            indicacion: '1 cápsula cada 8 horas durante 7 días.',
          ),

          const SizedBox(height: 12),

          _buildMedicamento(
            nombre: 'Paracetamol 500 mg',
            indicacion: '1 tableta cada 8 horas según indicación médica.',
          ),
        ],
      ),
    );
  }

  Widget _buildMedicamento({
    required String nombre,
    required String indicacion,
  }) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: const Color(0xFFFFFBF5),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFFFE0B2)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.medication_rounded,
            color: Color(0xFFEF6C00),
            size: 22,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  nombre,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF263238),
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  indicacion,
                  style: const TextStyle(
                    fontSize: 12,
                    height: 1.4,
                    color: Color(0xFF607D8B),
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
              'Esta información es registrada y actualizada por el personal médico. El paciente puede consultarla, pero no modificarla.',
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

  // ============================================================
  // ESTILO DE TARJETAS
  // ============================================================

  BoxDecoration _decoracionTarjeta() {
    return BoxDecoration(
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
    );
  }
}
