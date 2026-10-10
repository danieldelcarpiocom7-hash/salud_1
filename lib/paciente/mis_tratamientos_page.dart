import 'package:flutter/material.dart';

class MisTratamientosPage extends StatefulWidget {
  const MisTratamientosPage({super.key});

  @override
  State<MisTratamientosPage> createState() => _MisTratamientosPageState();
}

class _MisTratamientosPageState extends State<MisTratamientosPage> {
  final Color _azulPrincipal = const Color(0xFF1565C0);
  final Color _azulClaro = const Color(0xFFE3F2FD);
  final Color _fondo = const Color(0xFFF6F8FA);
  final Color _textoPrincipal = const Color(0xFF172033);
  final Color _textoSecundario = const Color(0xFF607D8B);
  final Color _verde = const Color(0xFF2E7D32);

  // Fecha que el paciente está consultando.
  DateTime _fechaSeleccionada = DateTime(2026, 10, 8);

  // Medicamentos prescritos por el médico.
  final List<_Medicamento> _medicamentos = [
    _Medicamento(
      nombre: 'Amoxicilina 500 mg',
      tipo: 'Antibiótico',
      dosis: '1 cápsula',
      frecuencia: 'Cada 8 horas',
      tiempoTratamiento: '7 días',
      fechaInicio: DateTime(2026, 10, 8),
      fechaFin: DateTime(2026, 10, 14),
      horarios: const ['08:00', '16:00', '00:00'],
      icono: Icons.medication_outlined,
      color: Color(0xFF1565C0),
      fondoIcono: Color(0xFFE3F2FD),
    ),
    _Medicamento(
      nombre: 'Paracetamol 500 mg',
      tipo: 'Analgésico',
      dosis: '1 tableta',
      frecuencia: 'Cada 8 horas',
      tiempoTratamiento: '5 días',
      fechaInicio: DateTime(2026, 10, 10),
      fechaFin: DateTime(2026, 10, 14),
      horarios: const ['09:00', '17:00', '01:00'],
      icono: Icons.medication_liquid_outlined,
      color: Color(0xFF00897B),
      fondoIcono: Color(0xFFE0F2F1),
    ),
    _Medicamento(
      nombre: 'Omeprazol 20 mg',
      tipo: 'Protector gástrico',
      dosis: '1 cápsula',
      frecuencia: 'Cada 24 horas',
      tiempoTratamiento: '13 días',
      fechaInicio: DateTime(2026, 10, 8),
      fechaFin: DateTime(2026, 10, 20),
      horarios: const ['07:00'],
      icono: Icons.local_pharmacy_outlined,
      color: Color(0xFF6A1B9A),
      fondoIcono: Color(0xFFF3E5F5),
    ),
  ];

  // Registro temporal de las dosis que el paciente ya marcó como tomadas.
  // Posteriormente esto vendrá de MariaDB.
  final Set<String> _dosisTomadas = {
    'Amoxicilina 500 mg-2026-10-08-08:00',
    'Omeprazol 20 mg-2026-10-08-07:00',
    'Amoxicilina 500 mg-2026-10-09-08:00',
    'Amoxicilina 500 mg-2026-10-09-16:00',
    'Omeprazol 20 mg-2026-10-09-07:00',
    'Amoxicilina 500 mg-2026-10-10-08:00',
    'Paracetamol 500 mg-2026-10-10-09:00',
  };

