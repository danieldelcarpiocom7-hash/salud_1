import 'package:flutter/material.dart';

import 'paciente.dart';

class NuevaConsultaPage extends StatefulWidget {
  final Paciente paciente;

  const NuevaConsultaPage({
    super.key,
    required this.paciente,
  });

  @override
  State<NuevaConsultaPage> createState() =>
      _NuevaConsultaPageState();
}

class _NuevaConsultaPageState
    extends State<NuevaConsultaPage> {
  // ==========================================================
  // COLORES
  // ==========================================================

  static const Color _azulPrincipal =
      Color(0xFF1565C0);

  static const Color _azulClaro =
      Color(0xFFE3F2FD);

  static const Color _fondo =
      Color(0xFFF6F8FA);

  static const Color _textoPrincipal =
      Color(0xFF172033);

  static const Color _textoSecundario =
      Color(0xFF607D8B);

  // ==========================================================
  // FORMULARIO
  // ==========================================================

  final _formKey = GlobalKey<FormState>();

  final _motivoController =
      TextEditingController();

  final _sintomasController =
      TextEditingController();

  final _presionController =
      TextEditingController();

  final _frecuenciaCardiacaController =
      TextEditingController();

  final _temperaturaController =
      TextEditingController();

  final _saturacionController =
      TextEditingController();

  final _pesoController =
      TextEditingController();

  final _tallaController =
      TextEditingController();

  final _diagnosticoController =
      TextEditingController();

  final _observacionesClinicasController =
      TextEditingController();

  final _tratamientoController =
      TextEditingController();

  final _medicamentosController =
      TextEditingController();

  final _indicacionesController =
      TextEditingController();

  final _observacionesController =
      TextEditingController();

  @override
  void dispose() {
    _motivoController.dispose();
    _sintomasController.dispose();

    _presionController.dispose();
    _frecuenciaCardiacaController.dispose();
    _temperaturaController.dispose();
    _saturacionController.dispose();
    _pesoController.dispose();
    _tallaController.dispose();

    _diagnosticoController.dispose();
    _observacionesClinicasController.dispose();

    _tratamientoController.dispose();
    _medicamentosController.dispose();

    _indicacionesController.dispose();
    _observacionesController.dispose();

    super.dispose();
  }

  // ==========================================================
  // GUARDAR CONSULTA
  // ==========================================================

  void _guardarConsulta() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    // Por ahora solamente mostramos confirmación.
    // Posteriormente aquí guardaremos la Consulta
    // en Firebase/Firestore.

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Consulta registrada correctamente.',
        ),
        behavior: SnackBarBehavior.floating,
      ),
    );

    // Volvemos a la ficha del paciente.
    Future.delayed(
      const Duration(milliseconds: 700),
      () {
        if (!mounted) {
          return;
        }

        Navigator.pop(context);
      },
    );
  }

  // ==========================================================
  // BUILD
  // ==========================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _fondo,

      appBar: AppBar(
        title: const Text(
          'Nueva consulta',
          style: TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),

        backgroundColor: Colors.white,
        foregroundColor: _textoPrincipal,
        elevation: 0,
        surfaceTintColor: Colors.white,
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),

          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: 900,
              ),

              child: Form(
                key: _formKey,

                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.stretch,

                  children: [
                    _buildPaciente(),

                    const SizedBox(height: 18),

                    _buildSeccionConsulta(),

                    const SizedBox(height: 18),

                    _buildSeccionDiagnostico(),

                    const SizedBox(height: 18),

                    _buildSeccionTratamiento(),

                    const SizedBox(height: 18),

                    _buildSeccionCierre(),

                    const SizedBox(height: 25),

                    _buildBotones(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ==========================================================
  // PACIENTE
  // ==========================================================

  Widget _buildPaciente() {
    return Card(
      elevation: 0,
      color: Colors.white,

      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
        side: BorderSide(
          color: Colors.grey.shade200,
        ),
      ),

      child: Padding(
        padding: const EdgeInsets.all(18),

        child: Row(
          children: [
            CircleAvatar(
              radius: 30,

              backgroundColor: _azulClaro,
              foregroundColor: _azulPrincipal,

              child: Text(
                widget.paciente.nombres.isNotEmpty
                    ? widget.paciente.nombres[0]
                        .toUpperCase()
                    : '?',

                style: const TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(width: 15),

            Expanded(
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,

                children: [
                  const Text(
                    'Paciente',
                    style: TextStyle(
                      fontSize: 13,
                      color: _textoSecundario,
                    ),
                  ),

                  const SizedBox(height: 3),

                  Text(
                    widget.paciente.nombreCompleto,
                    style: const TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                      color: _textoPrincipal,
                    ),
                  ),

                  const SizedBox(height: 3),

                  Text(
                    'DNI: ${widget.paciente.dni} • '
                    '${widget.paciente.edad} años',
                    style: const TextStyle(
                      fontSize: 14,
                      color: _textoSecundario,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ==========================================================
  // SECCIÓN CONSULTA
  // ==========================================================

  Widget _buildSeccionConsulta() {
    return _buildCardSeccion(
      icono: Icons.medical_information_outlined,
      titulo: 'Consulta',

      children: [
        _buildCampo(
          controller: _motivoController,
          label: 'Motivo de consulta',
          hint: 'Describe el motivo principal de la consulta.',
          icono: Icons.help_outline,
          maxLines: 3,
          obligatorio: true,
        ),

        const SizedBox(height: 16),

        _buildCampo(
          controller: _sintomasController,
          label: 'Síntomas',
          hint: 'Describe los síntomas que presenta el paciente.',
          icono: Icons.sick_outlined,
          maxLines: 4,
        ),

        const SizedBox(height: 22),

        const Text(
          'Signos vitales',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: _textoPrincipal,
          ),
        ),

        const SizedBox(height: 12),

        LayoutBuilder(
          builder: (context, constraints) {
            final ancho =
                constraints.maxWidth;

            if (ancho < 600) {
              return Column(
                children: [
                  _buildSignoVital(
                    _presionController,
                    'Presión arterial',
                    '120/80',
                    Icons.favorite_border,
                  ),

                  const SizedBox(height: 12),

                  _buildSignoVital(
                    _frecuenciaCardiacaController,
                    'Frecuencia cardíaca',
                    '70 lpm',
                    Icons.monitor_heart_outlined,
                  ),

                  const SizedBox(height: 12),

                  _buildSignoVital(
                    _temperaturaController,
                    'Temperatura',
                    '36.5 °C',
                    Icons.thermostat_outlined,
                  ),

                  const SizedBox(height: 12),

                  _buildSignoVital(
                    _saturacionController,
                    'Saturación O₂',
                    '98 %',
                    Icons.air,
                  ),

                  const SizedBox(height: 12),

                  _buildSignoVital(
                    _pesoController,
                    'Peso',
                    '70 kg',
                    Icons.monitor_weight_outlined,
                  ),

                  const SizedBox(height: 12),

                  _buildSignoVital(
                    _tallaController,
                    'Talla',
                    '1.70 m',
                    Icons.height,
                  ),
                ],
              );
            }

            return Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: _buildSignoVital(
                        _presionController,
                        'Presión arterial',
                        '120/80',
                        Icons.favorite_border,
                      ),
                    ),

                    const SizedBox(width: 12),

                    Expanded(
                      child: _buildSignoVital(
                        _frecuenciaCardiacaController,
                        'Frecuencia cardíaca',
                        '70 lpm',
                        Icons.monitor_heart_outlined,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 12),

                Row(
                  children: [
                    Expanded(
                      child: _buildSignoVital(
                        _temperaturaController,
                        'Temperatura',
                        '36.5 °C',
                        Icons.thermostat_outlined,
                      ),
                    ),

                    const SizedBox(width: 12),

                    Expanded(
                      child: _buildSignoVital(
                        _saturacionController,
                        'Saturación O₂',
                        '98 %',
                        Icons.air,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 12),

                Row(
                  children: [
                    Expanded(
                      child: _buildSignoVital(
                        _pesoController,
                        'Peso',
                        '70 kg',
                        Icons.monitor_weight_outlined,
                      ),
                    ),

                    const SizedBox(width: 12),

                    Expanded(
                      child: _buildSignoVital(
                        _tallaController,
                        'Talla',
                        '1.70 m',
                        Icons.height,
                      ),
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ],
    );
  }

  // ==========================================================
  // SECCIÓN DIAGNÓSTICO
  // ==========================================================

  Widget _buildSeccionDiagnostico() {
    return _buildCardSeccion(
      icono: Icons.assignment_outlined,
      titulo: 'Diagnóstico',

      children: [
        _buildCampo(
          controller: _diagnosticoController,
          label: 'Diagnóstico',
          hint: 'Ingresa el diagnóstico médico.',
          icono: Icons.local_hospital_outlined,
          maxLines: 3,
          obligatorio: true,
        ),

        const SizedBox(height: 16),

        _buildCampo(
          controller:
              _observacionesClinicasController,
          label: 'Observaciones clínicas',
          hint:
              'Registra hallazgos u observaciones relevantes.',
          icono: Icons.notes_outlined,
          maxLines: 4,
        ),
      ],
    );
  }

  // ==========================================================
  // SECCIÓN TRATAMIENTO
  // ==========================================================

  Widget _buildSeccionTratamiento() {
    return _buildCardSeccion(
      icono: Icons.medication_outlined,
      titulo: 'Tratamiento',

      children: [
        _buildCampo(
          controller: _tratamientoController,
          label: 'Tratamiento',
          hint: 'Describe el tratamiento indicado.',
          icono: Icons.medical_services_outlined,
          maxLines: 4,
        ),

        const SizedBox(height: 16),

        _buildCampo(
          controller: _medicamentosController,
          label: 'Medicamentos / receta',
          hint:
              'Registra medicamentos, dosis, frecuencia y duración.',
          icono: Icons.medication_outlined,
          maxLines: 5,
        ),
      ],
    );
  }

  // ==========================================================
  // SECCIÓN CIERRE
  // ==========================================================

  Widget _buildSeccionCierre() {
    return _buildCardSeccion(
      icono: Icons.check_circle_outline,
      titulo: 'Indicaciones y cierre',

      children: [
        _buildCampo(
          controller: _indicacionesController,
          label: 'Indicaciones',
          hint:
              'Indica recomendaciones para el paciente.',
          icono: Icons.assignment_turned_in_outlined,
          maxLines: 4,
        ),

        const SizedBox(height: 16),

        _buildCampo(
          controller: _observacionesController,
          label: 'Observaciones',
          hint:
              'Agrega información adicional de la consulta.',
          icono: Icons.chat_outlined,
          maxLines: 4,
        ),
      ],
    );
  }

  // ==========================================================
  // CARD DE SECCIÓN
  // ==========================================================

  Widget _buildCardSeccion({
    required IconData icono,
    required String titulo,
    required List<Widget> children,
  }) {
    return Card(
      elevation: 0,
      color: Colors.white,

      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
        side: BorderSide(
          color: Colors.grey.shade200,
        ),
      ),

      child: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,

          children: [
            Row(
              children: [
                Container(
                  width: 38,
                  height: 38,

                  decoration: BoxDecoration(
                    color: _azulClaro,
                    borderRadius:
                        BorderRadius.circular(9),
                  ),

                  child: Icon(
                    icono,
                    color: _azulPrincipal,
                    size: 21,
                  ),
                ),

                const SizedBox(width: 12),

                Text(
                  titulo,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: _textoPrincipal,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 22),

            ...children,
          ],
        ),
      ),
    );
  }

  // ==========================================================
  // CAMPO
  // ==========================================================

  Widget _buildCampo({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icono,
    int maxLines = 1,
    bool obligatorio = false,
  }) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,

      decoration: InputDecoration(
        labelText: obligatorio
            ? '$label *'
            : label,

        hintText: hint,

        prefixIcon: Icon(
          icono,
          color: _textoSecundario,
        ),

        alignLabelWithHint:
            maxLines > 1,

        filled: true,
        fillColor: const Color(0xFFFAFBFC),

        border: OutlineInputBorder(
          borderRadius:
              BorderRadius.circular(10),
          borderSide: BorderSide(
            color: Colors.grey.shade300,
          ),
        ),

        enabledBorder:
            OutlineInputBorder(
          borderRadius:
              BorderRadius.circular(10),
          borderSide: BorderSide(
            color: Colors.grey.shade300,
          ),
        ),

        focusedBorder:
            OutlineInputBorder(
          borderRadius:
              BorderRadius.circular(10),
          borderSide:
              const BorderSide(
            color: _azulPrincipal,
            width: 1.5,
          ),
        ),
      ),

      validator: obligatorio
          ? (value) {
              if (value == null ||
                  value.trim().isEmpty) {
                return 'Este campo es obligatorio';
              }

              return null;
            }
          : null,
    );
  }

  // ==========================================================
  // SIGNO VITAL
  // ==========================================================

  Widget _buildSignoVital(
    TextEditingController controller,
    String label,
    String hint,
    IconData icono,
  ) {
    return TextFormField(
      controller: controller,

      decoration: InputDecoration(
        labelText: label,
        hintText: hint,

        prefixIcon: Icon(
          icono,
          color: _textoSecundario,
        ),

        filled: true,
        fillColor: const Color(0xFFFAFBFC),

        border: OutlineInputBorder(
          borderRadius:
              BorderRadius.circular(10),

          borderSide: BorderSide(
            color: Colors.grey.shade300,
          ),
        ),

        enabledBorder:
            OutlineInputBorder(
          borderRadius:
              BorderRadius.circular(10),

          borderSide: BorderSide(
            color: Colors.grey.shade300,
          ),
        ),

        focusedBorder:
            OutlineInputBorder(
          borderRadius:
              BorderRadius.circular(10),

          borderSide:
              const BorderSide(
            color: _azulPrincipal,
            width: 1.5,
          ),
        ),
      ),
    );
  }

  // ==========================================================
  // BOTONES
  // ==========================================================

  Widget _buildBotones() {
    return Row(
      mainAxisAlignment:
          MainAxisAlignment.end,

      children: [
        OutlinedButton(
          onPressed: () {
            Navigator.pop(context);
          },

          style: OutlinedButton.styleFrom(
            foregroundColor: _textoPrincipal,

            padding:
                const EdgeInsets.symmetric(
              horizontal: 22,
              vertical: 14,
            ),

            shape:
                RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.circular(9),
            ),
          ),

          child: const Text(
            'Cancelar',
          ),
        ),

        const SizedBox(width: 12),

        ElevatedButton.icon(
          onPressed: _guardarConsulta,

          style: ElevatedButton.styleFrom(
            backgroundColor:
                _azulPrincipal,

            foregroundColor:
                Colors.white,

            elevation: 0,

            padding:
                const EdgeInsets.symmetric(
              horizontal: 22,
              vertical: 14,
            ),

            shape:
                RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.circular(9),
            ),
          ),

          icon: const Icon(
            Icons.save_outlined,
          ),

          label: const Text(
            'Guardar consulta',
            style: TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}