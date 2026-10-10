import 'package:flutter/material.dart';

class CitasPage extends StatefulWidget {
  const CitasPage({super.key});

  @override
  State<CitasPage> createState() => _CitasPageState();
}

class _CitasPageState extends State<CitasPage> {
  static const Color azulPrincipal = Color(0xFF1565C0);
  static const Color azulClaro = Color(0xFFE3F2FD);
  static const Color fondo = Color(0xFFF5F7FA);
  static const Color textoPrincipal = Color(0xFF172033);
  static const Color textoSecundario = Color(0xFF607D8B);
  static const Color verde = Color(0xFF2E7D32);
  static const Color naranja = Color(0xFFEF6C00);
  static const Color rojo = Color(0xFFC62828);
  static const Color morado = Color(0xFF6A1B9A);

  final TextEditingController _buscarController = TextEditingController();

  DateTime _fechaSeleccionada = DateTime.now();

  String _estadoSeleccionado = 'Todos';

  final List<_CitaAdmin> _citas = [
    _CitaAdmin(
      id: '1',
      paciente: 'Juan Pérez',
      medico: 'Carlos Mendoza',
      especialidad: 'Medicina General',
      fecha: DateTime(2026, 10, 8),
      hora: '09:00',
      motivo: 'Consulta general',
      estado: 'Confirmada',
      observaciones: 'Primera consulta del paciente.',
    ),
    _CitaAdmin(
      id: '2',
      paciente: 'María López',
      medico: 'Ana Torres',
      especialidad: 'Pediatría',
      fecha: DateTime(2026, 10, 8),
      hora: '10:00',
      motivo: 'Control médico',
      estado: 'Pendiente',
      observaciones: 'Control de seguimiento.',
    ),
    _CitaAdmin(
      id: '3',
      paciente: 'Pedro García',
      medico: 'Carlos Mendoza',
      especialidad: 'Medicina General',
      fecha: DateTime(2026, 10, 8),
      hora: '11:30',
      motivo: 'Seguimiento',
      estado: 'Confirmada',
      observaciones: 'Seguimiento de tratamiento.',
    ),
    _CitaAdmin(
      id: '4',
      paciente: 'Ana Torres',
      medico: 'Luis Ramírez',
      especialidad: 'Cardiología',
      fecha: DateTime(2026, 10, 8),
      hora: '14:00',
      motivo: 'Evaluación cardiológica',
      estado: 'Pendiente',
      observaciones: 'Evaluación de rutina.',
    ),
    _CitaAdmin(
      id: '5',
      paciente: 'Carlos Ramírez',
      medico: 'Patricia Gómez',
      especialidad: 'Ginecología',
      fecha: DateTime(2026, 10, 8),
      hora: '15:30',
      motivo: 'Control',
      estado: 'Cancelada',
      observaciones: 'Cita cancelada por el paciente.',
    ),
    _CitaAdmin(
      id: '6',
      paciente: 'Juan Pérez',
      medico: 'Carlos Mendoza',
      especialidad: 'Medicina General',
      fecha: DateTime(2026, 10, 20),
      hora: '10:00',
      motivo: 'Control médico',
      estado: 'Confirmada',
      observaciones: 'Control posterior al tratamiento.',
    ),
    _CitaAdmin(
      id: '7',
      paciente: 'María López',
      medico: 'Ana Torres',
      especialidad: 'Pediatría',
      fecha: DateTime(2026, 10, 21),
      hora: '09:30',
      motivo: 'Control',
      estado: 'Pendiente',
      observaciones: 'Control programado.',
    ),
  ];

  @override
  void initState() {
    super.initState();

    _buscarController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _buscarController.dispose();
    super.dispose();
  }