  @override
  Widget build(BuildContext context) {
    final medicamentosDelDia = _medicamentosParaFecha(_fechaSeleccionada);

    final totalDosis = _totalDosisDelDia(medicamentosDelDia);
    final dosisTomadas = _dosisTomadasDelDia(medicamentosDelDia);

    return Scaffold(
      backgroundColor: _fondo,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF172033)),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Mis medicamentos',
          style: TextStyle(
            color: Color(0xFF172033),
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 30),
          children: [
            _buildEncabezado(),

            const SizedBox(height: 20),

            _buildSelectorFecha(),

            const SizedBox(height: 20),

            _buildFechaSeleccionada(),

            const SizedBox(height: 16),

            _buildResumenDelDia(
              medicamentosDelDia.length,
              dosisTomadas,
              totalDosis,
            ),

            const SizedBox(height: 24),

            _buildTituloSeccion(
              'Medicamentos del día',
              medicamentosDelDia.isEmpty
                  ? 'No tienes medicamentos programados para esta fecha.'
                  : 'Estos son los medicamentos indicados para hoy.',
            ),

            const SizedBox(height: 12),

            if (medicamentosDelDia.isEmpty)
              _buildSinMedicamentos()
            else
              ...medicamentosDelDia.map(
                (medicamento) => Padding(
                  padding: const EdgeInsets.only(bottom: 14),
                  child: _buildMedicamentoDelDia(medicamento),
                ),
              ),

            const SizedBox(height: 10),

            _buildInformacionImportante(),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // ENCABEZADO
  // ============================================================

  Widget _buildEncabezado() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Control de tratamiento',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w800,
            color: _textoPrincipal,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          'Selecciona una fecha para consultar los medicamentos '
          'que debes tomar ese día.',
          style: TextStyle(fontSize: 14, color: _textoSecundario, height: 1.4),
        ),
      ],
    );
  }

  // ============================================================
  // SELECTOR DE FECHA
  // ============================================================

  Widget _buildSelectorFecha() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFE4E8EE)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: _azulClaro,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  Icons.calendar_month_outlined,
                  color: _azulPrincipal,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Seleccionar fecha',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                        color: _textoPrincipal,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      'Consulta qué debes tomar ese día.',
                      style: TextStyle(fontSize: 12, color: _textoSecundario),
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: _mostrarCalendario,
                tooltip: 'Elegir fecha',
                icon: Icon(Icons.date_range_outlined, color: _azulPrincipal),
              ),
            ],
          ),

          const SizedBox(height: 18),

          _buildCalendarioHorizontal(),
        ],
      ),
    );
  }

  Widget _buildCalendarioHorizontal() {
    final fechas = _generarFechasCalendario();

    return SizedBox(
      height: 76,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: fechas.length,
        separatorBuilder: (_, _) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final fecha = fechas[index];

          final seleccionada = _mismaFecha(fecha, _fechaSeleccionada);

          final tieneMedicamentos = _medicamentosParaFecha(fecha).isNotEmpty;

          return InkWell(
            borderRadius: BorderRadius.circular(14),
            onTap: () {
              setState(() {
                _fechaSeleccionada = fecha;
              });
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              width: 58,
              padding: const EdgeInsets.symmetric(vertical: 8),
              decoration: BoxDecoration(
                color: seleccionada ? _azulPrincipal : const Color(0xFFF6F8FA),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: seleccionada
                      ? _azulPrincipal
                      : const Color(0xFFE4E8EE),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    _diaSemana(fecha),
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: seleccionada ? Colors.white : _textoSecundario,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${fecha.day}',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w800,
                      color: seleccionada ? Colors.white : _textoPrincipal,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Container(
                    width: 5,
                    height: 5,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: tieneMedicamentos
                          ? (seleccionada ? Colors.white : _azulPrincipal)
                          : Colors.transparent,
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
  // FECHA SELECCIONADA
  // ============================================================

  Widget _buildFechaSeleccionada() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: _azulPrincipal,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Icon(
              Icons.event_available_outlined,
              color: Colors.white,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Fecha consultada',
                  style: TextStyle(color: Colors.white70, fontSize: 12),
                ),
                const SizedBox(height: 3),
                Text(
                  _formatearFecha(_fechaSeleccionada),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.w800,
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
  // RESUMEN DEL DÍA
  // ============================================================

  Widget _buildResumenDelDia(
    int cantidadMedicamentos,
    int dosisTomadas,
    int totalDosis,
  ) {
    final progreso = totalDosis == 0 ? 0.0 : dosisTomadas / totalDosis;

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFE4E8EE)),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: _buildDatoResumen(
                  Icons.medication_outlined,
                  '$cantidadMedicamentos',
                  'Medicamentos',
                  _azulPrincipal,
                ),
              ),
              Container(width: 1, height: 45, color: const Color(0xFFE4E8EE)),
              Expanded(
                child: _buildDatoResumen(
                  Icons.check_circle_outline,
                  '$dosisTomadas/$totalDosis',
                  'Dosis tomadas',
                  _verde,
                ),
              ),
            ],
          ),

          if (totalDosis > 0) ...[
            const SizedBox(height: 18),

            Row(
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: LinearProgressIndicator(
                      value: progreso,
                      minHeight: 8,
                      backgroundColor: const Color(0xFFECEFF3),
                      valueColor: AlwaysStoppedAnimation<Color>(_verde),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  '${(progreso * 100).round()}%',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w800,
                    color: _textoPrincipal,
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildDatoResumen(
    IconData icono,
    String valor,
    String titulo,
    Color color,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icono, color: color, size: 26),
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              valor,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w800,
                color: _textoPrincipal,
              ),
            ),
            Text(
              titulo,
              style: TextStyle(fontSize: 11, color: _textoSecundario),
            ),
          ],
        ),
      ],
    );
  }

  // ============================================================
  // TÍTULO
  // ============================================================

  Widget _buildTituloSeccion(String titulo, String subtitulo) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          titulo,
          style: TextStyle(
            fontSize: 19,
            fontWeight: FontWeight.w800,
            color: _textoPrincipal,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          subtitulo,
          style: TextStyle(fontSize: 13, color: _textoSecundario),
        ),
      ],
    );
  }

  // ============================================================
  // MEDICAMENTOS DEL DÍA
  // ============================================================

  Widget _buildMedicamentoDelDia(_Medicamento medicamento) {
    final diaTratamiento = _diaDelTratamiento(medicamento, _fechaSeleccionada);

    final dosisTomadas = medicamento.horarios
        .where(
          (hora) => _dosisEstaTomada(medicamento, _fechaSeleccionada, hora),
        )
        .length;

    final totalDosis = medicamento.horarios.length;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFE4E8EE)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(17),
        child: Column(
          children: [
            // Cabecera del medicamento
            Row(
              children: [
                Container(
                  width: 52,
                  height: 52,
                  decoration: BoxDecoration(
                    color: medicamento.fondoIcono,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Icon(
                    medicamento.icono,
                    color: medicamento.color,
                    size: 27,
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        medicamento.nombre,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                          color: _textoPrincipal,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        medicamento.tipo,
                        style: TextStyle(fontSize: 12, color: _textoSecundario),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 9,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: _azulClaro,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    'Día $diaTratamiento/${medicamento.diasTotales}',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w800,
                      color: _azulPrincipal,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Información de la prescripción
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFFF8FAFC),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: _buildDatoMedicamento('Dosis', medicamento.dosis),
                  ),
                  Expanded(
                    child: _buildDatoMedicamento(
                      'Frecuencia',
                      medicamento.frecuencia,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 12),

            Row(
              children: [
                Icon(
                  Icons.date_range_outlined,
                  size: 17,
                  color: _textoSecundario,
                ),
                const SizedBox(width: 7),
                Expanded(
                  child: Text(
                    '${_fechaCorta(medicamento.fechaInicio)} → '
                    '${_fechaCorta(medicamento.fechaFin)}',
                    style: TextStyle(
                      fontSize: 12,
                      color: _textoSecundario,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Text(
                  '$dosisTomadas/$totalDosis tomadas',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w800,
                    color: dosisTomadas == totalDosis
                        ? _verde
                        : _textoPrincipal,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Horarios
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Horarios de hoy',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w800,
                  color: _textoPrincipal,
                ),
              ),
            ),

            const SizedBox(height: 10),

            ...medicamento.horarios.map(
              (hora) => _buildDosis(medicamento, hora),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDatoMedicamento(String titulo, String valor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(titulo, style: TextStyle(fontSize: 11, color: _textoSecundario)),
        const SizedBox(height: 3),
        Text(
          valor,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w700,
            color: _textoPrincipal,
          ),
        ),
      ],
    );
  }

  // ============================================================
  // DOSIS INDIVIDUAL
  // ============================================================

  Widget _buildDosis(_Medicamento medicamento, String hora) {
    final tomada = _dosisEstaTomada(medicamento, _fechaSeleccionada, hora);

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: tomada
            ? _verde.withValues(alpha: 0.06)
            : const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(13),
        border: Border.all(
          color: tomada
              ? _verde.withValues(alpha: 0.20)
              : const Color(0xFFE8ECF1),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: tomada ? _verde.withValues(alpha: 0.10) : _azulClaro,
              borderRadius: BorderRadius.circular(11),
            ),
            child: Icon(
              tomada ? Icons.check_circle_outline : Icons.access_time_outlined,
              color: tomada ? _verde : _azulPrincipal,
              size: 22,
            ),
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  hora,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                    color: _textoPrincipal,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  medicamento.dosis,
                  style: TextStyle(fontSize: 11, color: _textoSecundario),
                ),
              ],
            ),
          ),

          if (tomada)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: _verde.withValues(alpha: 0.10),
                borderRadius: BorderRadius.circular(9),
              ),
              child: Text(
                'Tomada',
                style: TextStyle(
                  color: _verde,
                  fontSize: 12,
                  fontWeight: FontWeight.w800,
                ),
              ),
            )
          else
            ElevatedButton(
              onPressed: () => _registrarDosis(medicamento, hora),
              style: ElevatedButton.styleFrom(
                backgroundColor: _azulPrincipal,
                foregroundColor: Colors.white,
                elevation: 0,
                padding: const EdgeInsets.symmetric(
                  horizontal: 13,
                  vertical: 10,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(9),
                ),
              ),
              child: const Text(
                'Registrar',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700),
              ),
            ),
        ],
      ),
    );
  }

  // ============================================================
  // SIN MEDICAMENTOS
  // ============================================================

  Widget _buildSinMedicamentos() {
    return Container(
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFE4E8EE)),
      ),
      child: Column(
        children: [
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              color: const Color(0xFFF1F3F5),
              borderRadius: BorderRadius.circular(18),
            ),
            child: Icon(
              Icons.event_available_outlined,
              size: 32,
              color: _textoSecundario,
            ),
          ),
          const SizedBox(height: 14),
          Text(
            'Sin medicamentos programados',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w800,
              color: _textoPrincipal,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'No tienes medicamentos indicados para '
            'esta fecha.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 13,
              color: _textoSecundario,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // INFORMACIÓN
  // ============================================================

  Widget _buildInformacionImportante() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF8E1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFFFE082)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.info_outline, color: Color(0xFFF57C00)),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              'Los medicamentos, dosis, frecuencia y fechas '
              'son indicados por el médico. Esta pantalla '
              'solo permite consultar el tratamiento y '
              'registrar las dosis tomadas.',
              style: TextStyle(
                fontSize: 12,
                height: 1.5,
                color: _textoPrincipal,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // LÓGICA DE FECHAS
  // ============================================================

  List<_Medicamento> _medicamentosParaFecha(DateTime fecha) {
    return _medicamentos.where((medicamento) {
      return _fechaDentroDelTratamiento(
        fecha,
        medicamento.fechaInicio,
        medicamento.fechaFin,
      );
    }).toList();
  }

  bool _fechaDentroDelTratamiento(
    DateTime fecha,
    DateTime inicio,
    DateTime fin,
  ) {
    final fechaNormalizada = DateTime(fecha.year, fecha.month, fecha.day);

    final inicioNormalizado = DateTime(inicio.year, inicio.month, inicio.day);

    final finNormalizado = DateTime(fin.year, fin.month, fin.day);

    return !fechaNormalizada.isBefore(inicioNormalizado) &&
        !fechaNormalizada.isAfter(finNormalizado);
  }

  int _diaDelTratamiento(_Medicamento medicamento, DateTime fecha) {
    final inicio = DateTime(
      medicamento.fechaInicio.year,
      medicamento.fechaInicio.month,
      medicamento.fechaInicio.day,
    );

    final actual = DateTime(fecha.year, fecha.month, fecha.day);

    return actual.difference(inicio).inDays + 1;
  }

  // ============================================================
  // LÓGICA DE DOSIS
  // ============================================================

  int _totalDosisDelDia(List<_Medicamento> medicamentos) {
    int total = 0;

    for (final medicamento in medicamentos) {
      total += medicamento.horarios.length;
    }

    return total;
  }

  int _dosisTomadasDelDia(List<_Medicamento> medicamentos) {
    int total = 0;

    for (final medicamento in medicamentos) {
      for (final hora in medicamento.horarios) {
        if (_dosisEstaTomada(medicamento, _fechaSeleccionada, hora)) {
          total++;
        }
      }
    }

    return total;
  }

  bool _dosisEstaTomada(_Medicamento medicamento, DateTime fecha, String hora) {
    return _dosisTomadas.contains(_claveDosis(medicamento, fecha, hora));
  }

  String _claveDosis(_Medicamento medicamento, DateTime fecha, String hora) {
    final fechaTexto =
        '${fecha.year}-${fecha.month.toString().padLeft(2, '0')}-'
        '${fecha.day.toString().padLeft(2, '0')}';

    return '${medicamento.nombre}-$fechaTexto-$hora';
  }

  void _registrarDosis(_Medicamento medicamento, String hora) {
    final clave = _claveDosis(medicamento, _fechaSeleccionada, hora);

    if (_dosisTomadas.contains(clave)) {
      return;
    }

    setState(() {
      _dosisTomadas.add(clave);
    });

    final medicamentosDelDia = _medicamentosParaFecha(_fechaSeleccionada);

    final total = _totalDosisDelDia(medicamentosDelDia);
    final tomadas = _dosisTomadasDelDia(medicamentosDelDia);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          tomadas == total
              ? '¡Todas las dosis del día fueron registradas!'
              : 'Dosis de las $hora registrada correctamente.',
        ),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  // ============================================================
  // CALENDARIO
  // ============================================================

  List<DateTime> _generarFechasCalendario() {
    final fechas = <DateTime>[];

    // Mostramos un rango amplio para que el paciente
    // pueda consultar tratamientos que comiencen
    // y terminen en fechas diferentes.
    DateTime fecha = DateTime(2026, 10, 1);
    final fin = DateTime(2026, 10, 31);

    while (!fecha.isAfter(fin)) {
      fechas.add(fecha);
      fecha = fecha.add(const Duration(days: 1));
    }

    return fechas;
  }

  void _mostrarCalendario() {
    showDatePicker(
      context: context,
      initialDate: _fechaSeleccionada,
      firstDate: DateTime(2026, 1, 1),
      lastDate: DateTime(2026, 12, 31),
      helpText: 'Selecciona una fecha',
      cancelText: 'Cancelar',
      confirmText: 'Seleccionar',
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: _azulPrincipal,
              onPrimary: Colors.white,
              surface: Colors.white,
              onSurface: _textoPrincipal,
            ),
          ),
          child: child!,
        );
      },
    ).then((fecha) {
      if (fecha != null) {
        setState(() {
          _fechaSeleccionada = fecha;
        });
      }
    });
  }

  // ============================================================
  // UTILIDADES
  // ============================================================

  bool _mismaFecha(DateTime fecha1, DateTime fecha2) {
    return fecha1.year == fecha2.year &&
        fecha1.month == fecha2.month &&
        fecha1.day == fecha2.day;
  }

  String _diaSemana(DateTime fecha) {
    const dias = ['Lun', 'Mar', 'Mié', 'Jue', 'Vie', 'Sáb', 'Dom'];

    return dias[fecha.weekday - 1];
  }

  String _formatearFecha(DateTime fecha) {
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

    return '${fecha.day} de ${meses[fecha.month - 1]} '
        'de ${fecha.year}';
  }

  String _fechaCorta(DateTime fecha) {
    return '${fecha.day.toString().padLeft(2, '0')}/'
        '${fecha.month.toString().padLeft(2, '0')}/'
        '${fecha.year}';
  }
}

// ============================================================
// MODELO DE MEDICAMENTO
// ============================================================

class _Medicamento {
  final String nombre;
  final String tipo;
  final String dosis;
  final String frecuencia;
  final String tiempoTratamiento;

  // Cada medicamento tiene sus propias fechas.
  final DateTime fechaInicio;
  final DateTime fechaFin;

  final List<String> horarios;

  final IconData icono;
  final Color color;
  final Color fondoIcono;

  _Medicamento({
    required this.nombre,
    required this.tipo,
    required this.dosis,
    required this.frecuencia,
    required this.tiempoTratamiento,
    required this.fechaInicio,
    required this.fechaFin,
    required this.horarios,
    required this.icono,
    required this.color,
    required this.fondoIcono,
  });

  int get diasTotales {
    return fechaFin.difference(fechaInicio).inDays + 1;
  }
}
