import 'package:flutter/material.dart';

import 'pacientes_page.dart';
import 'historias_clinicas_page.dart';
import 'consultas_page.dart';
import 'agenda_page.dart';
import 'reportes_page.dart';

class HomeMedicoPage extends StatelessWidget {
  const HomeMedicoPage({super.key});

  // ============================================================
  // PALETA
  // ============================================================

  static const Color _azulPrincipal = Color(0xFF1565C0);
  static const Color _azulClaro = Color(0xFFE3F2FD);
  static const Color _fondo = Color(0xFFF5F7FA);
  static const Color _blanco = Color(0xFFFFFFFF);
  static const Color _textoPrincipal = Color(0xFF172033);
  static const Color _textoSecundario = Color(0xFF607D8B);
  static const Color _borde = Color(0xFFE1E7EF);

  // Verde
  static const Color _verde = Color(0xFF2E7D32);
  static const Color _verdeClaro = Color(0xFFE8F5E9);

  // Naranja
  static const Color _naranja = Color(0xFFEF6C00);
  static const Color _naranjaClaro = Color(0xFFFFF3E0);

  // Violeta discreto
  static const Color _violeta = Color(0xFF5E5CE6);
  static const Color _violetaClaro = Color(0xFFEEEEFF);

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
        titleSpacing: 24,

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
              'Portal de la Clínica',
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
              _mostrarMensaje(
                context,
                'No tienes nuevas notificaciones.',
              );
            },
          ),

          const SizedBox(width: 4),

          IconButton(
            tooltip: 'Cerrar sesión',
            icon: const Icon(
              Icons.logout_outlined,
              color: _textoSecundario,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),

          const SizedBox(width: 14),
        ],
      ),

      // ==========================================================
      // BODY
      // ==========================================================

      body: SafeArea(
        child: LayoutBuilder(
          builder: (
            context,
            constraints,
          ) {
            final bool esMovil = constraints.maxWidth < 700;

            return SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                horizontal: esMovil ? 16 : 32,
                vertical: esMovil ? 20 : 30,
              ),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(
                    maxWidth: 1180,
                  ),
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.stretch,
                    children: [
                      // ==================================================
                      // BIENVENIDA
                      // ==================================================

                      _buildEncabezado(),

                      const SizedBox(height: 26),

                      // ==================================================
                      // INDICADORES
                      // ==================================================

                      _buildIndicadores(
                        esMovil,
                      ),

                      const SizedBox(height: 34),

                      // ==================================================
                      // CITAS
                      // ==================================================

                      _buildTituloSeccion(
                        titulo: 'Citas de hoy',
                        accion: TextButton.icon(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) =>
                                    const AgendaPage(),
                              ),
                            );
                          },
                          icon: const Icon(
                            Icons.calendar_month_outlined,
                            size: 17,
                          ),
                          label: const Text(
                            'Ver todas',
                          ),
                          style: TextButton.styleFrom(
                            foregroundColor:
                                _azulPrincipal,
                          ),
                        ),
                      ),

                      const SizedBox(height: 13),

                      _buildCitas(),

                      const SizedBox(height: 34),

                      // ==================================================
                      // GESTIÓN MÉDICA
                      // ==================================================

                      const Text(
                        'Gestión médica',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: _textoPrincipal,
                        ),
                      ),

                      const SizedBox(height: 5),

                      const Text(
                        'Accede rápidamente a los módulos de atención.',
                        style: TextStyle(
                          fontSize: 14,
                          color: _textoSecundario,
                        ),
                      ),

                      const SizedBox(height: 15),

                      _buildGestion(
                        context,
                        esMovil,
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

  // ============================================================
  // ENCABEZADO
  // ============================================================

  Widget _buildEncabezado() {
    return Container(
      padding: const EdgeInsets.only(
        left: 4,
        right: 4,
      ),
      child: Row(
        children: [
          Container(
            width: 5,
            height: 64,
            decoration: BoxDecoration(
              color: _azulPrincipal,
              borderRadius: BorderRadius.circular(5),
            ),
          ),

          const SizedBox(width: 16),

          const Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Text(
                  'Bienvenido, Médico',
                  style: TextStyle(
                    fontSize: 29,
                    fontWeight: FontWeight.w700,
                    color: _textoPrincipal,
                    letterSpacing: -0.4,
                  ),
                ),
                SizedBox(height: 7),
                Text(
                  'Aquí tienes el resumen de tu jornada.',
                  style: TextStyle(
                    fontSize: 15,
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

  // ============================================================
  // INDICADORES
  // ============================================================

  Widget _buildIndicadores(
    bool esMovil,
  ) {
    final tarjetas = [
      _buildIndicador(
        icono: Icons.people_outline,
        titulo: 'Pacientes',
        valor: '42',
        color: _azulPrincipal,
        fondoIcono: _azulClaro,
      ),

      _buildIndicador(
        icono: Icons.calendar_today_outlined,
        titulo: 'Citas hoy',
        valor: '7',
        color: _verde,
        fondoIcono: _verdeClaro,
      ),

      _buildIndicador(
        icono: Icons.pending_actions_outlined,
        titulo: 'Pendientes',
        valor: '3',
        color: _naranja,
        fondoIcono: _naranjaClaro,
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
        Expanded(
          child: tarjetas[0],
        ),
        const SizedBox(width: 16),
        Expanded(
          child: tarjetas[1],
        ),
        const SizedBox(width: 16),
        Expanded(
          child: tarjetas[2],
        ),
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
      padding: const EdgeInsets.symmetric(
        horizontal: 18,
        vertical: 15,
      ),
      decoration: BoxDecoration(
        color: _blanco,
        borderRadius: BorderRadius.circular(13),
        border: Border.all(
          color: _borde,
        ),
        boxShadow: [
          BoxShadow(
            color: color.withValues(
              alpha: 0.06,
            ),
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
            child: Icon(
              icono,
              color: color,
              size: 25,
            ),
          ),

          const SizedBox(width: 15),

          Column(
            mainAxisAlignment:
                MainAxisAlignment.center,
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [
              Text(
                titulo,
                style: const TextStyle(
                  fontSize: 13,
                  color: _textoSecundario,
                ),
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

  Widget _buildTituloSeccion({
    required String titulo,
    required Widget accion,
  }) {
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
  // CITAS
  // ============================================================

  Widget _buildCitas() {
    return Column(
      children: [
        _buildCita(
          nombre: 'Juan Pérez',
          hora: '09:00',
          motivo: 'Consulta general',
          estado: 'Confirmada',
          confirmada: true,
        ),

        const SizedBox(height: 10),

        _buildCita(
          nombre: 'María López',
          hora: '10:00',
          motivo: 'Control médico',
          estado: 'Pendiente',
          confirmada: false,
        ),

        const SizedBox(height: 10),

        _buildCita(
          nombre: 'Pedro García',
          hora: '11:30',
          motivo: 'Seguimiento',
          estado: 'Confirmada',
          confirmada: true,
        ),
      ],
    );
  }

  Widget _buildCita({
    required String nombre,
    required String hora,
    required String motivo,
    required String estado,
    required bool confirmada,
  }) {
    final Color colorEstado =
        confirmada ? _verde : _naranja;

    final Color fondoEstado =
        confirmada ? _verdeClaro : _naranjaClaro;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          // La gestión completa de citas se realiza
          // desde AgendaPage.
        },
        child: Container(
          constraints: const BoxConstraints(
            minHeight: 78,
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: 17,
            vertical: 13,
          ),
          decoration: BoxDecoration(
            color: _blanco,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: _borde,
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  gradient:
                      const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      _azulClaro,
                      Color(0xFFD7ECFC),
                    ],
                  ),
                  borderRadius:
                      BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.person_outline,
                  color: _azulPrincipal,
                  size: 24,
                ),
              ),

              const SizedBox(width: 14),

              Expanded(
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  mainAxisAlignment:
                      MainAxisAlignment.center,
                  children: [
                    Text(
                      nombre,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: _textoPrincipal,
                      ),
                    ),

                    const SizedBox(height: 3),

                    Text(
                      motivo,
                      style: const TextStyle(
                        fontSize: 13,
                        color: _textoSecundario,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 12),

              Column(
                crossAxisAlignment:
                    CrossAxisAlignment.end,
                mainAxisAlignment:
                    MainAxisAlignment.center,
                children: [
                  Text(
                    hora,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: _textoPrincipal,
                    ),
                  ),

                  const SizedBox(height: 5),

                  Container(
                    padding:
                        const EdgeInsets.symmetric(
                      horizontal: 9,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: fondoEstado,
                      borderRadius:
                          BorderRadius.circular(20),
                    ),
                    child: Text(
                      estado,
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight:
                            FontWeight.w600,
                        color: colorEstado,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ============================================================
  // GESTIÓN MÉDICA
  // ============================================================

  Widget _buildGestion(
    BuildContext context,
    bool esMovil,
  ) {
    final tarjetas = [
      // ----------------------------------------------------------
      // PACIENTES
      // ----------------------------------------------------------

      _buildModulo(
        context,
        icono: Icons.people_outline,
        titulo: 'Pacientes',
        descripcion: 'Gestionar pacientes',
        color: _azulPrincipal,
        fondoIcono: _azulClaro,
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const PacientesPage(),
            ),
          );
        },
      ),

      // ----------------------------------------------------------
      // HISTORIAS CLÍNICAS
      // ----------------------------------------------------------

      _buildModulo(
        context,
        icono: Icons.folder_shared_outlined,
        titulo: 'Historias clínicas',
        descripcion: 'Consultar historias clínicas',
        color: _violeta,
        fondoIcono: _violetaClaro,
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) =>
                  const HistoriasClinicasPage(),
            ),
          );
        },
      ),

      // ----------------------------------------------------------
      // CONSULTAS
      // ----------------------------------------------------------

      _buildModulo(
        context,
        icono: Icons.medical_services_outlined,
        titulo: 'Consultas',
        descripcion: 'Gestionar consultas médicas',
        color: _azulPrincipal,
        fondoIcono: _azulClaro,
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const ConsultasPage(),
            ),
          );
        },
      ),

      // ----------------------------------------------------------
      // AGENDA
      // ----------------------------------------------------------

      _buildModulo(
        context,
        icono: Icons.calendar_month_outlined,
        titulo: 'Agenda',
        descripcion: 'Gestionar agenda médica',
        color: _verde,
        fondoIcono: _verdeClaro,
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const AgendaPage(),
            ),
          );
        },
      ),

      // ----------------------------------------------------------
      // REPORTES
      // ----------------------------------------------------------

      _buildModulo(
        context,
        icono: Icons.bar_chart_outlined,
        titulo: 'Reportes',
        descripcion: 'Consultar reportes',
        color: _naranja,
        fondoIcono: _naranjaClaro,
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const ReportesPage(),
            ),
          );
        },
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
          const SizedBox(height: 12),
          tarjetas[4],
        ],
      );
    }

    return GridView.count(
      crossAxisCount: 3,
      shrinkWrap: true,
      physics:
          const NeverScrollableScrollPhysics(),
      crossAxisSpacing: 14,
      mainAxisSpacing: 14,
      childAspectRatio: 2.65,
      children: tarjetas,
    );
  }

  Widget _buildModulo(
    BuildContext context, {
    required IconData icono,
    required String titulo,
    required String descripcion,
    required Color color,
    required Color fondoIcono,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius:
            BorderRadius.circular(13),
        hoverColor:
            color.withValues(alpha: 0.035),
        splashColor:
            color.withValues(alpha: 0.08),
        child: Container(
          constraints: const BoxConstraints(
            minHeight: 104,
          ),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: _blanco,
            borderRadius:
                BorderRadius.circular(13),
            border: Border.all(
              color: _borde,
            ),
            boxShadow: [
              BoxShadow(
                color: color.withValues(
                  alpha: 0.045,
                ),
                blurRadius: 10,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                width: 49,
                height: 49,
                decoration: BoxDecoration(
                  color: fondoIcono,
                  borderRadius:
                      BorderRadius.circular(12),
                ),
                child: Icon(
                  icono,
                  color: color,
                  size: 24,
                ),
              ),

              const SizedBox(width: 14),

              Expanded(
                child: Column(
                  mainAxisAlignment:
                      MainAxisAlignment.center,
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    Text(
                      titulo,
                      maxLines: 1,
                      overflow:
                          TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight:
                            FontWeight.w600,
                        color: _textoPrincipal,
                      ),
                    ),

                    const SizedBox(height: 4),

                    Text(
                      descripcion,
                      maxLines: 2,
                      overflow:
                          TextOverflow.ellipsis,
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
                color: color.withValues(
                  alpha: 0.65,
                ),
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

  void _mostrarMensaje(
    BuildContext context,
    String mensaje,
  ) {
    ScaffoldMessenger.of(context)
        .showSnackBar(
      SnackBar(
        behavior:
            SnackBarBehavior.floating,
        backgroundColor:
            _textoPrincipal,
        shape:
            RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(10),
        ),
        content: Text(
          mensaje,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}