  List<_CitaAdmin> get _citasFiltradas {
    final texto = _buscarController.text.trim().toLowerCase();

    final resultado = _citas.where((cita) {
      final coincideBusqueda =
          texto.isEmpty ||
          cita.paciente.toLowerCase().contains(texto) ||
          cita.medico.toLowerCase().contains(texto) ||
          cita.motivo.toLowerCase().contains(texto);

      final coincideEstado =
          _estadoSeleccionado == 'Todos' || cita.estado == _estadoSeleccionado;

      return coincideBusqueda && coincideEstado;
    }).toList();

    resultado.sort((a, b) {
      final fechaA = DateTime(
        a.fecha.year,
        a.fecha.month,
        a.fecha.day,
        int.parse(a.hora.split(':')[0]),
        int.parse(a.hora.split(':')[1]),
      );

      final fechaB = DateTime(
        b.fecha.year,
        b.fecha.month,
        b.fecha.day,
        int.parse(b.hora.split(':')[0]),
        int.parse(b.hora.split(':')[1]),
      );

      return fechaA.compareTo(fechaB);
    });

    return resultado;
  }

  List<_CitaAdmin> get _citasDelDia {
    final resultado = _citas.where((cita) {
      return _mismaFecha(cita.fecha, _fechaSeleccionada);
    }).toList();

    resultado.sort((a, b) => a.hora.compareTo(b.hora));

    return resultado;
  }

  int get _totalCitas => _citas.length;

  int get _confirmadas =>
      _citas.where((cita) => cita.estado == 'Confirmada').length;

  int get _pendientes =>
      _citas.where((cita) => cita.estado == 'Pendiente').length;

  int get _atendidas =>
      _citas.where((cita) => cita.estado == 'Atendida').length;

