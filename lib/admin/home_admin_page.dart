import 'package:flutter/material.dart';

import 'usuarios_page.dart';
import 'medicos_page.dart';
import 'pacientes_page.dart';
import 'citas_page.dart';
import 'medicamentos_page.dart';
import 'reportes_admin_page.dart';

class HomeAdminPage extends StatelessWidget {
  const HomeAdminPage({super.key});

  static const Color azulPrincipal = Color(0xFF1565C0);
  static const Color azulClaro = Color(0xFFE3F2FD);
  static const Color fondo = Color(0xFFF5F7FA);
  static const Color textoPrincipal = Color(0xFF172033);
  static const Color textoSecundario = Color(0xFF607D8B);
  static const Color verde = Color(0xFF2E7D32);
  static const Color naranja = Color(0xFFEF6C00);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: fondo,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        titleSpacing: 20,
        title: const Text(
          'Portal de Administración',
          style: TextStyle(
            color: textoPrincipal,
            fontWeight: FontWeight.w700,
            fontSize: 20,
          ),
        ),
        actions: [
          IconButton(
            tooltip: 'Notificaciones',
            onPressed: () {
              _mostrarNotificaciones(context);
            },
            icon: const Icon(
              Icons.notifications_none_outlined,
              color: textoPrincipal,
            ),
          ),
          IconButton(
            tooltip: 'Cerrar sesión',
            onPressed: () {
              _mostrarCerrarSesion(context);
            },
            icon: const Icon(Icons.logout_outlined, color: textoPrincipal),
          ),
          const SizedBox(width: 12),
        ],
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 1400),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _construirBienvenida(),
                      const SizedBox(height: 24),
                      _construirResumen(),
                      const SizedBox(height: 28),
                      _construirTituloSeccion(
                        'Gestión del sistema',
                        'Administra los principales módulos de la clínica.',
                      ),
                      const SizedBox(height: 14),
                      _construirModulos(context),
                      const SizedBox(height: 28),
                      _construirActividadReciente(),
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

  Widget _construirBienvenida() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: azulPrincipal,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(18),
            ),
            child: const Icon(
              Icons.admin_panel_settings_outlined,
              color: Colors.white,
              size: 34,
            ),
          ),
          const SizedBox(width: 18),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Bienvenido, Administrador',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 23,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  'Gestiona usuarios, profesionales, pacientes, citas y recursos de la clínica.',
                  style: TextStyle(color: Colors.white70, fontSize: 14),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _construirResumen() {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 700) {
          return Column(
            children: [
              _tarjetaResumen(
                titulo: 'Pacientes',
                valor: '47',
                detalle: 'Registrados',
                icono: Icons.people_outline,
                color: azulPrincipal,
              ),
              const SizedBox(height: 12),
              _tarjetaResumen(
                titulo: 'Médicos',
                valor: '8',
                detalle: 'Profesionales',
                icono: Icons.medical_services_outlined,
                color: verde,
              ),
              const SizedBox(height: 12),
              _tarjetaResumen(
                titulo: 'Usuarios',
                valor: '58',
                detalle: 'Cuentas activas',
                icono: Icons.manage_accounts_outlined,
                color: naranja,
              ),
              const SizedBox(height: 12),
              _tarjetaResumen(
                titulo: 'Citas hoy',
                valor: '12',
                detalle: 'Programadas',
                icono: Icons.event_outlined,
                color: Colors.purple,
              ),
            ],
          );
        }

        return Row(
          children: [
            Expanded(
              child: _tarjetaResumen(
                titulo: 'Pacientes',
                valor: '47',
                detalle: 'Registrados',
                icono: Icons.people_outline,
                color: azulPrincipal,
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: _tarjetaResumen(
                titulo: 'Médicos',
                valor: '8',
                detalle: 'Profesionales',
                icono: Icons.medical_services_outlined,
                color: verde,
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: _tarjetaResumen(
                titulo: 'Usuarios',
                valor: '58',
                detalle: 'Cuentas activas',
                icono: Icons.manage_accounts_outlined,
                color: naranja,
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: _tarjetaResumen(
                titulo: 'Citas hoy',
                valor: '12',
                detalle: 'Programadas',
                icono: Icons.event_outlined,
                color: Colors.purple,
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _tarjetaResumen({
    required String titulo,
    required String valor,
    required String detalle,
    required IconData icono,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(17),
        border: Border.all(color: const Color(0xFFE6EAF0)),
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.10),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(icono, color: color, size: 25),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  titulo,
                  style: const TextStyle(color: textoSecundario, fontSize: 13),
                ),
                const SizedBox(height: 3),
                Text(
                  valor,
                  style: const TextStyle(
                    color: textoPrincipal,
                    fontSize: 23,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                Text(
                  detalle,
                  style: const TextStyle(color: textoSecundario, fontSize: 11),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _construirTituloSeccion(String titulo, String subtitulo) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          titulo,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w800,
            color: textoPrincipal,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          subtitulo,
          style: const TextStyle(fontSize: 13, color: textoSecundario),
        ),
      ],
    );
  }

  Widget _construirModulos(BuildContext context) {
    final modulos = [
      _ModuloAdmin(
        titulo: 'Usuarios',
        descripcion: 'Cuentas y roles',
        icono: Icons.manage_accounts_outlined,
        color: azulPrincipal,
      ),
      _ModuloAdmin(
        titulo: 'Médicos',
        descripcion: 'Profesionales y especialidades',
        icono: Icons.medical_services_outlined,
        color: verde,
      ),
      _ModuloAdmin(
        titulo: 'Pacientes',
        descripcion: 'Datos administrativos',
        icono: Icons.people_outline,
        color: Colors.indigo,
      ),
      _ModuloAdmin(
        titulo: 'Citas',
        descripcion: 'Agenda y programación',
        icono: Icons.event_outlined,
        color: naranja,
      ),
      _ModuloAdmin(
        titulo: 'Medicamentos',
        descripcion: 'Catálogo de medicamentos',
        icono: Icons.medication_outlined,
        color: Colors.teal,
      ),
      _ModuloAdmin(
        titulo: 'Reportes',
        descripcion: 'Indicadores del sistema',
        icono: Icons.analytics_outlined,
        color: Colors.purple,
      ),
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        int columnas;

        if (constraints.maxWidth >= 1100) {
          columnas = 3;
        } else if (constraints.maxWidth >= 700) {
          columnas = 2;
        } else {
          columnas = 1;
        }

        final ancho = (constraints.maxWidth - ((columnas - 1) * 14)) / columnas;

        return Wrap(
          spacing: 14,
          runSpacing: 14,
          children: modulos.map((modulo) {
            return SizedBox(
              width: ancho,
              child: _tarjetaModulo(context, modulo),
            );
          }).toList(),
        );
      },
    );
  }

  Widget _tarjetaModulo(BuildContext context, _ModuloAdmin modulo) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(17),
      child: InkWell(
        borderRadius: BorderRadius.circular(17),
        onTap: () {
          _abrirModulo(context, modulo.titulo);
        },
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(17),
            border: Border.all(color: const Color(0xFFE6EAF0)),
          ),
          child: Row(
            children: [
              Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  color: modulo.color.withValues(alpha: 0.10),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Icon(modulo.icono, color: modulo.color, size: 27),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      modulo.titulo,
                      style: const TextStyle(
                        color: textoPrincipal,
                        fontSize: 15,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      modulo.descripcion,
                      style: const TextStyle(
                        color: textoSecundario,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right, color: textoSecundario),
            ],
          ),
        ),
      ),
    );
  }

  Widget _construirActividadReciente() {
    final actividades = [
      _ActividadAdmin(
        icono: Icons.person_add_outlined,
        titulo: 'Nuevo paciente registrado',
        descripcion: 'Juan Pérez',
        tiempo: 'Hoy, 09:15',
        color: azulPrincipal,
      ),
      _ActividadAdmin(
        icono: Icons.medical_services_outlined,
        titulo: 'Nuevo médico registrado',
        descripcion: 'Dr. Carlos Mendoza',
        tiempo: 'Hoy, 10:20',
        color: verde,
      ),
      _ActividadAdmin(
        icono: Icons.event_outlined,
        titulo: 'Nueva cita programada',
        descripcion: 'María López',
        tiempo: 'Hoy, 11:05',
        color: naranja,
      ),
      _ActividadAdmin(
        icono: Icons.medication_outlined,
        titulo: 'Medicamento agregado',
        descripcion: 'Amoxicilina 500 mg',
        tiempo: 'Ayer, 16:40',
        color: Colors.teal,
      ),
    ];

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFE6EAF0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: azulClaro,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.history_outlined,
                  color: azulPrincipal,
                  size: 22,
                ),
              ),
              const SizedBox(width: 12),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Actividad reciente',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w800,
                      color: textoPrincipal,
                    ),
                  ),
                  SizedBox(height: 3),
                  Text(
                    'Últimos movimientos del sistema',
                    style: TextStyle(fontSize: 12, color: textoSecundario),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 22),
          ...actividades.map(
            (actividad) => Padding(
              padding: const EdgeInsets.only(bottom: 18),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 42,
                    height: 42,
                    decoration: BoxDecoration(
                      color: actividad.color.withValues(alpha: 0.10),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      actividad.icono,
                      color: actividad.color,
                      size: 21,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          actividad.titulo,
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            color: textoPrincipal,
                          ),
                        ),
                        const SizedBox(height: 3),
                        Text(
                          actividad.descripcion,
                          style: const TextStyle(
                            fontSize: 12,
                            color: textoSecundario,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    actividad.tiempo,
                    style: const TextStyle(
                      fontSize: 11,
                      color: textoSecundario,
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

  void _abrirModulo(BuildContext context, String modulo) {
    switch (modulo) {
      case 'Usuarios':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const UsuariosPage()),
        );
        break;

      case 'Médicos':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const MedicosPage()),
        );
        break;

      case 'Pacientes':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const PacientesPage()),
        );
        break;

      case 'Citas':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const CitasPage()),
        );
        break;

      case 'Medicamentos':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const MedicamentosPage()),
        );
        break;

      case 'Reportes':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const ReportesPage()),
        );
        break;
    }
  }

  void _mostrarNotificaciones(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(22)),
      ),
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24, 20, 24, 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 42,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(height: 22),
                const Text(
                  'Notificaciones',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    color: textoPrincipal,
                  ),
                ),
                const SizedBox(height: 18),
                _notificacion(
                  icono: Icons.event_outlined,
                  titulo: 'Citas pendientes',
                  descripcion: 'Hay 7 citas pendientes de atención.',
                  color: naranja,
                ),
                const SizedBox(height: 14),
                _notificacion(
                  icono: Icons.people_outline,
                  titulo: 'Nuevos pacientes',
                  descripcion: 'Se registraron nuevos pacientes recientemente.',
                  color: azulPrincipal,
                ),
                const SizedBox(height: 14),
                _notificacion(
                  icono: Icons.medication_outlined,
                  titulo: 'Catálogo actualizado',
                  descripcion: 'Se agregó un nuevo medicamento.',
                  color: Colors.teal,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _notificacion({
    required IconData icono,
    required String titulo,
    required String descripcion,
    required Color color,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.10),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icono, color: color),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                titulo,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: textoPrincipal,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                descripcion,
                style: const TextStyle(fontSize: 12, color: textoSecundario),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _mostrarCerrarSesion(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text(
            'Cerrar sesión',
            style: TextStyle(fontWeight: FontWeight.w700),
          ),
          content: const Text('¿Deseas cerrar la sesión del administrador?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
              },
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: azulPrincipal,
                foregroundColor: Colors.white,
              ),
              onPressed: () {
                Navigator.pop(dialogContext);

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      'La funcionalidad de cierre de sesión se conectará al sistema de autenticación.',
                    ),
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              },
              child: const Text('Cerrar sesión'),
            ),
          ],
        );
      },
    );
  }
}

class _ModuloAdmin {
  final String titulo;
  final String descripcion;
  final IconData icono;
  final Color color;

  _ModuloAdmin({
    required this.titulo,
    required this.descripcion,
    required this.icono,
    required this.color,
  });
}

class _ActividadAdmin {
  final IconData icono;
  final String titulo;
  final String descripcion;
  final String tiempo;
  final Color color;

  _ActividadAdmin({
    required this.icono,
    required this.titulo,
    required this.descripcion,
    required this.tiempo,
    required this.color,
  });
}
