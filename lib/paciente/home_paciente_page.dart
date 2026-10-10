import 'package:flutter/material.dart';

import 'mi_historia_page.dart';
import 'mis_consultas_page.dart';
import 'mis_citas_page.dart';
import 'mis_tratamientos_page.dart';

class HomePacientePage extends StatelessWidget {
  const HomePacientePage({super.key});

  // ============================================================
  // PALETA
  // ============================================================

  static const Color _azulPrincipal = Color(0xFF1565C0);
  static const Color _azulClaro = Color(0xFFE3F2FD);

  static const Color _verde = Color(0xFF2E7D32);
  static const Color _verdeClaro = Color(0xFFE8F5E9);

  static const Color _naranja = Color(0xFFEF6C00);
  static const Color _naranjaClaro = Color(0xFFFFF3E0);

  static const Color _violeta = Color(0xFF5E5CE6);
  static const Color _violetaClaro = Color(0xFFEEEEFF);

  static const Color _fondo = Color(0xFFF5F7FA);
  static const Color _blanco = Color(0xFFFFFFFF);

  static const Color _textoPrincipal = Color(0xFF172033);
  static const Color _textoSecundario = Color(0xFF607D8B);
  static const Color _borde = Color(0xFFE1E7EF);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _fondo,

      // ==========================================================
      // APP BAR
      // ==========================================================
      appBar: AppBar(
        backgroundColor: _blanco,
        foregroundColor: _textoPrincipal,
        elevation: 0,
        surfaceTintColor: _blanco,
        titleSpacing: 20,

        title: Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: _azulClaro,
                borderRadius: BorderRadius.circular(9),
              ),
              child: const Icon(
                Icons.local_hospital_outlined,
                color: _azulPrincipal,
                size: 21,
              ),
            ),

            const SizedBox(width: 10),

            const Text(
              'Portal del Paciente',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: _textoPrincipal,
              ),
            ),
          ],
        ),

        actions: [
          IconButton(
            tooltip: 'Notificaciones',
            icon: const Icon(
              Icons.notifications_none_outlined,
              color: _textoSecundario,
            ),
            onPressed: () {
              _mostrarMensaje(context, 'No tienes nuevas notificaciones.');
            },
          ),

          const SizedBox(width: 4),

          IconButton(
            tooltip: 'Cerrar sesión',
            icon: const Icon(Icons.logout_outlined, color: _textoSecundario),
            onPressed: () {
              Navigator.pop(context);
            },
          ),

          const SizedBox(width: 12),
        ],
      ),

      // ==========================================================
      // BODY
      // ==========================================================
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final bool esMovil = constraints.maxWidth < 700;

            return SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                horizontal: esMovil ? 16 : 32,
                vertical: esMovil ? 20 : 30,
              ),

              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 1180),

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,

                    children: [
                      _buildEncabezado(),

                      const SizedBox(height: 24),

                      _buildProximaToma(),

                      const SizedBox(height: 28),

                      _buildResumen(esMovil),

                      const SizedBox(height: 32),

                      _buildTituloSeccion(
                        titulo: 'Mi tratamiento',
                        accion: TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const MisTratamientosPage(),
                              ),
                            );
                          },
                          child: const Text('Ver tratamiento'),
                        ),
                      ),

                      const SizedBox(height: 12),

                      _buildMedicamentoPrincipal(),

                      const SizedBox(height: 32),

                      const Text(
                        'Accesos rápidos',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: _textoPrincipal,
                        ),
                      ),

                      const SizedBox(height: 5),

                      const Text(
                        'Consulta la información registrada por tu médico.',
                        style: TextStyle(fontSize: 14, color: _textoSecundario),
                      ),

                      const SizedBox(height: 15),

                      _buildAccesos(context, esMovil),
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

  // ============================================================
  // ENCABEZADO
  // ============================================================

  Widget _buildEncabezado() {
    return Container(
      padding: const EdgeInsets.only(left: 4, right: 4),

      child: Row(
        children: [
          Container(
            width: 5,
            height: 66,
            decoration: BoxDecoration(
              color: _azulPrincipal,
              borderRadius: BorderRadius.circular(5),
            ),
          ),

          const SizedBox(width: 16),

          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                Text(
                  'Bienvenido, Juan',
                  style: TextStyle(
                    fontSize: 29,
                    fontWeight: FontWeight.w700,
                    color: _textoPrincipal,
                    letterSpacing: -0.4,
                  ),
                ),

                SizedBox(height: 7),

                Text(
                  'Aquí puedes consultar tu información médica y organizar tu tratamiento.',
                  style: TextStyle(fontSize: 15, color: _textoSecundario),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // PRÓXIMA TOMA
  // ============================================================

  Widget _buildProximaToma() {
    return Container(
      padding: const EdgeInsets.all(20),

      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF1565C0), Color(0xFF1976D2)],
        ),

        borderRadius: BorderRadius.circular(18),

        boxShadow: [
          BoxShadow(
            color: _azulPrincipal.withValues(alpha: 0.18),
            blurRadius: 18,
            offset: const Offset(0, 7),
          ),
        ],
      ),

      child: Row(
        children: [
          Container(
            width: 58,
            height: 58,

            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.16),
              borderRadius: BorderRadius.circular(15),
            ),

            child: const Icon(
              Icons.medication_outlined,
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
                  'Próxima toma',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),

                SizedBox(height: 4),

                Text(
                  'Amoxicilina 500 mg',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 19,
                    fontWeight: FontWeight.w700,
                  ),
                ),

                SizedBox(height: 4),

                Text(
                  '1 cápsula · Hoy a las 16:00',
                  style: TextStyle(color: Colors.white, fontSize: 14),
                ),
              ],
            ),
          ),

          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),

            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.14),
              borderRadius: BorderRadius.circular(20),
            ),

            child: const Text(
              'En 2 h',
              style: TextStyle(
                color: Colors.white,
                fontSize: 13,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // RESUMEN
  // ============================================================

  Widget _buildResumen(bool esMovil) {
    final tarjetas = [
      _buildIndicador(
        icono: Icons.medication_outlined,
        titulo: 'Medicamentos',
        valor: '2',
        color: _azulPrincipal,
        fondoIcono: _azulClaro,
      ),

      _buildIndicador(
        icono: Icons.event_available_outlined,
        titulo: 'Próximas citas',
        valor: '1',
        color: _verde,
        fondoIcono: _verdeClaro,
      ),

      _buildIndicador(
        icono: Icons.description_outlined,
        titulo: 'Consultas',
        valor: '4',
        color: _violeta,
        fondoIcono: _violetaClaro,
      ),
    ];

    if (esMovil) {
      return Column(
        children: [
          tarjetas[0],
          const SizedBox(height: 12),
          tarjetas[1],
          const SizedBox(height: 12),
          tarjetas[2],
        ],
      );
    }

    return Row(
      children: [
        Expanded(child: tarjetas[0]),
        const SizedBox(width: 16),
        Expanded(child: tarjetas[1]),
        const SizedBox(width: 16),
        Expanded(child: tarjetas[2]),
      ],
    );
  }

  Widget _buildIndicador({
    required IconData icono,
    required String titulo,
    required String valor,
    required Color color,
    required Color fondoIcono,
  }) {
    return Container(
      height: 102,
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 15),

      decoration: BoxDecoration(
        color: _blanco,
        borderRadius: BorderRadius.circular(13),
        border: Border.all(color: _borde),

        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.05),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),

      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,

            decoration: BoxDecoration(
              color: fondoIcono,
              borderRadius: BorderRadius.circular(12),
            ),

            child: Icon(icono, color: color, size: 25),
          ),

          const SizedBox(width: 15),

          Column(
            mainAxisAlignment: MainAxisAlignment.center,

            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              Text(
                titulo,
                style: const TextStyle(fontSize: 13, color: _textoSecundario),
              ),

              const SizedBox(height: 2),

              Text(
                valor,
                style: const TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w700,
                  color: _textoPrincipal,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ============================================================
  // TÍTULO DE SECCIÓN
  // ============================================================

  Widget _buildTituloSeccion({required String titulo, required Widget accion}) {
    return Row(
      children: [
        Expanded(
          child: Text(
            titulo,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: _textoPrincipal,
            ),
          ),
        ),

        accion,
      ],
    );
  }

  // ============================================================
  // MEDICAMENTO PRINCIPAL
  // ============================================================

  Widget _buildMedicamentoPrincipal() {
    return Container(
      padding: const EdgeInsets.all(18),

      decoration: BoxDecoration(
        color: _blanco,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _borde),
      ),

      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 50,
                height: 50,

                decoration: BoxDecoration(
                  color: _azulClaro,
                  borderRadius: BorderRadius.circular(13),
                ),

                child: const Icon(
                  Icons.medication_outlined,
                  color: _azulPrincipal,
                  size: 27,
                ),
              ),

              const SizedBox(width: 14),

              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    Text(
                      'Amoxicilina 500 mg',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: _textoPrincipal,
                      ),
                    ),

                    SizedBox(height: 4),

                    Text(
                      'Antibiótico',
                      style: TextStyle(fontSize: 13, color: _textoSecundario),
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
                  color: _verdeClaro,
                  borderRadius: BorderRadius.circular(20),
                ),

                child: const Text(
                  'Activo',
                  style: TextStyle(
                    color: _verde,
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 18),

          const Divider(height: 1, color: _borde),

          const SizedBox(height: 16),

          Row(
            children: [
              Expanded(
                child: _detalleTratamiento(
                  Icons.medication_liquid_outlined,
                  'Dosis',
                  '1 cápsula',
                ),
              ),

              Expanded(
                child: _detalleTratamiento(
                  Icons.schedule_outlined,
                  'Frecuencia',
                  'Cada 8 horas',
                ),
              ),
            ],
          ),

          const SizedBox(height: 15),

          Row(
            children: [
              Expanded(
                child: _detalleTratamiento(
                  Icons.calendar_today_outlined,
                  'Duración',
                  '7 días',
                ),
              ),

              Expanded(
                child: _detalleTratamiento(
                  Icons.event_outlined,
                  'Finaliza',
                  '14 Oct.',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _detalleTratamiento(IconData icono, String titulo, String valor) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        Icon(icono, size: 19, color: _textoSecundario),

        const SizedBox(width: 8),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              Text(
                titulo,
                style: const TextStyle(fontSize: 12, color: _textoSecundario),
              ),

              const SizedBox(height: 3),

              Text(
                valor,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: _textoPrincipal,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ============================================================
  // ACCESOS RÁPIDOS
  // ============================================================

  Widget _buildAccesos(BuildContext context, bool esMovil) {
    final tarjetas = [
      _buildAcceso(
        context,
        icono: Icons.folder_shared_outlined,
        titulo: 'Mi historia clínica',
        descripcion: 'Consulta la información registrada por tu médico.',
        color: _violeta,
        fondoIcono: _violetaClaro,
        pagina: const MiHistoriaPage(),
      ),

      _buildAcceso(
        context,
        icono: Icons.medical_services_outlined,
        titulo: 'Mis consultas',
        descripcion: 'Revisa tus consultas, diagnósticos e indicaciones.',
        color: _azulPrincipal,
        fondoIcono: _azulClaro,
        pagina: const MisConsultasPage(),
      ),

      _buildAcceso(
        context,
        icono: Icons.calendar_month_outlined,
        titulo: 'Mis citas',
        descripcion: 'Consulta tus próximas citas médicas.',
        color: _verde,
        fondoIcono: _verdeClaro,
        pagina: const MisCitasPage(),
      ),

      _buildAcceso(
        context,
        icono: Icons.medication_outlined,
        titulo: 'Mis medicamentos',
        descripcion: 'Organiza tus dosis y horarios de tratamiento.',
        color: _naranja,
        fondoIcono: _naranjaClaro,
        pagina: const MisTratamientosPage(),
      ),
    ];

    if (esMovil) {
      return Column(
        children: [
          tarjetas[0],
          const SizedBox(height: 12),
          tarjetas[1],
          const SizedBox(height: 12),
          tarjetas[2],
          const SizedBox(height: 12),
          tarjetas[3],
        ],
      );
    }

    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: 14,
      mainAxisSpacing: 14,
      childAspectRatio: 3.1,
      children: tarjetas,
    );
  }

  Widget _buildAcceso(
    BuildContext context, {
    required IconData icono,
    required String titulo,
    required String descripcion,
    required Color color,
    required Color fondoIcono,
    required Widget pagina,
  }) {
    return Material(
      color: Colors.transparent,

      child: InkWell(
        borderRadius: BorderRadius.circular(14),

        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => pagina),
          );
        },

        child: Container(
          constraints: const BoxConstraints(minHeight: 105),

          padding: const EdgeInsets.all(16),

          decoration: BoxDecoration(
            color: _blanco,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: _borde),
          ),

          child: Row(
            children: [
              Container(
                width: 49,
                height: 49,

                decoration: BoxDecoration(
                  color: fondoIcono,
                  borderRadius: BorderRadius.circular(12),
                ),

                child: Icon(icono, color: color, size: 24),
              ),

              const SizedBox(width: 14),

              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,

                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    Text(
                      titulo,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,

                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: _textoPrincipal,
                      ),
                    ),

                    const SizedBox(height: 4),

                    Text(
                      descripcion,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,

                      style: const TextStyle(
                        fontSize: 12,
                        color: _textoSecundario,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 8),

              Icon(
                Icons.chevron_right,
                size: 22,
                color: color.withValues(alpha: 0.65),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ============================================================
  // MENSAJE
  // ============================================================

  void _mostrarMensaje(BuildContext context, String mensaje) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: _textoPrincipal,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        content: Text(mensaje, style: const TextStyle(color: Colors.white)),
      ),
    );
  }
}
