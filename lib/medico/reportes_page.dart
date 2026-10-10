import 'package:flutter/material.dart';

import 'home_medico_page.dart';

class ReportesPage extends StatefulWidget {
  const ReportesPage({super.key});

  @override
  State<ReportesPage> createState() => _ReportesPageState();
}

class _ReportesPageState extends State<ReportesPage> {
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

  static const Color _morado =
      Color(0xFF5E35B1);

  static const Color _moradoClaro =
      Color(0xFFEDE7F6);

  // ============================================================
  // ESTADO
  // ============================================================

  String _periodo = 'Este mes';

  // ============================================================
  // DATOS TEMPORALES
  // ============================================================

  final List<_DatoDia> _consultasPorDia = const [
    _DatoDia('Lun', 8),
    _DatoDia('Mar', 12),
    _DatoDia('Mié', 10),
    _DatoDia('Jue', 15),
    _DatoDia('Vie', 11),
    _DatoDia('Sáb', 6),
    _DatoDia('Dom', 3),
  ];

  final List<_MotivoConsulta> _motivos = const [
    _MotivoConsulta(
      nombre: 'Consulta general',
      cantidad: 24,
    ),
    _MotivoConsulta(
      nombre: 'Control médico',
      cantidad: 18,
    ),
    _MotivoConsulta(
      nombre: 'Seguimiento',
      cantidad: 12,
    ),
    _MotivoConsulta(
      nombre: 'Evaluación médica',
      cantidad: 9,
    ),
  ];

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
          'Reportes médicos',
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
                      _buildFiltroPeriodo(),
                      const SizedBox(height: 20),
                      _buildIndicadores(
                        esMovil,
                      ),
                      const SizedBox(height: 24),
                      _buildGraficos(
                        esMovil,
                      ),
                      const SizedBox(height: 20),
                      _buildMotivosConsulta(),
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
    final botonExportar =
        OutlinedButton.icon(
      onPressed: _exportarReporte,
      icon: const Icon(
        Icons.download_outlined,
        size: 19,
      ),
      label: const Text(
        'Exportar reporte',
      ),
      style:
          OutlinedButton.styleFrom(
        foregroundColor:
            _azulPrincipal,
        side: const BorderSide(
          color: _azulPrincipal,
        ),
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
          'Reportes médicos',
          style: TextStyle(
            fontSize: 28,
            fontWeight:
                FontWeight.bold,
            color:
                _textoPrincipal,
          ),
        ),
        const SizedBox(height: 7),
        const Text(
          'Consulta indicadores y estadísticas de la atención médica.',
          style: TextStyle(
            fontSize: 15,
            color:
                _textoSecundario,
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
          botonExportar,
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
        botonExportar,
      ],
    );
  }

  // ============================================================
  // FILTRO DE PERÍODO
  // ============================================================

