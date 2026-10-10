import 'package:flutter/material.dart';

class ReportesPage extends StatefulWidget {
  const ReportesPage({super.key});

  @override
  State<ReportesPage> createState() => _ReportesPageState();
}

class _ReportesPageState extends State<ReportesPage> {
  static const Color azulPrincipal = Color(0xFF1565C0);
  static const Color azulClaro = Color(0xFFE3F2FD);
  static const Color fondo = Color(0xFFF5F7FA);
  static const Color textoPrincipal = Color(0xFF172033);
  static const Color textoSecundario = Color(0xFF607D8B);
  static const Color verde = Color(0xFF2E7D32);
  static const Color naranja = Color(0xFFEF6C00);
  static const Color rojo = Color(0xFFC62828);

  String _periodo = 'Este mes';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: fondo,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: textoPrincipal),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Reportes',
          style: TextStyle(color: textoPrincipal, fontWeight: FontWeight.w700),
        ),
        actions: [
          IconButton(
            tooltip: 'Actualizar',
            icon: const Icon(Icons.refresh_outlined, color: textoPrincipal),
            onPressed: () {
              setState(() {});
            },
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _construirEncabezado(),
              const SizedBox(height: 24),
              _construirFiltros(),
              const SizedBox(height: 24),
              _construirIndicadores(),
              const SizedBox(height: 24),
              _construirResumenGeneral(),
              const SizedBox(height: 24),
              _construirActividadSemanal(),
              const SizedBox(height: 24),
              _construirCitasPorEstado(),
              const SizedBox(height: 24),
              _construirEspecialidades(),
              const SizedBox(height: 24),
              _construirActividadReciente(),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  Widget _construirEncabezado() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Reportes del sistema',
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.w800,
            color: textoPrincipal,
          ),
        ),
        const SizedBox(height: 6),
        const Text(
          'Consulta indicadores generales y actividad de la clínica.',
          style: TextStyle(fontSize: 14, color: textoSecundario),
        ),
      ],
    );
  }

  Widget _construirFiltros() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE6EAF0)),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth < 650) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _selectorPeriodo(),
                const SizedBox(height: 12),
                _botonExportar(),
              ],
            );
          }

          return Row(
            children: [
              Expanded(child: _selectorPeriodo()),
              const SizedBox(width: 12),
              _botonExportar(),
            ],
          );
        },
      ),
    );
  }

  Widget _selectorPeriodo() {
    return DropdownButtonFormField<String>(
      initialValue: _periodo,
      decoration: InputDecoration(
        labelText: 'Periodo',
        prefixIcon: const Icon(Icons.calendar_month_outlined),
        filled: true,
        fillColor: fondo,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
      items: const [
        DropdownMenuItem(value: 'Hoy', child: Text('Hoy')),
        DropdownMenuItem(value: 'Esta semana', child: Text('Esta semana')),
        DropdownMenuItem(value: 'Este mes', child: Text('Este mes')),
        DropdownMenuItem(value: 'Este año', child: Text('Este año')),
      ],
      onChanged: (value) {
        if (value == null) return;

        setState(() {
          _periodo = value;
        });
      },
    );
  }

  Widget _botonExportar() {
    return SizedBox(
      height: 54,
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          backgroundColor: azulPrincipal,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        onPressed: _exportarReporte,
        icon: const Icon(Icons.file_download_outlined),
        label: const Text('Exportar reporte'),
      ),
    );
  }

  Widget _construirIndicadores() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final ancho = constraints.maxWidth;

        if (ancho < 700) {
          return Column(
            children: [
              _indicador(
                titulo: 'Pacientes',
                valor: '47',
                descripcion: 'Registrados',
                icono: Icons.people_outline,
                color: azulPrincipal,
              ),
              const SizedBox(height: 12),
              _indicador(
                titulo: 'Médicos',
                valor: '8',
                descripcion: 'Profesionales',
                icono: Icons.medical_services_outlined,
                color: verde,
              ),
              const SizedBox(height: 12),
              _indicador(
                titulo: 'Consultas',
                valor: '78',
                descripcion: 'Atendidas',
                icono: Icons.assignment_outlined,
                color: naranja,
              ),
              const SizedBox(height: 12),
              _indicador(
                titulo: 'Citas',
                valor: '35',
                descripcion: 'Programadas',
                icono: Icons.event_outlined,
                color: rojo,
              ),
            ],
          );
        }

        return Row(
          children: [
            Expanded(
              child: _indicador(
                titulo: 'Pacientes',
                valor: '47',
                descripcion: 'Registrados',
                icono: Icons.people_outline,
                color: azulPrincipal,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _indicador(
                titulo: 'Médicos',
                valor: '8',
                descripcion: 'Profesionales',
                icono: Icons.medical_services_outlined,
                color: verde,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _indicador(
                titulo: 'Consultas',
                valor: '78',
                descripcion: 'Atendidas',
                icono: Icons.assignment_outlined,
                color: naranja,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _indicador(
                titulo: 'Citas',
                valor: '35',
                descripcion: 'Programadas',
                icono: Icons.event_outlined,
                color: rojo,
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _indicador({
    required String titulo,
    required String valor,
    required String descripcion,
    required IconData icono,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
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
                  style: const TextStyle(fontSize: 13, color: textoSecundario),
                ),
                const SizedBox(height: 3),
                Text(
                  valor,
                  style: const TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.w800,
                    color: textoPrincipal,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  descripcion,
                  style: const TextStyle(fontSize: 11, color: textoSecundario),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _construirResumenGeneral() {
    return _seccion(
      titulo: 'Resumen general',
      subtitulo: 'Indicadores principales de la clínica',
      icono: Icons.analytics_outlined,
      child: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth < 700) {
            return Column(
              children: [
                _filaResumen('Pacientes activos', '44', '93.6%', azulPrincipal),
                const Divider(height: 24),
                _filaResumen('Citas atendidas', '28', '80.0%', verde),
                const Divider(height: 24),
                _filaResumen('Citas pendientes', '7', '20.0%', naranja),
                const Divider(height: 24),
                _filaResumen(
                  'Consultas realizadas',
                  '78',
                  'Este periodo',
                  azulPrincipal,
                ),
              ],
            );
          }

          return Row(
            children: [
              Expanded(
                child: _filaResumen(
                  'Pacientes activos',
                  '44',
                  '93.6%',
                  azulPrincipal,
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: _filaResumen('Citas atendidas', '28', '80.0%', verde),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: _filaResumen('Citas pendientes', '7', '20.0%', naranja),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: _filaResumen(
                  'Consultas realizadas',
                  '78',
                  'Este periodo',
                  azulPrincipal,
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _filaResumen(
    String titulo,
    String valor,
    String detalle,
    Color color,
  ) {
    return Row(
      children: [
        Container(
          width: 8,
          height: 48,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                titulo,
                style: const TextStyle(fontSize: 13, color: textoSecundario),
              ),
              const SizedBox(height: 4),
              Text(
                valor,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  color: textoPrincipal,
                ),
              ),
              Text(
                detalle,
                style: TextStyle(
                  fontSize: 11,
                  color: color,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _construirActividadSemanal() {
    final datos = [
      _DatoGrafico('Lun', 10),
      _DatoGrafico('Mar', 14),
      _DatoGrafico('Mié', 8),
      _DatoGrafico('Jue', 17),
      _DatoGrafico('Vie', 13),
      _DatoGrafico('Sáb', 6),
      _DatoGrafico('Dom', 3),
    ];

    return _seccion(
      titulo: 'Consultas por día',
      subtitulo: 'Actividad registrada durante la semana',
      icono: Icons.bar_chart_outlined,
      child: SizedBox(
        height: 250,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: datos.map((dato) {
            return Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      '${dato.valor}',
                      style: const TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        color: textoSecundario,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Container(
                      height: dato.valor * 8.5,
                      decoration: BoxDecoration(
                        color: azulPrincipal,
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(8),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      dato.dia,
                      style: const TextStyle(
                        fontSize: 11,
                        color: textoSecundario,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _construirCitasPorEstado() {
    return _seccion(
      titulo: 'Estado de las citas',
      subtitulo: 'Distribución de citas del periodo',
      icono: Icons.event_available_outlined,
      child: Column(
        children: [
          _barraEstado(
            titulo: 'Atendidas',
            cantidad: 28,
            total: 35,
            color: verde,
          ),
          const SizedBox(height: 18),
          _barraEstado(
            titulo: 'Confirmadas',
            cantidad: 18,
            total: 35,
            color: azulPrincipal,
          ),
          const SizedBox(height: 18),
          _barraEstado(
            titulo: 'Pendientes',
            cantidad: 7,
            total: 35,
            color: naranja,
          ),
          const SizedBox(height: 18),
          _barraEstado(
            titulo: 'Canceladas',
            cantidad: 2,
            total: 35,
            color: rojo,
          ),
        ],
      ),
    );
  }

  Widget _barraEstado({
    required String titulo,
    required int cantidad,
    required int total,
    required Color color,
  }) {
    final porcentaje = cantidad / total;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                titulo,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: textoPrincipal,
                ),
              ),
            ),
            Text(
              '$cantidad',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w800,
                color: color,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: LinearProgressIndicator(
            value: porcentaje,
            minHeight: 9,
            backgroundColor: const Color(0xFFE9EDF2),
            valueColor: AlwaysStoppedAnimation<Color>(color),
          ),
        ),
      ],
    );
  }

  Widget _construirEspecialidades() {
    final especialidades = [
      _Especialidad(
        nombre: 'Medicina General',
        consultas: 31,
        porcentaje: 0.40,
      ),
      _Especialidad(nombre: 'Pediatría', consultas: 18, porcentaje: 0.23),
      _Especialidad(nombre: 'Cardiología', consultas: 12, porcentaje: 0.15),
      _Especialidad(nombre: 'Ginecología', consultas: 9, porcentaje: 0.12),
      _Especialidad(nombre: 'Dermatología', consultas: 8, porcentaje: 0.10),
    ];

    return _seccion(
      titulo: 'Consultas por especialidad',
      subtitulo: 'Distribución de atención médica',
      icono: Icons.medical_services_outlined,
      child: Column(
        children: especialidades.map((especialidad) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 18),
            child: Row(
              children: [
                Container(
                  width: 42,
                  height: 42,
                  decoration: BoxDecoration(
                    color: azulClaro,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.medical_services_outlined,
                    color: azulPrincipal,
                    size: 21,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              especialidad.nombre,
                              style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: textoPrincipal,
                              ),
                            ),
                          ),
                          Text(
                            '${especialidad.consultas}',
                            style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w800,
                              color: textoPrincipal,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 7),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: LinearProgressIndicator(
                          value: especialidad.porcentaje,
                          minHeight: 7,
                          backgroundColor: const Color(0xFFE9EDF2),
                          valueColor: const AlwaysStoppedAnimation<Color>(
                            azulPrincipal,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _construirActividadReciente() {
    final actividades = [
      _Actividad(
        icono: Icons.person_add_outlined,
        titulo: 'Nuevo paciente registrado',
        descripcion: 'Juan Pérez',
        fecha: 'Hoy, 09:15',
        color: azulPrincipal,
      ),
      _Actividad(
        icono: Icons.medical_services_outlined,
        titulo: 'Nueva consulta atendida',
        descripcion: 'Dr. Carlos Mendoza',
        fecha: 'Hoy, 10:20',
        color: verde,
      ),
      _Actividad(
        icono: Icons.event_outlined,
        titulo: 'Nueva cita programada',
        descripcion: 'María López',
        fecha: 'Hoy, 11:05',
        color: naranja,
      ),
      _Actividad(
        icono: Icons.person_add_outlined,
        titulo: 'Nuevo médico registrado',
        descripcion: 'Dra. Ana Torres',
        fecha: 'Ayer, 16:40',
        color: azulPrincipal,
      ),
    ];

    return _seccion(
      titulo: 'Actividad reciente',
      subtitulo: 'Últimos movimientos del sistema',
      icono: Icons.history_outlined,
      child: Column(
        children: actividades.map((actividad) {
          return Padding(
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
                  actividad.fecha,
                  style: const TextStyle(fontSize: 11, color: textoSecundario),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _seccion({
    required String titulo,
    required String subtitulo,
    required IconData icono,
    required Widget child,
  }) {
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
                child: Icon(icono, color: azulPrincipal, size: 22),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      titulo,
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w800,
                        color: textoPrincipal,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      subtitulo,
                      style: const TextStyle(
                        fontSize: 12,
                        color: textoSecundario,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 22),
          child,
        ],
      ),
    );
  }

  void _exportarReporte() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'El reporte de "$_periodo" estará disponible cuando conectemos la base de datos.',
        ),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}

class _DatoGrafico {
  final String dia;
  final int valor;

  _DatoGrafico(this.dia, this.valor);
}

class _Especialidad {
  final String nombre;
  final int consultas;
  final double porcentaje;

  _Especialidad({
    required this.nombre,
    required this.consultas,
    required this.porcentaje,
  });
}

class _Actividad {
  final IconData icono;
  final String titulo;
  final String descripcion;
  final String fecha;
  final Color color;

  _Actividad({
    required this.icono,
    required this.titulo,
    required this.descripcion,
    required this.fecha,
    required this.color,
  });
}
