import 'package:flutter/material.dart';

import 'home_medico_page.dart';

class AgendaPage extends StatefulWidget {
  const AgendaPage({super.key});

  @override
  State<AgendaPage> createState() => _AgendaPageState();
}

class _AgendaPageState extends State<AgendaPage> {
  // ============================================================
  // PALETA PROFESIONAL
  // ============================================================

  static const Color _azulPrincipal =
      Color(0xFF1565C0);

  static const Color _azulClaro =
      Color(0xFFE3F2FD);

  static const Color _fondo =
      Color(0xFFF5F7FA);

  static const Color _blanco =
      Color(0xFFFFFFFF);

  static const Color _textoPrincipal =
      Color(0xFF172033);

  static const Color _textoSecundario =
      Color(0xFF607D8B);

  static const Color _borde =
      Color(0xFFE1E7EF);

  static const Color _verde =
      Color(0xFF2E7D32);

  static const Color _verdeClaro =
      Color(0xFFE8F5E9);

  static const Color _naranja =
      Color(0xFFEF6C00);

  static const Color _naranjaClaro =
      Color(0xFFFFF3E0);

  static const Color _rojo =
      Color(0xFFC62828);

  static const Color _rojoClaro =
      Color(0xFFFFEBEE);

  // ============================================================
  // CONTROLADORES
  // ============================================================

  final TextEditingController _buscarController =
      TextEditingController();

  DateTime _fechaSeleccionada = DateTime.now();

  String _filtroEstado = 'Todas';

  // ============================================================
  // DATOS TEMPORALES
  // ============================================================

  final List<_Cita> _citas = [
    _Cita(
      paciente: 'Juan Pérez',
      hora: '09:00',
      motivo: 'Consulta general',
      estado: 'Confirmada',
    ),
    _Cita(
      paciente: 'María López',
      hora: '10:00',
      motivo: 'Control médico',
      estado: 'Pendiente',
    ),
    _Cita(
      paciente: 'Pedro García',
      hora: '11:30',
      motivo: 'Seguimiento',
      estado: 'Confirmada',
    ),
    _Cita(
      paciente: 'Ana Torres',
      hora: '14:00',
      motivo: 'Evaluación médica',
      estado: 'Pendiente',
    ),
    _Cita(
      paciente: 'Carlos Mendoza',
      hora: '15:30',
      motivo: 'Control de tratamiento',
      estado: 'Cancelada',
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

  // ============================================================
  // CITAS FILTRADAS
  // ============================================================

  List<_Cita> get _citasFiltradas {
    final texto =
        _buscarController.text.trim().toLowerCase();

    return _citas.where((cita) {
      final coincideBusqueda =
          texto.isEmpty ||
          cita.paciente
              .toLowerCase()
              .contains(texto) ||
          cita.motivo
              .toLowerCase()
              .contains(texto);

      final coincideEstado =
          _filtroEstado == 'Todas' ||
          cita.estado == _filtroEstado;

      return coincideBusqueda &&
          coincideEstado;
    }).toList();
  }

  // ============================================================
  // BUILD
  // ============================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _fondo,
      appBar: AppBar(
        backgroundColor: _blanco,
        foregroundColor: _textoPrincipal,
        elevation: 0,
        surfaceTintColor: _blanco,
        title: const Text(
          'Agenda médica',
          style: TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          IconButton(
            tooltip: 'Inicio',
            icon: const Icon(
              Icons.home_outlined,
            ),
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (_) =>
                      const HomeMedicoPage(),
                ),
                (route) => false,
              );
            },
          ),
          const SizedBox(width: 6),
        ],
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (
            context,
            constraints,
          ) {
            final bool esMovil =
                constraints.maxWidth < 700;

            return SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                horizontal:
                    esMovil ? 16 : 28,
                vertical:
                    esMovil ? 20 : 28,
              ),
              child: Center(
                child: ConstrainedBox(
                  constraints:
                      const BoxConstraints(
                    maxWidth: 1180,
                  ),
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.stretch,
                    children: [
                      _buildEncabezado(
                        esMovil,
                      ),
                      const SizedBox(height: 24),
                      _buildResumen(
                        esMovil,
                      ),
                      const SizedBox(height: 24),
                      _buildCalendario(
                        esMovil,
                      ),
                      const SizedBox(height: 20),
                      _buildFiltros(),
                      const SizedBox(height: 20),
                      _buildListaCitas(),
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

  Widget _buildEncabezado(
    bool esMovil,
  ) {
    final boton = ElevatedButton.icon(
      onPressed: _mostrarNuevaCita,
      icon: const Icon(
        Icons.add,
        size: 19,
      ),
      label: const Text(
        'Nueva cita',
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: _azulPrincipal,
        foregroundColor: Colors.white,
        elevation: 0,
        padding:
            const EdgeInsets.symmetric(
          horizontal: 17,
          vertical: 13,
        ),
        shape:
            RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(9),
        ),
      ),
    );

    final texto = Column(
      crossAxisAlignment:
          CrossAxisAlignment.start,
      children: [
        const Text(
          'Agenda médica',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: _textoPrincipal,
          ),
        ),
        const SizedBox(height: 7),
        const Text(
          'Organiza y consulta las citas programadas de tus pacientes.',
          style: TextStyle(
            fontSize: 15,
            color: _textoSecundario,
          ),
        ),
      ],
    );

    if (esMovil) {
      return Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          texto,
          const SizedBox(height: 15),
          boton,
        ],
      );
    }