  Widget _buildFiltroPeriodo() {
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
      child: Row(
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
              Icons.date_range_outlined,
              color:
                  _azulPrincipal,
            ),
          ),
          const SizedBox(width: 12),
          const Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Text(
                  'Período del reporte',
                  style: TextStyle(
                    fontSize: 13,
                    color:
                        _textoSecundario,
                  ),
                ),
                SizedBox(height: 3),
                Text(
                  'Selecciona el período que deseas analizar.',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight:
                        FontWeight.w500,
                    color:
                        _textoPrincipal,
                  ),
                ),
              ],
            ),
          ),
          DropdownButtonHideUnderline(
            child:
                DropdownButton<String>(
              value: _periodo,
              borderRadius:
                  BorderRadius.circular(
                10,
              ),
              items: const [
                DropdownMenuItem(
                  value: 'Hoy',
                  child: Text('Hoy'),
                ),
                DropdownMenuItem(
                  value: 'Esta semana',
                  child:
                      Text('Esta semana'),
                ),
                DropdownMenuItem(
                  value: 'Este mes',
                  child:
                      Text('Este mes'),
                ),
              ],
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    _periodo = value;
                  });
                }
              },
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
        icono:
            Icons.people_outline,
        titulo:
            'Pacientes registrados',
        valor: '42',
        descripcion:
            'Pacientes',
        color:
            _azulPrincipal,
        fondo:
            _azulClaro,
      ),
      _buildIndicador(
        icono:
            Icons.medical_services_outlined,
        titulo:
            'Consultas realizadas',
        valor: '78',
        descripcion:
            'Atenciones',
        color:
            _morado,
        fondo:
            _moradoClaro,
      ),
      _buildIndicador(
        icono:
            Icons.event_available_outlined,
        titulo:
            'Citas programadas',
        valor: '35',
        descripcion:
            'Citas',
        color:
            _verde,
        fondo:
            _verdeClaro,
      ),
      _buildIndicador(
        icono:
            Icons.pending_actions_outlined,
        titulo:
            'Citas pendientes',
        valor: '8',
        descripcion:
            'Pendientes',
        color:
            _naranja,
        fondo:
            _naranjaClaro,
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
          const SizedBox(height: 10),
          tarjetas[3],
        ],
      );
    }

    return GridView.count(
      crossAxisCount: 4,
      crossAxisSpacing: 14,
      childAspectRatio: 2.15,
      shrinkWrap: true,
      physics:
          const NeverScrollableScrollPhysics(),
      children: tarjetas,
    );
  }

  Widget _buildIndicador({
    required IconData icono,
    required String titulo,
    required String valor,
    required String descripcion,
    required Color color,
    required Color fondo,
  }) {
    return Container(
      height: 96,
      padding:
          const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _blanco,
        borderRadius:
            BorderRadius.circular(14),
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
              color: fondo,
              borderRadius:
                  BorderRadius.circular(11),
            ),
            child: Icon(
              icono,
              color: color,
              size: 24,
            ),
          ),
          const SizedBox(width: 13),
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
                  style:
                      const TextStyle(
                    fontSize: 12,
                    color:
                        _textoSecundario,
                  ),
                ),
                const SizedBox(height: 3),
                Row(
                  crossAxisAlignment:
                      CrossAxisAlignment.end,
                  children: [
                    Text(
                      valor,
                      style:
                          const TextStyle(
                        fontSize: 23,
                        fontWeight:
                            FontWeight.bold,
                        color:
                            _textoPrincipal,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Padding(
                      padding:
                          const EdgeInsets.only(
                        bottom: 3,
                      ),
                      child: Text(
                        descripcion,
                        style:
                            const TextStyle(
                          fontSize: 11,
                          color:
                              _textoSecundario,
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
  // GRÁFICOS
  // ============================================================

  Widget _buildGraficos(
    bool esMovil,
  ) {
    final graficoConsultas =
        _buildGraficoConsultas();

    final graficoEstados =
        _buildGraficoEstados();

    if (esMovil) {
      return Column(
        children: [
          graficoConsultas,
          const SizedBox(height: 20),
          graficoEstados,
        ],
      );
    }

    return Row(
      crossAxisAlignment:
          CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 3,
          child: graficoConsultas,
        ),
        const SizedBox(width: 20),
        Expanded(
          flex: 2,
          child: graficoEstados,
        ),
      ],
    );
  }

  // ============================================================
  // GRÁFICO DE CONSULTAS
  // ============================================================

  Widget _buildGraficoConsultas() {
    final maximo = _consultasPorDia
        .map((dato) => dato.cantidad)
        .reduce(
          (a, b) => a > b ? a : b,
        );

    return Container(
      padding:
          const EdgeInsets.all(20),
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
          const Text(
            'Consultas realizadas',
            style: TextStyle(
              fontSize: 17,
              fontWeight:
                  FontWeight.w600,
              color:
                  _textoPrincipal,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            'Atenciones registradas durante $_periodo.',
            style: const TextStyle(
              fontSize: 13,
              color:
                  _textoSecundario,
            ),
          ),
          const SizedBox(height: 24),
          SizedBox(
            height: 230,
            child: Row(
              crossAxisAlignment:
                  CrossAxisAlignment.end,
              children:
                  _consultasPorDia.map(
                (dato) {
                  final double altura =
                      160 *
                          dato.cantidad /
                          maximo;

                  return Expanded(
                    child: Padding(
                      padding:
                          const EdgeInsets
                              .symmetric(
                        horizontal: 5,
                      ),
                      child: Column(
                        mainAxisAlignment:
                            MainAxisAlignment
                                .end,
                        children: [
                          Text(
                            '${dato.cantidad}',
                            style:
                                const TextStyle(
                              fontSize: 12,
                              fontWeight:
                                  FontWeight.w600,
                              color:
                                  _textoPrincipal,
                            ),
                          ),
                          const SizedBox(
                            height: 7,
                          ),
                          AnimatedContainer(
                            duration:
                                const Duration(
                              milliseconds: 350,
                            ),
                            height:
                                altura,
                            decoration:
                                BoxDecoration(
                              color:
                                  _azulPrincipal,
                              borderRadius:
                                  BorderRadius
                                      .circular(
                                7,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 9,
                          ),
                          Text(
                            dato.dia,
                            style:
                                const TextStyle(
                              fontSize: 12,
                              color:
                                  _textoSecundario,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ).toList(),
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // ESTADOS DE CITAS
  // ============================================================

  Widget _buildGraficoEstados() {
    return Container(
      padding:
          const EdgeInsets.all(20),
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
          const Text(
            'Estado de las citas',
            style: TextStyle(
              fontSize: 17,
              fontWeight:
                  FontWeight.w600,
              color:
                  _textoPrincipal,
            ),
          ),
          const SizedBox(height: 5),
          const Text(
            'Distribución de las citas programadas.',
            style: TextStyle(
              fontSize: 13,
              color:
                  _textoSecundario,
            ),
          ),
          const SizedBox(height: 24),
          _buildBarraEstado(
            titulo: 'Confirmadas',
            cantidad: 22,
            total: 35,
            color: _verde,
            fondo: _verdeClaro,
          ),
          const SizedBox(height: 18),
          _buildBarraEstado(
            titulo: 'Pendientes',
            cantidad: 8,
            total: 35,
            color: _naranja,
            fondo: _naranjaClaro,
          ),
          const SizedBox(height: 18),
          _buildBarraEstado(
            titulo: 'Canceladas',
            cantidad: 5,
            total: 35,
            color: Colors.red.shade700,
            fondo: Colors.red.shade50,
          ),
        ],
      ),
    );
  }

  Widget _buildBarraEstado({
    required String titulo,
    required int cantidad,
    required int total,
    required Color color,
    required Color fondo,
  }) {
    final porcentaje =
        cantidad / total;

    return Column(
      crossAxisAlignment:
          CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                titulo,
                style:
                    const TextStyle(
                  fontSize: 13,
                  fontWeight:
                      FontWeight.w500,
                  color:
                      _textoPrincipal,
                ),
              ),
            ),
            Text(
              '$cantidad',
              style:
                  const TextStyle(
                fontSize: 13,
                fontWeight:
                    FontWeight.w600,
                color:
                    _textoPrincipal,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        ClipRRect(
          borderRadius:
              BorderRadius.circular(
            10,
          ),
          child: Container(
            height: 9,
            color: fondo,
            child: FractionallySizedBox(
              alignment:
                  Alignment.centerLeft,
              widthFactor:
                  porcentaje,
              child: Container(
                decoration:
                    BoxDecoration(
                  color: color,
                  borderRadius:
                      BorderRadius.circular(
                    10,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  // ============================================================
  // MOTIVOS DE CONSULTA
  // ============================================================

  Widget _buildMotivosConsulta() {
    return Container(
      padding:
          const EdgeInsets.all(20),
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
                  color: _moradoClaro,
                  borderRadius:
                      BorderRadius.circular(
                    10,
                  ),
                ),
                child: const Icon(
                  Icons
                      .medical_information_outlined,
                  color: _morado,
                ),
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Motivos de consulta',
                      style:
                          TextStyle(
                        fontSize: 17,
                        fontWeight:
                            FontWeight.w600,
                        color:
                            _textoPrincipal,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Principales motivos registrados en las consultas.',
                      style:
                          TextStyle(
                        fontSize: 13,
                        color:
                            _textoSecundario,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          ..._motivos.map(
            (motivo) {
              return Padding(
                padding:
                    const EdgeInsets.only(
                  bottom: 14,
                ),
                child:
                    _buildMotivo(
                  motivo,
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildMotivo(
    _MotivoConsulta motivo,
  ) {
    const int maximo = 24;

    final porcentaje =
        motivo.cantidad /
            maximo;

    return Column(
      crossAxisAlignment:
          CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                motivo.nombre,
                style:
                    const TextStyle(
                  fontSize: 14,
                  fontWeight:
                      FontWeight.w500,
                  color:
                      _textoPrincipal,
                ),
              ),
            ),
            Text(
              '${motivo.cantidad} consultas',
              style:
                  const TextStyle(
                fontSize: 12,
                color:
                    _textoSecundario,
              ),
            ),
          ],
        ),
        const SizedBox(height: 7),
        ClipRRect(
          borderRadius:
              BorderRadius.circular(
            8,
          ),
          child: Container(
            height: 8,
            color: _azulClaro,
            child: FractionallySizedBox(
              alignment:
                  Alignment.centerLeft,
              widthFactor:
                  porcentaje,
              child: Container(
                color:
                    _azulPrincipal,
              ),
            ),
          ),
        ),
      ],
    );
  }

  // ============================================================
  // EXPORTAR
  // ============================================================

  void _exportarReporte() {
    ScaffoldMessenger.of(context)
        .showSnackBar(
      const SnackBar(
        behavior:
            SnackBarBehavior.floating,
        content: Text(
          'La exportación del reporte estará disponible al conectar la base de datos.',
        ),
      ),
    );
  }
}

// ============================================================
// MODELOS TEMPORALES
// ============================================================

class _DatoDia {
  final String dia;
  final int cantidad;

  const _DatoDia(
    this.dia,
    this.cantidad,
  );
}

class _MotivoConsulta {
  final String nombre;
  final int cantidad;

  const _MotivoConsulta({
    required this.nombre,
    required this.cantidad,
  });
}