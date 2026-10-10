import 'package:flutter/material.dart';

import 'paciente.dart';
import 'home_medico_page.dart';

class ConsultasPage extends StatefulWidget {
  final Paciente? paciente;

  const ConsultasPage({
    super.key,
    this.paciente,
  });

  @override
  State<ConsultasPage> createState() =>
      _ConsultasPageState();
}

class _ConsultasPageState
    extends State<ConsultasPage> {
  final TextEditingController _buscarController =
      TextEditingController();

  String _filtroFecha = 'Todas';

  // ==========================================================
  // COLORES
  // ==========================================================

  static const Color _azulPrincipal =
      Color(0xFF1565C0);

  static const Color _azulClaro =
      Color(0xFFE3F2FD);

  static const Color _fondo =
      Color(0xFFF5F7FA);

  static const Color _textoPrincipal =
      Color(0xFF172033);

  static const Color _textoSecundario =
      Color(0xFF607D8B);

  // ==========================================================
  // INIT
  // ==========================================================

  @override
  void initState() {
    super.initState();

    _buscarController.addListener(
      () {
        setState(() {});
      },
    );
  }

  // ==========================================================
  // DISPOSE
  // ==========================================================

  @override
  void dispose() {
    _buscarController.dispose();
    super.dispose();
  }

  // ==========================================================
  // BUILD
  // ==========================================================

  @override
  Widget build(BuildContext context) {
    final bool esPacienteEspecifico =
        widget.paciente != null;

    return Scaffold(
      backgroundColor: _fondo,

      // ======================================================
      // APP BAR
      // ======================================================

      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: _textoPrincipal,
        elevation: 0,
        surfaceTintColor: Colors.white,

        title: Text(
          esPacienteEspecifico
              ? 'Consultas del paciente'
              : 'Consultas médicas',

          style: const TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),

        // ====================================================
        // BOTÓN HOME
        // ====================================================

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

      // ======================================================
      // BODY
      // ======================================================

      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: 1150,
            ),

            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),

              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.stretch,

                children: [
                  // ============================================
                  // ENCABEZADO
                  // ============================================

                  _buildEncabezado(),

                  const SizedBox(height: 24),

                  // ============================================
                  // INDICADORES
                  // ============================================

                  _buildIndicadores(),

                  const SizedBox(height: 24),

                  // ============================================
                  // FILTROS
                  // ============================================

                  _buildPanelFiltros(),

                  const SizedBox(height: 20),

                  // ============================================
                  // RESULTADOS
                  // ============================================

                  _buildResultados(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ==========================================================
  // ENCABEZADO
  // ==========================================================

  Widget _buildEncabezado() {
    return LayoutBuilder(
      builder: (
        context,
        constraints,
      ) {
        if (constraints.maxWidth < 650) {
          return Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,

            children: [
              _buildTextoEncabezado(),

              if (widget.paciente != null) ...[
                const SizedBox(height: 15),

                _buildBotonNuevaConsulta(),
              ],
            ],
          );
        }

        return Row(
          crossAxisAlignment:
              CrossAxisAlignment.start,

          children: [
            Expanded(
              child: _buildTextoEncabezado(),
            ),

            if (widget.paciente != null) ...[
              const SizedBox(width: 20),

              _buildBotonNuevaConsulta(),
            ],
          ],
        );
      },
    );
  }

  // ==========================================================
  // TEXTO DEL ENCABEZADO
  // ==========================================================

  Widget _buildTextoEncabezado() {
    return Column(
      crossAxisAlignment:
          CrossAxisAlignment.start,

      children: [
        Text(
          widget.paciente == null
              ? 'Consultas médicas'
              : 'Consultas de ${widget.paciente!.nombreCompleto}',

          style: const TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: _textoPrincipal,
          ),
        ),

        const SizedBox(height: 7),

        Text(
          widget.paciente == null
              ? 'Consulta y gestiona las atenciones médicas realizadas a tus pacientes.'
              : 'Historial de atenciones médicas registradas para este paciente.',

          style: const TextStyle(
            fontSize: 15,
            color: _textoSecundario,
          ),
        ),
      ],
    );
  }

  // ==========================================================
  // BOTÓN NUEVA CONSULTA
  // ==========================================================

  Widget _buildBotonNuevaConsulta() {
    return ElevatedButton.icon(
      onPressed: () {
        ScaffoldMessenger.of(context)
            .showSnackBar(
          const SnackBar(
            content: Text(
              'Nueva consulta',
            ),
          ),
        );
      },

      style: ElevatedButton.styleFrom(
        backgroundColor: _azulPrincipal,
        foregroundColor: Colors.white,
        elevation: 0,

        padding:
            const EdgeInsets.symmetric(
          horizontal: 18,
          vertical: 14,
        ),

        shape:
            RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(9),
        ),
      ),

      icon: const Icon(
        Icons.add,
        size: 19,
      ),

      label: const Text(
        'Nueva consulta',
        style: TextStyle(
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  // ==========================================================
  // INDICADORES
  // ==========================================================

  Widget _buildIndicadores() {
    return LayoutBuilder(
      builder: (
        context,
        constraints,
      ) {
        if (constraints.maxWidth < 650) {
          return Column(
            children: [
              _buildIndicador(
                icono:
                    Icons.medical_services_outlined,
                titulo: 'Total consultas',
                valor: '0',
                descripcion: 'Registradas',
              ),

              const SizedBox(height: 12),

              _buildIndicador(
                icono:
                    Icons.today_outlined,
                titulo: 'Consultas hoy',
                valor: '0',
                descripcion: 'Atenciones',
              ),

              const SizedBox(height: 12),

              _buildIndicador(
                icono:
                    Icons.pending_actions_outlined,
                titulo: 'Pendientes',
                valor: '0',
                descripcion: 'Por atender',
              ),
            ],
          );
        }

        return Row(
          children: [
            Expanded(
              child: _buildIndicador(
                icono:
                    Icons.medical_services_outlined,
                titulo: 'Total consultas',
                valor: '0',
                descripcion: 'Registradas',
              ),
            ),

            const SizedBox(width: 14),

            Expanded(
              child: _buildIndicador(
                icono:
                    Icons.today_outlined,
                titulo: 'Consultas hoy',
                valor: '0',
                descripcion: 'Atenciones',
              ),
            ),

            const SizedBox(width: 14),

            Expanded(
              child: _buildIndicador(
                icono:
                    Icons.pending_actions_outlined,
                titulo: 'Pendientes',
                valor: '0',
                descripcion: 'Por atender',
              ),
            ),
          ],
        );
      },
    );
  }

  // ==========================================================
  // INDICADOR
  // ==========================================================

  Widget _buildIndicador({
    required IconData icono,
    required String titulo,
    required String valor,
    required String descripcion,
  }) {
    return Container(
      padding: const EdgeInsets.all(18),

      decoration: BoxDecoration(
        color: Colors.white,

        borderRadius:
            BorderRadius.circular(14),

        border: Border.all(
          color: Colors.grey.shade200,
        ),
      ),

      child: Row(
        children: [
          Container(
            width: 46,
            height: 46,

            decoration: BoxDecoration(
              color: _azulClaro,

              borderRadius:
                  BorderRadius.circular(11),
            ),

            child: Icon(
              icono,
              color: _azulPrincipal,
              size: 23,
            ),
          ),

          const SizedBox(width: 14),

          Expanded(
            child: Column(
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

                const SizedBox(height: 3),

                Row(
                  crossAxisAlignment:
                      CrossAxisAlignment.end,

                  children: [
                    Text(
                      valor,

                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight:
                            FontWeight.bold,
                        color:
                            _textoPrincipal,
                      ),
                    ),

                    const SizedBox(width: 7),

                    Padding(
                      padding:
                          const EdgeInsets.only(
                        bottom: 3,
                      ),

                      child: Text(
                        descripcion,

                        style:
                            const TextStyle(
                          fontSize: 12,
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

  // ==========================================================
  // PANEL DE FILTROS
  // ==========================================================

  Widget _buildPanelFiltros() {
    return Container(
      padding: const EdgeInsets.all(18),

      decoration: BoxDecoration(
        color: Colors.white,

        borderRadius:
            BorderRadius.circular(14),

        border: Border.all(
          color: Colors.grey.shade200,
        ),
      ),

      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,

        children: [
          Row(
            children: [
              const Icon(
                Icons.filter_list_outlined,
                color: _textoSecundario,
                size: 21,
              ),

              const SizedBox(width: 9),

              const Text(
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

          const SizedBox(height: 15),

          LayoutBuilder(
            builder: (
              context,
              constraints,
            ) {
              if (constraints.maxWidth < 650) {
                return Column(
                  children: [
                    _buildBuscador(),

                    const SizedBox(height: 12),

                    _buildFiltros(),
                  ],
                );
              }

              return Row(
                children: [
                  Expanded(
                    child: _buildBuscador(),
                  ),

                  const SizedBox(width: 14),

                  _buildFiltros(),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  // ==========================================================
  // BUSCADOR
  // ==========================================================

  Widget _buildBuscador() {
    return TextField(
      controller: _buscarController,

      decoration: InputDecoration(
        hintText:
            'Buscar paciente, motivo o diagnóstico',

        prefixIcon: const Icon(
          Icons.search,
          size: 21,
        ),

        suffixIcon:
            _buscarController.text.isNotEmpty
                ? IconButton(
                    tooltip: 'Limpiar',

                    icon: const Icon(
                      Icons.clear,
                      size: 20,
                    ),

                    onPressed: () {
                      _buscarController.clear();
                    },
                  )
                : null,

        filled: true,

        fillColor:
            const Color(0xFFF8FAFC),

        contentPadding:
            const EdgeInsets.symmetric(
          vertical: 14,
        ),

        border: OutlineInputBorder(
          borderRadius:
              BorderRadius.circular(9),

          borderSide: BorderSide(
            color: Colors.grey.shade200,
          ),
        ),

        enabledBorder:
            OutlineInputBorder(
          borderRadius:
              BorderRadius.circular(9),

          borderSide: BorderSide(
            color: Colors.grey.shade200,
          ),
        ),

        focusedBorder:
            OutlineInputBorder(
          borderRadius:
              BorderRadius.circular(9),

          borderSide:
              const BorderSide(
            color: _azulPrincipal,
          ),
        ),
      ),
    );
  }

  // ==========================================================
  // FILTROS
  // ==========================================================

  Widget _buildFiltros() {
    return Wrap(
      spacing: 7,
      runSpacing: 7,

      children: [
        _buildFiltro('Todas'),
        _buildFiltro('Hoy'),
        _buildFiltro('Esta semana'),
        _buildFiltro('Este mes'),
      ],
    );
  }

  // ==========================================================
  // FILTRO
  // ==========================================================

  Widget _buildFiltro(
    String texto,
  ) {
    final bool seleccionado =
        _filtroFecha == texto;

    return ChoiceChip(
      label: Text(texto),

      selected: seleccionado,

      onSelected: (_) {
        setState(() {
          _filtroFecha = texto;
        });
      },

      selectedColor:
          _azulClaro,

      backgroundColor:
          Colors.white,

      side: BorderSide(
        color: seleccionado
            ? _azulClaro
            : Colors.grey.shade300,
      ),

      labelStyle: TextStyle(
        fontSize: 13,

        color: seleccionado
            ? _azulPrincipal
            : _textoSecundario,

        fontWeight: seleccionado
            ? FontWeight.w600
            : FontWeight.normal,
      ),

      avatar: seleccionado
          ? const Icon(
              Icons.check,
              size: 16,
              color: _azulPrincipal,
            )
          : null,
    );
  }

  // ==========================================================
  // RESULTADOS
  // ==========================================================

  Widget _buildResultados() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,

        borderRadius:
            BorderRadius.circular(14),

        border: Border.all(
          color: Colors.grey.shade200,
        ),
      ),

      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.stretch,

        children: [
          // ====================================================
          // CABECERA
          // ====================================================

          Padding(
            padding: const EdgeInsets.all(18),

            child: Row(
              children: [
                const Text(
                  'Registro de consultas',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight:
                        FontWeight.w600,
                    color:
                        _textoPrincipal,
                  ),
                ),

                const Spacer(),

                const Text(
                  '0 resultados',
                  style: TextStyle(
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
            color: Colors.grey.shade200,
          ),

          // ====================================================
          // ESTADO VACÍO
          // ====================================================

          SizedBox(
            height: 390,
            child: _buildEstadoVacio(),
          ),
        ],
      ),
    );
  }

  // ==========================================================
  // ESTADO VACÍO
  // ==========================================================

  Widget _buildEstadoVacio() {
    final bool hayBusqueda =
        _buscarController.text.isNotEmpty;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(40),

        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.center,

          children: [
            Container(
              width: 76,
              height: 76,

              decoration: BoxDecoration(
                color: _azulClaro,

                borderRadius:
                    BorderRadius.circular(18),
              ),

              child: const Icon(
                Icons.folder_open_outlined,
                size: 36,
                color: _azulPrincipal,
              ),
            ),

            const SizedBox(height: 18),

            Text(
              hayBusqueda
                  ? 'No se encontraron resultados'
                  : 'Aún no hay consultas registradas',

              textAlign:
                  TextAlign.center,

              style: const TextStyle(
                fontSize: 18,
                fontWeight:
                    FontWeight.w600,
                color:
                    _textoPrincipal,
              ),
            ),

            const SizedBox(height: 7),

            SizedBox(
              width: 430,

              child: Text(
                hayBusqueda
                    ? 'Prueba con otro paciente, motivo o diagnóstico.'
                    : widget.paciente == null
                        ? 'Cuando se registren consultas médicas, aparecerán aquí para su seguimiento y consulta.'
                        : 'Las consultas registradas para este paciente aparecerán aquí.',

                textAlign:
                    TextAlign.center,

                style: const TextStyle(
                  fontSize: 14,
                  height: 1.5,
                  color:
                      _textoSecundario,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}