    return Row(
      crossAxisAlignment:
          CrossAxisAlignment.start,
      children: [
        Expanded(
          child: texto,
        ),
        const SizedBox(width: 20),
        boton,
      ],
    );
  }

  // ============================================================
  // RESUMEN
  // ============================================================

  Widget _buildResumen(
    bool esMovil,
  ) {
    final tarjetas = [
      _buildIndicador(
        icono:
            Icons.calendar_today_outlined,
        titulo: 'Citas del día',
        valor: '${_citas.length}',
        color: _azulPrincipal,
        fondo: _azulClaro,
      ),
      _buildIndicador(
        icono:
            Icons.check_circle_outline,
        titulo: 'Confirmadas',
        valor:
            '${_citas.where((c) => c.estado == 'Confirmada').length}',
        color: _verde,
        fondo: _verdeClaro,
      ),
      _buildIndicador(
        icono:
            Icons.schedule_outlined,
        titulo: 'Pendientes',
        valor:
            '${_citas.where((c) => c.estado == 'Pendiente').length}',
        color: _naranja,
        fondo: _naranjaClaro,
      ),
    ];

    if (esMovil) {
      return Column(
        children: [
          tarjetas[0],
          const SizedBox(height: 10),
          tarjetas[1],
          const SizedBox(height: 10),
          tarjetas[2],
        ],
      );
    }

    return Row(
      children: [
        Expanded(
          child: tarjetas[0],
        ),
        const SizedBox(width: 14),
        Expanded(
          child: tarjetas[1],
        ),
        const SizedBox(width: 14),
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
    required Color fondo,
  }) {
    return Container(
      height: 88,
      padding:
          const EdgeInsets.symmetric(
        horizontal: 17,
        vertical: 13,
      ),
      decoration: BoxDecoration(
        color: _blanco,
        borderRadius:
            BorderRadius.circular(13),
        border: Border.all(
          color: _borde,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 46,
            height: 46,
            decoration: BoxDecoration(
              color: fondo,
              borderRadius:
                  BorderRadius.circular(11),
            ),
            child: Icon(
              icono,
              color: color,
              size: 23,
            ),
          ),
          const SizedBox(width: 13),
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
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
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
  // CALENDARIO
  // ============================================================

  Widget _buildCalendario(
    bool esMovil,
  ) {
    return Container(
      padding:
          const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: _blanco,
        borderRadius:
            BorderRadius.circular(14),
        border: Border.all(
          color: _borde,
        ),
      ),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: _azulClaro,
                  borderRadius:
                      BorderRadius.circular(10),
                ),
                child: const Icon(
                  Icons.event_outlined,
                  color: _azulPrincipal,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Fecha seleccionada',
                      style: TextStyle(
                        fontSize: 13,
                        color: _textoSecundario,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      _formatearFecha(
                        _fechaSeleccionada,
                      ),
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight:
                            FontWeight.w600,
                        color:
                            _textoPrincipal,
                      ),
                    ),
                  ],
                ),
              ),
              OutlinedButton.icon(
                onPressed:
                    _seleccionarFecha,
                icon: const Icon(
                  Icons.date_range_outlined,
                  size: 18,
                ),
                label: const Text(
                  'Cambiar fecha',
                ),
                style:
                    OutlinedButton.styleFrom(
                  foregroundColor:
                      _azulPrincipal,
                  side:
                      const BorderSide(
                    color:
                        _azulPrincipal,
                  ),
                  shape:
                      RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(
                      9,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          _buildDiasSemana(
            esMovil,
          ),
        ],
      ),
    );
  }

  Widget _buildDiasSemana(
    bool esMovil,
  ) {
    final hoy = DateTime.now();

    final dias = List.generate(
      7,
      (index) => DateTime(
        hoy.year,
        hoy.month,
        hoy.day,
      ).add(
        Duration(days: index),
      ),
    );

    return SizedBox(
      height: 76,
      child: ListView.separated(
        scrollDirection:
            Axis.horizontal,
        itemCount: dias.length,
        separatorBuilder:
            (_, _) =>
                const SizedBox(width: 8),
        itemBuilder:
            (context, index) {
          final dia = dias[index];

          final seleccionado =
              dia.year ==
                      _fechaSeleccionada.year &&
                  dia.month ==
                      _fechaSeleccionada.month &&
                  dia.day ==
                      _fechaSeleccionada.day;

          return InkWell(
            borderRadius:
                BorderRadius.circular(11),
            onTap: () {
              setState(() {
                _fechaSeleccionada =
                    dia;
              });
            },
            child: Container(
              width:
                  esMovil ? 70 : 82,
              padding:
                  const EdgeInsets.symmetric(
                vertical: 9,
              ),
              decoration:
                  BoxDecoration(
                color: seleccionado
                    ? _azulPrincipal
                    : _azulMuyClaroSeguro,
                borderRadius:
                    BorderRadius.circular(11),
                border: Border.all(
                  color: seleccionado
                      ? _azulPrincipal
                      : _borde,
                ),
              ),
              child: Column(
                mainAxisAlignment:
                    MainAxisAlignment.center,
                children: [
                  Text(
                    _nombreDia(
                      dia.weekday,
                    ),
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight:
                          FontWeight.w600,
                      color: seleccionado
                          ? Colors.white
                          : _textoSecundario,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${dia.day}',
                    style: TextStyle(
                      fontSize: 19,
                      fontWeight:
                          FontWeight.bold,
                      color: seleccionado
                          ? Colors.white
                          : _textoPrincipal,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  // ============================================================
  // FILTROS
  // ============================================================

  Widget _buildFiltros() {
    return Container(
      padding:
          const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: _blanco,
        borderRadius:
            BorderRadius.circular(14),
        border: Border.all(
          color: _borde,
        ),
      ),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(
                Icons.filter_list_outlined,
                color: _textoSecundario,
                size: 21,
              ),
              SizedBox(width: 8),
              Text(
                'Buscar y filtrar',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight:
                      FontWeight.w600,
                  color:
                      _textoPrincipal,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          LayoutBuilder(
            builder: (
              context,
              constraints,
            ) {
              if (constraints.maxWidth <
                  650) {
                return Column(
                  children: [
                    _buildBuscador(),
                    const SizedBox(
                      height: 12,
                    ),
                    _buildEstados(),
                  ],
                );
              }

              return Row(
                children: [
                  Expanded(
                    child:
                        _buildBuscador(),
                  ),
                  const SizedBox(
                    width: 14,
                  ),
                  _buildEstados(),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildBuscador() {
    return TextField(
      controller:
          _buscarController,
      decoration:
          InputDecoration(
        hintText:
            'Buscar paciente o motivo',
        prefixIcon:
            const Icon(
          Icons.search,
          size: 21,
        ),
        suffixIcon:
            _buscarController
                    .text
                    .isNotEmpty
                ? IconButton(
                    tooltip:
                        'Limpiar',
                    icon:
                        const Icon(
                      Icons.clear,
                      size: 20,
                    ),
                    onPressed: () {
                      _buscarController
                          .clear();
                    },
                  )
                : null,
        filled: true,
        fillColor:
            const Color(
          0xFFF8FAFC,
        ),
        contentPadding:
            const EdgeInsets
                .symmetric(
          vertical: 14,
        ),
        border:
            OutlineInputBorder(
          borderRadius:
              BorderRadius.circular(
            9,
          ),
          borderSide:
              BorderSide(
            color:
                Colors.grey.shade200,
          ),
        ),
        enabledBorder:
            OutlineInputBorder(
          borderRadius:
              BorderRadius.circular(
            9,
          ),
          borderSide:
              BorderSide(
            color:
                Colors.grey.shade200,
          ),
        ),
        focusedBorder:
            OutlineInputBorder(
          borderRadius:
              BorderRadius.circular(
            9,
          ),
          borderSide:
              const BorderSide(
            color:
                _azulPrincipal,
          ),
        ),
      ),
    );
  }

  Widget _buildEstados() {
    return Wrap(
      spacing: 7,
      runSpacing: 7,
      children: [
        _buildEstadoFiltro(
          'Todas',
          _azulPrincipal,
          _azulClaro,
        ),
        _buildEstadoFiltro(
          'Confirmada',
          _verde,
          _verdeClaro,
        ),
        _buildEstadoFiltro(
          'Pendiente',
          _naranja,
          _naranjaClaro,
        ),
        _buildEstadoFiltro(
          'Cancelada',
          _rojo,
          _rojoClaro,
        ),
      ],
    );
  }

  Widget _buildEstadoFiltro(
    String texto,
    Color color,
    Color fondo,
  ) {
    final seleccionado =
        _filtroEstado == texto;

    return ChoiceChip(
      label: Text(texto),
      selected: seleccionado,
      onSelected: (_) {
        setState(() {
          _filtroEstado = texto;
        });
      },
      selectedColor: fondo,
      backgroundColor: Colors.white,
      side: BorderSide(
        color: seleccionado
            ? color.withValues(
                alpha: 0.35,
              )
            : _borde,
      ),
      labelStyle: TextStyle(
        fontSize: 12,
        fontWeight: seleccionado
            ? FontWeight.w600
            : FontWeight.normal,
        color: seleccionado
            ? color
            : _textoSecundario,
      ),
      avatar: seleccionado
          ? Icon(
              Icons.check,
              size: 15,
              color: color,
            )
          : null,
    );
  }

  // ============================================================
  // LISTA DE CITAS
  // ============================================================

  Widget _buildListaCitas() {
    final citas =
        _citasFiltradas;

    return Container(
      decoration: BoxDecoration(
        color: _blanco,
        borderRadius:
            BorderRadius.circular(14),
        border: Border.all(
          color: _borde,
        ),
      ),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding:
                const EdgeInsets.all(18),
            child: Row(
              children: [
                const Expanded(
                  child: Text(
                    'Citas programadas',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight:
                          FontWeight.w600,
                      color:
                          _textoPrincipal,
                    ),
                  ),
                ),
                Text(
                  '${citas.length} citas',
                  style:
                      const TextStyle(
                    fontSize: 13,
                    color:
                        _textoSecundario,
                  ),
                ),
              ],
            ),
          ),
          Divider(
            height: 1,
            color: _borde,
          ),
          if (citas.isEmpty)
            _buildEstadoVacio()
          else
            ListView.separated(
              shrinkWrap: true,
              physics:
                  const NeverScrollableScrollPhysics(),
              itemCount:
                  citas.length,
              separatorBuilder:
                  (_, _) => Divider(
                height: 1,
                color: _borde,
              ),
              itemBuilder:
                  (context, index) {
                return _buildCita(
                  citas[index],
                );
              },
            ),
        ],
      ),
    );
  }

  Widget _buildCita(
    _Cita cita,
  ) {
    final estado =
        _obtenerColoresEstado(
      cita.estado,
    );

    return InkWell(
      onTap: () {
        _mostrarDetalleCita(cita);
      },
      child: Padding(
        padding:
            const EdgeInsets.all(17),
        child: Row(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: _azulClaro,
                borderRadius:
                    BorderRadius.circular(
                  12,
                ),
              ),
              child: const Icon(
                Icons.person_outline,
                color:
                    _azulPrincipal,
                size: 25,
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  Text(
                    cita.paciente,
                    style:
                        const TextStyle(
                      fontSize: 15,
                      fontWeight:
                          FontWeight.w600,
                      color:
                          _textoPrincipal,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    cita.motivo,
                    style:
                        const TextStyle(
                      fontSize: 13,
                      color:
                          _textoSecundario,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment:
                  CrossAxisAlignment.end,
              children: [
                Text(
                  cita.hora,
                  style:
                      const TextStyle(
                    fontSize: 15,
                    fontWeight:
                        FontWeight.w600,
                    color:
                        _textoPrincipal,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Container(
                  padding:
                      const EdgeInsets
                          .symmetric(
                    horizontal: 9,
                    vertical: 4,
                  ),
                  decoration:
                      BoxDecoration(
                    color:
                        estado.$2,
                    borderRadius:
                        BorderRadius.circular(
                      20,
                    ),
                  ),
                  child: Text(
                    cita.estado,
                    style:
                        TextStyle(
                      fontSize: 11,
                      fontWeight:
                          FontWeight.w600,
                      color:
                          estado.$1,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(width: 8),
            const Icon(
              Icons.chevron_right,
              color:
                  _textoSecundario,
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // ESTADO VACÍO
  // ============================================================

  Widget _buildEstadoVacio() {
    return Padding(
      padding:
          const EdgeInsets.all(45),
      child: Column(
        children: [
          Container(
            width: 76,
            height: 76,
            decoration: BoxDecoration(
              color: _azulClaro,
              borderRadius:
                  BorderRadius.circular(
                18,
              ),
            ),
            child: const Icon(
              Icons.event_busy_outlined,
              size: 36,
              color:
                  _azulPrincipal,
            ),
          ),
          const SizedBox(height: 17),
          const Text(
            'No se encontraron citas',
            style: TextStyle(
              fontSize: 18,
              fontWeight:
                  FontWeight.w600,
              color:
                  _textoPrincipal,
            ),
          ),
          const SizedBox(height: 7),
          const Text(
            'Prueba con otro paciente, motivo o estado.',
            textAlign:
                TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color:
                  _textoSecundario,
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // SELECCIONAR FECHA
  // ============================================================

  Future<void> _seleccionarFecha() async {
    final fecha =
        await showDatePicker(
      context: context,
      initialDate:
          _fechaSeleccionada,
      firstDate:
          DateTime(2020),
      lastDate:
          DateTime(2100),
      locale:
          const Locale('es'),
      builder:
          (context, child) {
        return Theme(
          data: Theme.of(context)
              .copyWith(
            colorScheme:
                const ColorScheme.light(
              primary:
                  _azulPrincipal,
            ),
          ),
          child: child!,
        );
      },
    );

    if (fecha != null) {
      setState(() {
        _fechaSeleccionada =
            fecha;
      });
    }
  }

  // ============================================================
  // NUEVA CITA
  // ============================================================

  void _mostrarNuevaCita() {
    final pacienteController =
        TextEditingController();

    final motivoController =
        TextEditingController();

    String estado =
        'Pendiente';

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (
            context,
            setDialogState,
          ) {
            return AlertDialog(
              title: const Text(
                'Nueva cita',
                style: TextStyle(
                  fontWeight:
                      FontWeight.w600,
                ),
              ),
              shape:
                  RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(
                  14,
                ),
              ),
              content: SizedBox(
                width: 430,
                child:
                    SingleChildScrollView(
                  child: Column(
                    mainAxisSize:
                        MainAxisSize.min,
                    children: [
                      TextField(
                        controller:
                            pacienteController,
                        decoration:
                            const InputDecoration(
                          labelText:
                              'Paciente',
                          prefixIcon:
                              Icon(
                            Icons
                                .person_outline,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 14,
                      ),
                      TextField(
                        controller:
                            motivoController,
                        decoration:
                            const InputDecoration(
                          labelText:
                              'Motivo de la cita',
                          prefixIcon:
                              Icon(
                            Icons
                                .medical_services_outlined,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 14,
                      ),
                      DropdownButtonFormField<
                          String>(
                        initialValue:
                            estado,
                        decoration:
                            const InputDecoration(
                          labelText:
                              'Estado',
                          prefixIcon:
                              Icon(
                            Icons
                                .flag_outlined,
                          ),
                        ),
                        items: const [
                          DropdownMenuItem(
                            value:
                                'Pendiente',
                            child: Text(
                              'Pendiente',
                            ),
                          ),
                          DropdownMenuItem(
                            value:
                                'Confirmada',
                            child: Text(
                              'Confirmada',
                            ),
                          ),
                          DropdownMenuItem(
                            value:
                                'Cancelada',
                            child: Text(
                              'Cancelada',
                            ),
                          ),
                        ],
                        onChanged:
                            (value) {
                          if (value !=
                              null) {
                            setDialogState(
                              () {
                                estado =
                                    value;
                              },
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(
                      context,
                    );
                  },
                  child:
                      const Text(
                    'Cancelar',
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (pacienteController
                            .text
                            .trim()
                            .isEmpty ||
                        motivoController
                            .text
                            .trim()
                            .isEmpty) {
                      return;
                    }

                    setState(() {
                      _citas.add(
                        _Cita(
                          paciente:
                              pacienteController
                                  .text
                                  .trim(),
                          hora: '16:30',
                          motivo:
                              motivoController
                                  .text
                                  .trim(),
                          estado:
                              estado,
                        ),
                      );
                    });

                    Navigator.pop(
                      context,
                    );

                    ScaffoldMessenger
                        .of(context)
                        .showSnackBar(
                      const SnackBar(
                        content: Text(
                          'Cita registrada correctamente.',
                        ),
                      ),
                    );
                  },
                  style:
                      ElevatedButton.styleFrom(
                    backgroundColor:
                        _azulPrincipal,
                    foregroundColor:
                        Colors.white,
                  ),
                  child:
                      const Text(
                    'Registrar',
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  // ============================================================
  // DETALLE DE CITA
  // ============================================================

  void _mostrarDetalleCita(
    _Cita cita,
  ) {
    final estado =
        _obtenerColoresEstado(
      cita.estado,
    );

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(
              14,
            ),
          ),
          title: const Text(
            'Detalle de la cita',
            style: TextStyle(
              fontWeight:
                  FontWeight.w600,
            ),
          ),
          content: Column(
            mainAxisSize:
                MainAxisSize.min,
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [
              _detalle(
                'Paciente',
                cita.paciente,
              ),
              _detalle(
                'Hora',
                cita.hora,
              ),
              _detalle(
                'Motivo',
                cita.motivo,
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  const Text(
                    'Estado: ',
                    style:
                        TextStyle(
                      color:
                          _textoSecundario,
                    ),
                  ),
                  Container(
                    padding:
                        const EdgeInsets
                            .symmetric(
                      horizontal: 9,
                      vertical: 4,
                    ),
                    decoration:
                        BoxDecoration(
                      color:
                          estado.$2,
                      borderRadius:
                          BorderRadius
                              .circular(
                        20,
                      ),
                    ),
                    child: Text(
                      cita.estado,
                      style:
                          TextStyle(
                        fontSize: 12,
                        fontWeight:
                            FontWeight.w600,
                        color:
                            estado.$1,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(
                  context,
                );
              },
              child:
                  const Text(
                'Cerrar',
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _detalle(
    String titulo,
    String valor,
  ) {
    return Padding(
      padding:
          const EdgeInsets.only(
        bottom: 10,
      ),
      child: Row(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 75,
            child: Text(
              '$titulo:',
              style:
                  const TextStyle(
                fontSize: 13,
                color:
                    _textoSecundario,
              ),
            ),
          ),
          Expanded(
            child: Text(
              valor,
              style:
                  const TextStyle(
                fontSize: 14,
                fontWeight:
                    FontWeight.w600,
                color:
                    _textoPrincipal,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // UTILIDADES
  // ============================================================

  (Color, Color) _obtenerColoresEstado(
    String estado,
  ) {
    switch (estado) {
      case 'Confirmada':
        return (
          _verde,
          _verdeClaro,
        );

      case 'Cancelada':
        return (
          _rojo,
          _rojoClaro,
        );

      default:
        return (
          _naranja,
          _naranjaClaro,
        );
    }
  }

  String _formatearFecha(
    DateTime fecha,
  ) {
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

  String _nombreDia(
    int dia,
  ) {
    const dias = [
      'LUN',
      'MAR',
      'MIÉ',
      'JUE',
      'VIE',
      'SÁB',
      'DOM',
    ];

    return dias[dia - 1];
  }
}

// ============================================================
// MODELO TEMPORAL DE CITA
// ============================================================

class _Cita {
  final String paciente;
  final String hora;
  final String motivo;
  final String estado;

  const _Cita({
    required this.paciente,
    required this.hora,
    required this.motivo,
    required this.estado,
  });
}

// ============================================================
// COLOR AUXILIAR
// ============================================================

const Color _azulMuyClaroSeguro =
    Color(0xFFF3F8FD);