  bool _mismaFecha(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

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
          'Citas',
          style: TextStyle(color: textoPrincipal, fontWeight: FontWeight.w700),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: azulPrincipal,
        foregroundColor: Colors.white,
        onPressed: _mostrarNuevaCita,
        icon: const Icon(Icons.add),
        label: const Text('Nueva cita'),
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final ancho = constraints.maxWidth;
            final padding = ancho >= 900 ? 32.0 : 16.0;

            return SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(padding, 20, padding, 100),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _encabezado(),
                  const SizedBox(height: 20),
                  _resumen(ancho),
                  const SizedBox(height: 24),
                  _selectorFecha(),
                  const SizedBox(height: 20),
                  _busqueda(),
                  const SizedBox(height: 12),
                  _filtros(),
                  const SizedBox(height: 24),
                  _seccionCitasDelDia(),
                  const SizedBox(height: 28),
                  _seccionTodasLasCitas(ancho),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _encabezado() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Gestión de citas',
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.w800,
            color: textoPrincipal,
          ),
        ),
        SizedBox(height: 6),
        Text(
          'Administra la programación y estado de las citas de la clínica.',
          style: TextStyle(fontSize: 14, color: textoSecundario),
        ),
      ],
    );
  }

  Widget _resumen(double ancho) {
    final datos = [
      _ResumenCita(
        titulo: 'Total',
        valor: '$_totalCitas',
        icono: Icons.event_note_outlined,
        color: azulPrincipal,
      ),
      _ResumenCita(
        titulo: 'Confirmadas',
        valor: '$_confirmadas',
        icono: Icons.check_circle_outline,
        color: verde,
      ),
      _ResumenCita(
        titulo: 'Pendientes',
        valor: '$_pendientes',
        icono: Icons.schedule_outlined,
        color: naranja,
      ),
      _ResumenCita(
        titulo: 'Atendidas',
        valor: '$_atendidas',
        icono: Icons.medical_services_outlined,
        color: morado,
      ),
    ];

    if (ancho >= 800) {
      return Row(
        children: datos.map((dato) {
          return Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 12),
              child: _tarjetaResumen(dato),
            ),
          );
        }).toList(),
      );
    }

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: datos.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 1.8,
      ),
      itemBuilder: (context, index) {
        return _tarjetaResumen(datos[index]);
      },
    );
  }

  Widget _tarjetaResumen(_ResumenCita dato) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE7ECF2)),
      ),
      child: Row(
        children: [
          Container(
            width: 46,
            height: 46,
            decoration: BoxDecoration(
              color: dato.color.withValues(alpha: 0.10),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(dato.icono, color: dato.color),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  dato.titulo,
                  style: const TextStyle(fontSize: 12, color: textoSecundario),
                ),
                const SizedBox(height: 4),
                Text(
                  dato.valor,
                  style: const TextStyle(
                    fontSize: 21,
                    fontWeight: FontWeight.w800,
                    color: textoPrincipal,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _selectorFecha() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFE7ECF2)),
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
                  borderRadius: BorderRadius.circular(11),
                ),
                child: const Icon(
                  Icons.calendar_month_outlined,
                  color: azulPrincipal,
                ),
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Fecha seleccionada',
                      style: TextStyle(fontSize: 12, color: textoSecundario),
                    ),
                    SizedBox(height: 3),
                    Text(
                      'Consulta las citas por día',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: textoPrincipal,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: _seleccionarFecha,
                icon: const Icon(
                  Icons.edit_calendar_outlined,
                  color: azulPrincipal,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              _botonFecha(DateTime.now(), 'Hoy'),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  _formatearFechaCompleta(_fechaSeleccionada),
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: textoPrincipal,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _botonFecha(DateTime fecha, String texto) {
    final seleccionado = _mismaFecha(_fechaSeleccionada, fecha);

    return InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap: () {
        setState(() {
          _fechaSeleccionada = fecha;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
        decoration: BoxDecoration(
          color: seleccionado ? azulPrincipal : azulClaro,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          texto,
          style: TextStyle(
            color: seleccionado ? Colors.white : azulPrincipal,
            fontWeight: FontWeight.w700,
            fontSize: 13,
          ),
        ),
      ),
    );
  }

  Future<void> _seleccionarFecha() async {
    final fecha = await showDatePicker(
      context: context,
      initialDate: _fechaSeleccionada,
      firstDate: DateTime(2025),
      lastDate: DateTime(2030),
    );

    if (fecha == null) return;

    setState(() {
      _fechaSeleccionada = fecha;
    });
  }

  Widget _busqueda() {
    return TextField(
      controller: _buscarController,
      decoration: InputDecoration(
        hintText: 'Buscar por paciente, médico o motivo',
        prefixIcon: const Icon(Icons.search, color: textoSecundario),
        suffixIcon: _buscarController.text.isNotEmpty
            ? IconButton(
                onPressed: () {
                  _buscarController.clear();
                },
                icon: const Icon(Icons.clear),
              )
            : null,
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(vertical: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: Color(0xFFE7ECF2)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: azulPrincipal),
        ),
      ),
    );
  }

  Widget _filtros() {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xFFE7ECF2)),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: _estadoSeleccionado,
              icon: const Icon(Icons.keyboard_arrow_down),
              items:
                  const [
                    'Todos',
                    'Pendiente',
                    'Confirmada',
                    'Atendida',
                    'Cancelada',
                  ].map((estado) {
                    return DropdownMenuItem(value: estado, child: Text(estado));
                  }).toList(),
              onChanged: (valor) {
                if (valor == null) return;

                setState(() {
                  _estadoSeleccionado = valor;
                });
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _seccionCitasDelDia() {
    final citas = _citasDelDia;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Citas del día',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w800,
                color: textoPrincipal,
              ),
            ),
            Text(
              '${citas.length} citas',
              style: const TextStyle(fontSize: 13, color: textoSecundario),
            ),
          ],
        ),
        const SizedBox(height: 12),
        if (citas.isEmpty)
          _estadoVacioDia()
        else
          Column(
            children: citas.map((cita) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: _tarjetaCita(cita),
              );
            }).toList(),
          ),
      ],
    );
  }

  Widget _estadoVacioDia() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFE7ECF2)),
      ),
      child: const Column(
        children: [
          Icon(
            Icons.event_available_outlined,
            size: 50,
            color: Color(0xFF90A4AE),
          ),
          SizedBox(height: 12),
          Text(
            'No hay citas para esta fecha',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: textoPrincipal,
            ),
          ),
          SizedBox(height: 6),
          Text(
            'Puedes registrar una nueva cita utilizando el botón inferior.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 13, color: textoSecundario),
          ),
        ],
      ),
    );
  }

  Widget _seccionTodasLasCitas(double ancho) {
    final citas = _citasFiltradas;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Todas las citas',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w800,
                color: textoPrincipal,
              ),
            ),
            Text(
              '${citas.length} resultados',
              style: const TextStyle(fontSize: 13, color: textoSecundario),
            ),
          ],
        ),
        const SizedBox(height: 12),
        if (citas.isEmpty)
          _estadoVacioBusqueda()
        else if (ancho >= 900)
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: citas.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 2.35,
            ),
            itemBuilder: (context, index) {
              return _tarjetaCita(citas[index]);
            },
          )
        else
          Column(
            children: citas.map((cita) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: _tarjetaCita(cita),
              );
            }).toList(),
          ),
      ],
    );
  }

  Widget _tarjetaCita(_CitaAdmin cita) {
    return InkWell(
      borderRadius: BorderRadius.circular(18),
      onTap: () => _mostrarDetalleCita(cita),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: const Color(0xFFE7ECF2)),
        ),
        child: Row(
          children: [
            Container(
              width: 62,
              padding: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                color: azulClaro,
                borderRadius: BorderRadius.circular(13),
              ),
              child: Column(
                children: [
                  const Icon(Icons.access_time, size: 18, color: azulPrincipal),
                  const SizedBox(height: 4),
                  Text(
                    cita.hora,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                      color: azulPrincipal,
                    ),
                  ),
                ],
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
                          cita.paciente,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                            color: textoPrincipal,
                          ),
                        ),
                      ),
                      _estadoBadge(cita.estado),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    cita.motivo,
                    style: const TextStyle(
                      fontSize: 13,
                      color: azulPrincipal,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      const Icon(
                        Icons.medical_services_outlined,
                        size: 15,
                        color: textoSecundario,
                      ),
                      const SizedBox(width: 5),
                      Expanded(
                        child: Text(
                          'Dr. ${cita.medico}',
                          style: const TextStyle(
                            fontSize: 12,
                            color: textoSecundario,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(
                        Icons.calendar_today_outlined,
                        size: 14,
                        color: textoSecundario,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        _formatearFecha(cita.fecha),
                        style: const TextStyle(
                          fontSize: 12,
                          color: textoSecundario,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            const Icon(Icons.chevron_right, color: textoSecundario),
          ],
        ),
      ),
    );
  }

  Widget _estadoBadge(String estado) {
    Color fondoBadge;
    Color colorTexto;

    switch (estado) {
      case 'Confirmada':
        fondoBadge = const Color(0xFFE8F5E9);
        colorTexto = verde;
        break;
      case 'Pendiente':
        fondoBadge = const Color(0xFFFFF3E0);
        colorTexto = naranja;
        break;
      case 'Atendida':
        fondoBadge = const Color(0xFFF3E5F5);
        colorTexto = morado;
        break;
      case 'Cancelada':
        fondoBadge = const Color(0xFFFFEBEE);
        colorTexto = rojo;
        break;
      default:
        fondoBadge = const Color(0xFFECEFF1);
        colorTexto = textoSecundario;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
      decoration: BoxDecoration(
        color: fondoBadge,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        estado,
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w700,
          color: colorTexto,
        ),
      ),
    );
  }

  Widget _estadoVacioBusqueda() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 45),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFE7ECF2)),
      ),
      child: const Column(
        children: [
          Icon(Icons.search_off_outlined, size: 50, color: Color(0xFF90A4AE)),
          SizedBox(height: 12),
          Text(
            'No se encontraron citas',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: textoPrincipal,
            ),
          ),
          SizedBox(height: 6),
          Text(
            'Prueba con otro paciente, médico o estado.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 13, color: textoSecundario),
          ),
        ],
      ),
    );
  }

  void _mostrarDetalleCita(_CitaAdmin cita) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 28),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 42,
                  height: 4,
                  decoration: BoxDecoration(
                    color: const Color(0xFFD9E0E7),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Container(
                      width: 54,
                      height: 54,
                      decoration: BoxDecoration(
                        color: azulClaro,
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: const Icon(
                        Icons.event_note_outlined,
                        color: azulPrincipal,
                        size: 28,
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Detalle de la cita',
                            style: TextStyle(
                              fontSize: 12,
                              color: textoSecundario,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            cita.paciente,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w800,
                              color: textoPrincipal,
                            ),
                          ),
                        ],
                      ),
                    ),
                    _estadoBadge(cita.estado),
                  ],
                ),
                const SizedBox(height: 22),
                _filaDetalle(
                  Icons.calendar_today_outlined,
                  'Fecha',
                  _formatearFechaCompleta(cita.fecha),
                ),
                _filaDetalle(Icons.access_time_outlined, 'Hora', cita.hora),
                _filaDetalle(
                  Icons.medical_services_outlined,
                  'Médico',
                  'Dr. ${cita.medico}',
                ),
                _filaDetalle(
                  Icons.local_hospital_outlined,
                  'Especialidad',
                  cita.especialidad,
                ),
                _filaDetalle(Icons.description_outlined, 'Motivo', cita.motivo),
                _filaDetalle(
                  Icons.notes_outlined,
                  'Observaciones',
                  cita.observaciones.isEmpty
                      ? 'Sin observaciones'
                      : cita.observaciones,
                ),
                const SizedBox(height: 18),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () {
                          Navigator.pop(context);
                          _mostrarEditarCita(cita);
                        },
                        icon: const Icon(Icons.edit_calendar_outlined),
                        label: const Text('Editar'),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: azulPrincipal,
                          padding: const EdgeInsets.symmetric(vertical: 13),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () {
                          Navigator.pop(context);
                          _mostrarCambiarEstado(cita);
                        },
                        icon: const Icon(Icons.sync_alt),
                        label: const Text('Estado'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: azulPrincipal,
                          foregroundColor: Colors.white,
                          elevation: 0,
                          padding: const EdgeInsets.symmetric(vertical: 13),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _filaDetalle(IconData icono, String titulo, String valor) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 13),
      child: Row(
        children: [
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: azulClaro,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icono, size: 19, color: azulPrincipal),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  titulo,
                  style: const TextStyle(fontSize: 11, color: textoSecundario),
                ),
                const SizedBox(height: 2),
                Text(
                  valor,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: textoPrincipal,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _mostrarCambiarEstado(_CitaAdmin cita) {
    String estado = cita.estado;

    showDialog(
      context: context,
      builder: (dialogContext) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: const Text(
                'Cambiar estado',
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                  color: textoPrincipal,
                ),
              ),
              content: DropdownButtonFormField<String>(
                initialValue: estado,
                decoration: InputDecoration(
                  labelText: 'Estado de la cita',
                  prefixIcon: const Icon(Icons.sync_alt),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                items:
                    const [
                      'Pendiente',
                      'Confirmada',
                      'Atendida',
                      'Cancelada',
                    ].map((item) {
                      return DropdownMenuItem(value: item, child: Text(item));
                    }).toList(),
                onChanged: (valor) {
                  if (valor == null) return;

                  setDialogState(() {
                    estado = valor;
                  });
                },
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(dialogContext);
                  },
                  child: const Text('Cancelar'),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      cita.estado = estado;
                    });

                    Navigator.pop(dialogContext);

                    ScaffoldMessenger.of(this.context).showSnackBar(
                      const SnackBar(
                        content: Text('Estado de la cita actualizado.'),
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: azulPrincipal,
                    foregroundColor: Colors.white,
                    elevation: 0,
                  ),
                  child: const Text('Guardar'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _mostrarNuevaCita() {
    final pacienteController = TextEditingController();
    final medicoController = TextEditingController();
    final motivoController = TextEditingController();
    final observacionesController = TextEditingController();

    DateTime fecha = _fechaSeleccionada;

    TimeOfDay hora = const TimeOfDay(hour: 9, minute: 0);

    String especialidad = 'Medicina General';
    String estado = 'Pendiente';

    showDialog(
      context: context,
      builder: (dialogContext) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: const Text(
                'Nueva cita',
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                  color: textoPrincipal,
                ),
              ),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _campoDialogo(
                      controller: pacienteController,
                      label: 'Paciente',
                      icono: Icons.person_outline,
                    ),
                    const SizedBox(height: 12),
                    _campoDialogo(
                      controller: medicoController,
                      label: 'Médico',
                      icono: Icons.medical_services_outlined,
                    ),
                    const SizedBox(height: 12),
                    DropdownButtonFormField<String>(
                      initialValue: especialidad,
                      decoration: InputDecoration(
                        labelText: 'Especialidad',
                        prefixIcon: const Icon(Icons.local_hospital_outlined),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      items:
                          const [
                            'Medicina General',
                            'Pediatría',
                            'Cardiología',
                            'Ginecología',
                            'Dermatología',
                            'Traumatología',
                            'Neurología',
                          ].map((item) {
                            return DropdownMenuItem(
                              value: item,
                              child: Text(item),
                            );
                          }).toList(),
                      onChanged: (valor) {
                        if (valor == null) return;

                        setDialogState(() {
                          especialidad = valor;
                        });
                      },
                    ),
                    const SizedBox(height: 12),
                    _selectorFechaDialogo(context, fecha, (nuevaFecha) {
                      setDialogState(() {
                        fecha = nuevaFecha;
                      });
                    }),
                    const SizedBox(height: 12),
                    _selectorHoraDialogo(context, hora, (nuevaHora) {
                      setDialogState(() {
                        hora = nuevaHora;
                      });
                    }),
                    const SizedBox(height: 12),
                    _campoDialogo(
                      controller: motivoController,
                      label: 'Motivo',
                      icono: Icons.description_outlined,
                    ),
                    const SizedBox(height: 12),
                    DropdownButtonFormField<String>(
                      initialValue: estado,
                      decoration: InputDecoration(
                        labelText: 'Estado',
                        prefixIcon: const Icon(Icons.flag_outlined),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      items:
                          const [
                            'Pendiente',
                            'Confirmada',
                            'Atendida',
                            'Cancelada',
                          ].map((item) {
                            return DropdownMenuItem(
                              value: item,
                              child: Text(item),
                            );
                          }).toList(),
                      onChanged: (valor) {
                        if (valor == null) return;

                        setDialogState(() {
                          estado = valor;
                        });
                      },
                    ),
                    const SizedBox(height: 12),
                    _campoDialogo(
                      controller: observacionesController,
                      label: 'Observaciones',
                      icono: Icons.notes_outlined,
                      maxLines: 3,
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(dialogContext);
                  },
                  child: const Text('Cancelar'),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (pacienteController.text.trim().isEmpty ||
                        medicoController.text.trim().isEmpty ||
                        motivoController.text.trim().isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Completa paciente, médico y motivo.'),
                        ),
                      );
                      return;
                    }

                    final nuevaCita = _CitaAdmin(
                      id: DateTime.now().millisecondsSinceEpoch.toString(),
                      paciente: pacienteController.text.trim(),
                      medico: medicoController.text.trim(),
                      especialidad: especialidad,
                      fecha: fecha,
                      hora: _formatearHora(hora),
                      motivo: motivoController.text.trim(),
                      estado: estado,
                      observaciones: observacionesController.text.trim(),
                    );

                    setState(() {
                      _citas.add(nuevaCita);
                      _fechaSeleccionada = fecha;
                    });

                    Navigator.pop(dialogContext);

                    ScaffoldMessenger.of(this.context).showSnackBar(
                      const SnackBar(
                        content: Text('Cita registrada correctamente.'),
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: azulPrincipal,
                    foregroundColor: Colors.white,
                    elevation: 0,
                  ),
                  child: const Text('Registrar'),
                ),
              ],
            );
          },
        );
      },
    ).whenComplete(() {
      pacienteController.dispose();
      medicoController.dispose();
      motivoController.dispose();
      observacionesController.dispose();
    });
  }

  void _mostrarEditarCita(_CitaAdmin cita) {
    final pacienteController = TextEditingController(text: cita.paciente);

    final medicoController = TextEditingController(text: cita.medico);

    final motivoController = TextEditingController(text: cita.motivo);

    final observacionesController = TextEditingController(
      text: cita.observaciones,
    );

    DateTime fecha = cita.fecha;

    TimeOfDay hora = _horaDesdeTexto(cita.hora);

    String especialidad = cita.especialidad;
    String estado = cita.estado;

    showDialog(
      context: context,
      builder: (dialogContext) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: const Text(
                'Editar cita',
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                  color: textoPrincipal,
                ),
              ),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _campoDialogo(
                      controller: pacienteController,
                      label: 'Paciente',
                      icono: Icons.person_outline,
                    ),
                    const SizedBox(height: 12),
                    _campoDialogo(
                      controller: medicoController,
                      label: 'Médico',
                      icono: Icons.medical_services_outlined,
                    ),
                    const SizedBox(height: 12),
                    DropdownButtonFormField<String>(
                      initialValue: especialidad,
                      decoration: InputDecoration(
                        labelText: 'Especialidad',
                        prefixIcon: const Icon(Icons.local_hospital_outlined),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      items:
                          const [
                            'Medicina General',
                            'Pediatría',
                            'Cardiología',
                            'Ginecología',
                            'Dermatología',
                            'Traumatología',
                            'Neurología',
                          ].map((item) {
                            return DropdownMenuItem(
                              value: item,
                              child: Text(item),
                            );
                          }).toList(),
                      onChanged: (valor) {
                        if (valor == null) return;

                        setDialogState(() {
                          especialidad = valor;
                        });
                      },
                    ),
                    const SizedBox(height: 12),
                    _selectorFechaDialogo(context, fecha, (nuevaFecha) {
                      setDialogState(() {
                        fecha = nuevaFecha;
                      });
                    }),
                    const SizedBox(height: 12),
                    _selectorHoraDialogo(context, hora, (nuevaHora) {
                      setDialogState(() {
                        hora = nuevaHora;
                      });
                    }),
                    const SizedBox(height: 12),
                    _campoDialogo(
                      controller: motivoController,
                      label: 'Motivo',
                      icono: Icons.description_outlined,
                    ),
                    const SizedBox(height: 12),
                    DropdownButtonFormField<String>(
                      initialValue: estado,
                      decoration: InputDecoration(
                        labelText: 'Estado',
                        prefixIcon: const Icon(Icons.flag_outlined),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      items:
                          const [
                            'Pendiente',
                            'Confirmada',
                            'Atendida',
                            'Cancelada',
                          ].map((item) {
                            return DropdownMenuItem(
                              value: item,
                              child: Text(item),
                            );
                          }).toList(),
                      onChanged: (valor) {
                        if (valor == null) return;

                        setDialogState(() {
                          estado = valor;
                        });
                      },
                    ),
                    const SizedBox(height: 12),
                    _campoDialogo(
                      controller: observacionesController,
                      label: 'Observaciones',
                      icono: Icons.notes_outlined,
                      maxLines: 3,
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(dialogContext);
                  },
                  child: const Text('Cancelar'),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (pacienteController.text.trim().isEmpty ||
                        medicoController.text.trim().isEmpty ||
                        motivoController.text.trim().isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Completa paciente, médico y motivo.'),
                        ),
                      );
                      return;
                    }

                    setState(() {
                      cita.paciente = pacienteController.text.trim();

                      cita.medico = medicoController.text.trim();

                      cita.especialidad = especialidad;

                      cita.fecha = fecha;

                      cita.hora = _formatearHora(hora);

                      cita.motivo = motivoController.text.trim();

                      cita.estado = estado;

                      cita.observaciones = observacionesController.text.trim();
                    });

                    Navigator.pop(dialogContext);

                    ScaffoldMessenger.of(this.context).showSnackBar(
                      const SnackBar(
                        content: Text('Cita actualizada correctamente.'),
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: azulPrincipal,
                    foregroundColor: Colors.white,
                    elevation: 0,
                  ),
                  child: const Text('Guardar cambios'),
                ),
              ],
            );
          },
        );
      },
    ).whenComplete(() {
      pacienteController.dispose();
      medicoController.dispose();
      motivoController.dispose();
      observacionesController.dispose();
    });
  }

  Widget _selectorFechaDialogo(
    BuildContext context,
    DateTime fecha,
    ValueChanged<DateTime> onChanged,
  ) {
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: () async {
        final seleccionada = await showDatePicker(
          context: context,
          initialDate: fecha,
          firstDate: DateTime(2025),
          lastDate: DateTime(2030),
        );

        if (seleccionada != null) {
          onChanged(seleccionada);
        }
      },
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: 'Fecha',
          prefixIcon: const Icon(Icons.calendar_today_outlined),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        ),
        child: Text(_formatearFecha(fecha)),
      ),
    );
  }

  Widget _selectorHoraDialogo(
    BuildContext context,
    TimeOfDay hora,
    ValueChanged<TimeOfDay> onChanged,
  ) {
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: () async {
        final seleccionada = await showTimePicker(
          context: context,
          initialTime: hora,
        );

        if (seleccionada != null) {
          onChanged(seleccionada);
        }
      },
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: 'Hora',
          prefixIcon: const Icon(Icons.access_time_outlined),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        ),
        child: Text(_formatearHora(hora)),
      ),
    );
  }

  Widget _campoDialogo({
    required TextEditingController controller,
    required String label,
    required IconData icono,
    TextInputType? teclado,
    int maxLines = 1,
  }) {
    return TextField(
      controller: controller,
      keyboardType: teclado,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icono),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  String _formatearFecha(DateTime fecha) {
    final dia = fecha.day.toString().padLeft(2, '0');
    final mes = fecha.month.toString().padLeft(2, '0');

    return '$dia/$mes/${fecha.year}';
  }

  String _formatearFechaCompleta(DateTime fecha) {
    const meses = [
      'enero',
      'febrero',
      'marzo',
      'abril',
      'mayo',
      'junio',
      'julio',
      'agosto',
      'septiembre',
      'octubre',
      'noviembre',
      'diciembre',
    ];

    return '${fecha.day} de ${meses[fecha.month - 1]} de ${fecha.year}';
  }

  String _formatearHora(TimeOfDay hora) {
    final horas = hora.hour.toString().padLeft(2, '0');
    final minutos = hora.minute.toString().padLeft(2, '0');

    return '$horas:$minutos';
  }

  TimeOfDay _horaDesdeTexto(String texto) {
    final partes = texto.split(':');

    if (partes.length != 2) {
      return const TimeOfDay(hour: 9, minute: 0);
    }

    return TimeOfDay(
      hour: int.tryParse(partes[0]) ?? 9,
      minute: int.tryParse(partes[1]) ?? 0,
    );
  }
}

class _CitaAdmin {
  final String id;
  String paciente;
  String medico;
  String especialidad;
  DateTime fecha;
  String hora;
  String motivo;
  String estado;
  String observaciones;

  _CitaAdmin({
    required this.id,
    required this.paciente,
    required this.medico,
    required this.especialidad,
    required this.fecha,
    required this.hora,
    required this.motivo,
    required this.estado,
    required this.observaciones,
  });
}

class _ResumenCita {
  final String titulo;
  final String valor;
  final IconData icono;
  final Color color;

  _ResumenCita({
    required this.titulo,
    required this.valor,
    required this.icono,
    required this.color,
  });
}
